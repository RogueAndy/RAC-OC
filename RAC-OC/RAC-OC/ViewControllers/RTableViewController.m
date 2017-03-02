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
    [self loadBaseView];
    
}

- (void)loadBaseView {
    
    self.table = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.table.dataSource = self.requestViewModel;
    self.table.delegate = self.requestViewModel;
    self.requestViewModel.table = self.table;
    [self.view addSubview:self.table];
    
    self.requestViewModel.headLoading = YES;
}

- (void)dealloc {
    
    NSLog(@"-----------------------RTableViewController");
    
}


@end
