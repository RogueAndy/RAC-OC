//
//  RequestViewModel.m
//  RAC-OC
//
//  Created by rogue on 2017/2/23.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import "RequestViewModel.h"
#import "ReactiveCocoa.h"
#import "AFNetworking.h"
#import "Book.h"
#import "RTableViewCell.h"

@implementation RequestViewModel

- (instancetype)init {

    if(self = [super init]) {
    
        [self initialBind];
    
    }
    
    return self;

}

- (void)initialBind {

    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            NSLog(@"----requestSignal");
            
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            parameters[@"q"] = @"基础";
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            [manager GET:@"https://api.douban.com/v2/book/search"
              parameters:parameters
                progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     NSLog(@"---- sendNext");
                     [subscriber sendNext:responseObject];
                     [subscriber sendCompleted];
                 }
                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     NSLog(@"%@", error);
                 }];
            return nil;
        }];
        
        return [requestSignal map:^id(NSDictionary *value) {
            
            NSLog(@"----map111");
            NSMutableArray *dictArr = value[@"books"];
            NSArray *modelArr = [[dictArr.rac_sequence map:^id(id value) {
                NSLog(@"----map222");
                return [Book bookWithDict:value];
            }] array];
            
            return modelArr;
            
        }];
        
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.models.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"RTableViewCell";
    RTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell) {
    
        cell = [[RTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    Book *book = self.models[indexPath.row];
    cell.subLabel.text = book.subtitle;
    cell.titLabel.text = book.title;
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 80;

}

@end
