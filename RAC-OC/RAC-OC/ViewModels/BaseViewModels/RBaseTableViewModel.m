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
#import "MJRefresh.h"

@interface RBaseTableViewModel()

@property (nonatomic, assign) NSInteger countRefresh;

@property (nonatomic, strong) NSArray *select_parameters;

@property (nonatomic, strong, readwrite) NSMutableArray *models;

@end

@implementation RBaseTableViewModel

- (instancetype)init {

    if(self = [super init]) {
    
        [self initialBind];
    
    }
    
    return self;

}

- (void)initialBind {

    _countRefresh = 0;
    _select_parameters = @[@"阿", @"波", @"吃", @"对", @"恶", @"发", @"给", @"话", @"家"];
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {

        RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"------------- requestSignal");
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            [manager GET:@"https://api.douban.com/v2/book/search"
              parameters:self.netParameters
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {}

#pragma mark - 外部设置 Setting

- (void)setHeadLoading:(BOOL)headLoading {

    _headLoading = headLoading;
    [self.table.mj_header beginRefreshing];

}

- (void)setFooterLoading:(BOOL)footerLoading {

    _footerLoading = footerLoading;
    [self.table.mj_footer beginRefreshing];

}

- (void)setTable:(UITableView *)table {

    _table = table;
    
    @weakify(self);
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        self.countRefresh = 0;
        self.netParameters = [@{@"q": self.select_parameters[self.countRefresh]} mutableCopy];
        [[self.requestCommand execute:nil] subscribeNext:^(NSArray *x) {
            self.models = [x mutableCopy];
            [self.table reloadData];
            [self.table.mj_header endRefreshing];
        }];
        
    }];
    
    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        @strongify(self);
        self.countRefresh += 1;
        self.netParameters = [@{@"q": self.select_parameters[self.countRefresh]} mutableCopy];
        [[self.requestCommand execute:nil] subscribeNext:^(NSArray *x) {
            [self.models addObjectsFromArray:x];
            [self.table reloadData];
            [self.table.mj_footer endRefreshing];
        }];
    }];
    
}

@end
