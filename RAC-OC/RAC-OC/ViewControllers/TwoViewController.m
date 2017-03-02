//
//  TwoViewController.m
//  RAC-OC
//
//  Created by rogue on 2017/2/23.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import "TwoViewController.h"
#import "ReactiveCocoa.h"
#import "RTableViewController.h"
#import "LoginViewController.h"

@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
    sender.frame = CGRectMake(20, 100, self.view.frame.size.width - 40, 40);
    sender.backgroundColor = [UIColor redColor];
    [sender addTarget:self action:@selector(notice:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sender];
    
}

- (void)notice:(UIButton *)sender {

    RTableViewController *vc = [[RTableViewController alloc] init];
//    LoginViewController *vc = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}

@end
