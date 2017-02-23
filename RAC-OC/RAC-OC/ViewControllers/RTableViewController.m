//
//  RTableViewController.m
//  RAC-OC
//
//  Created by rogue on 2017/2/23.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import "RTableViewController.h"

@interface RTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;

@end

@implementation RTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)loadBaseView {

    self.table = [[UITableView alloc] initWithFrame:CGRectZero];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];

}



@end
