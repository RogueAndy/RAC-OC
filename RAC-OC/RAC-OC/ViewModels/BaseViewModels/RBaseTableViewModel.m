//
//  RBaseTableViewModel.m
//  RAC-OC
//
//  Created by rogue on 2017/3/1.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import "RBaseTableViewModel.h"
#import "ReactiveCocoa.h"
#import "AFNetWorking.h"
#import "RBaseTableViewCell.h"

@implementation RBaseTableViewModel

- (instancetype)init {

    if(self = [super init]) {
    
        [self initialBind];
    
    }
    
    return self;

}

- (void)initialBind {

    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {

        RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"------------- requestSignal");
            
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            parameters[@"q"] = @"基础";
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            [manager GET:@"https://api.douban.com/v2/book/search"
              parameters:parameters
                progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     NSLog(@"------------ sendNext");
                     [subscriber sendNext:responseObject];
                     [subscriber sendCompleted];
                 }
                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     NSLog(@"------------ error:%@", error);
                 }];
            
            return nil;
        }];
        
        return [requestSignal map:^id(NSDictionary *value) {
    
            NSMutableArray *dicArr = value[@"books"];
            NSArray *modelArr = [[dicArr.rac_sequence map:^id(id value) {
                return [self.modelType modelWithDict:value];
            }] array];
            
            return modelArr;
            
        }];
        
    }];
    
}

#pragma mark - tableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.models.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *identifier = NSStringFromClass(self.cellType);
    RBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell) {
    
        cell = [[self.cellType alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    [cell setModel:[self.models objectAtIndex:indexPath.row]];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 75;

}

@end
