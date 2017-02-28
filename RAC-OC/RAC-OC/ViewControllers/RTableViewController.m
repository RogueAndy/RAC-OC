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

//    UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
//    sender.frame = CGRectMake(40, 200, self.view.frame.size.width - 80, 40);
//    sender.backgroundColor = [UIColor redColor];
//    [[sender rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        LoginViewController *login = [[LoginViewController alloc] init];
//        [self.navigationController pushViewController:login animated:YES];
//    }];
//    [self.view addSubview:sender];
    
    self.table = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.table.dataSource = self.requestViewModel;
    self.table.delegate = self.requestViewModel;
    [self.view addSubview:self.table];
    
    RACSignal *requestSignal = [self.requestViewModel.requestCommand execute:nil];
    [requestSignal subscribeNext:^(NSArray *x) {
        NSLog(@"----%lu", (unsigned long)x.count);
        self.requestViewModel.models = x;
        [self.table reloadData];
    }];

}

- (void)dealloc {
    
    NSLog(@"-----------------------RTableViewController");
    
}


@end
