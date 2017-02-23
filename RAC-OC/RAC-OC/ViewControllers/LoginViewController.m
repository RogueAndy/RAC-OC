//
//  LoginViewController.m
//  RAC-OC
//
//  Created by rogue on 2017/2/23.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "ReactiveCocoa.h"

@interface LoginViewController ()

@property (nonatomic, strong) LoginViewModel *loginViewModel;

@property (nonatomic, strong) UITextField *accountField;

@property (nonatomic, strong) UITextField *pawdField;

@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation LoginViewController

- (LoginViewModel *)loginViewModel {

    if(!_loginViewModel) {
    
        _loginViewModel = [[LoginViewModel alloc] init];
    
    }
    
    return _loginViewModel;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:245/255.f green:240/255.f blue:240/255.f alpha:1];
    [self loadBaseView];
    [self bindModel];
    
}

- (void)bindModel {

    RAC(self.loginViewModel.account, account) = _accountField.rac_textSignal;
    RAC(self.loginViewModel.account, pwd) = _pawdField.rac_textSignal;
    RAC(self.loginBtn, enabled) = self.loginViewModel.enableLoginSignal;
    
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"哈哈哈哈哈或");
        [self.loginViewModel.loginCommand execute:nil];
    }];
}

- (void)loadBaseView {

    self.accountField = [[UITextField alloc] initWithFrame:CGRectMake(40, 200, self.view.frame.size.width - 80, 35)];
    self.accountField.backgroundColor = [UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:1];
    self.accountField.font = [UIFont systemFontOfSize:15];
    self.accountField.textColor = [UIColor colorWithRed:70/255.f green:70/255.f blue:70/255.f alpha:1];
    self.accountField.placeholder = @"用户名";
    
    self.pawdField = [[UITextField alloc] initWithFrame:CGRectMake(40, 250, self.view.frame.size.width - 80, 35)];
    self.pawdField.backgroundColor = [UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:1];
    self.pawdField.font = [UIFont systemFontOfSize:15];
    self.pawdField.textColor = [UIColor colorWithRed:70/255.f green:70/255.f blue:70/255.f alpha:1];
    self.pawdField.placeholder = @"密码";
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(60, 300, self.view.frame.size.width - 120, 35);
    [self.loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    self.loginBtn.backgroundColor = [UIColor orangeColor];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:self.accountField];
    [self.view addSubview:self.pawdField];
    [self.view addSubview:self.loginBtn];
}

@end
