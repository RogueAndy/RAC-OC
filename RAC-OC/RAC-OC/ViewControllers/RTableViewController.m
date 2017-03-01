//
//  RTableViewController.m
//  RAC-OC
//
//  Created by rogue on 2017/2/23.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import "RTableViewController.h"
#import "ReactiveCocoa.h"
#import "LoginViewController.h"
#import "RequestViewModel.h"
#import "MJRefresh.h"

@interface RTableViewController ()

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) RequestViewModel *requestViewModel;

@property (nonatomic, strong) RACSignal *requestSignal;

@property (nonatomic, assign) NSInteger countRefresh;

@end

@implementation RTableViewController

- (RequestViewModel *)requestViewModel {

    if(!_requestViewModel) {
    
        _requestViewModel = [[RequestViewModel alloc] init];
        
    }
    
    return _requestViewModel;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.countRefresh = 0;
    [self loadBaseView];
    
}

- (void)loadBaseView {
    
    NSArray *select_parameters = @[@"阿", @"波", @"吃", @"对", @"恶", @"发", @"给", @"话", @"家"];
    
    self.table = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.table.dataSource = self.requestViewModel;
    self.table.delegate = self.requestViewModel;
    [self.view addSubview:self.table];
    
    @weakify(self);
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        self.countRefresh = 0;
        self.requestViewModel.netParameters = [@{@"q": select_parameters[self.countRefresh]} mutableCopy];
        self.requestSignal = [self.requestViewModel.requestCommand execute:nil];
        [self.requestSignal subscribeNext:^(NSArray *x) {
            self.requestViewModel.models = [x mutableCopy];
            [self.table reloadData];
            [self.table.mj_header endRefreshing];
        }];
        
    }];
    [self.table.mj_header beginRefreshing];
    
    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        @strongify(self);
        self.countRefresh += 1;
        self.requestViewModel.netParameters = [@{@"q": select_parameters[self.countRefresh]} mutableCopy];
        self.requestSignal = [self.requestViewModel.requestCommand execute:nil];
        [self.requestSignal subscribeNext:^(NSArray *x) {
            [self.requestViewModel.models addObjectsFromArray:x];
            [self.table reloadData];
            [self.table.mj_footer endRefreshing];
        }];
    }];

}

- (void)dealloc {
    
    NSLog(@"-----------------------RTableViewController");
    
}


@end
