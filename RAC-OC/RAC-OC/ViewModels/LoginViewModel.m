//
//  LoginViewModel.m
//  RAC-OC
//
//  Created by rogue on 2017/2/23.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import "LoginViewModel.h"
#import "ReactiveCocoa.h"
#import "MBProgressHUD.h"

@interface LoginViewModel()

@property (nonatomic, strong) NSString *testString;

/**
 因为网络加载需要显示在某个 View 控件上，所以传入一个 View，来记录当前显示的 View
 */
@property (nonatomic, strong) UIView *progressShowInView;

@end

@implementation LoginViewModel

- (Account *)account {

    if(!_account) {
    
        _account = [[Account alloc] init];
    
    }
    
    return _account;

}

- (instancetype)init {

    if(self = [super init]) {
    
        [self initialBind];
    
    }
    
    return self;

}

- (void)initialBind {

    _enableLoginSignal = [RACSignal combineLatest:@[RACObserve(self.account, account), RACObserve(self.account, pwd)]
                                           reduce:^id(NSString *account, NSString *pwd) {
                                               return @(account.length && pwd.length);
                                           }];
    
    @weakify(self);
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"点击了登录");
        self.progressShowInView = input;
        @strongify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendNext:@"登陆成功"];
//                MBProgressHUD *weakSelf = [MBProgressHUD showHUDAddedTo:self.progressShowInView animated:YES];
//                weakSelf.label.text = @"登陆完成";
                [subscriber sendCompleted];
            });
            
            return nil;
        }];
    }];
    
    [_loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        if([x isEqualToString:@"登陆成功"]) {
        
            NSLog(@"登陆成功");
        
        }
    }];
    
    [[_loginCommand.executing skip:1] subscribeNext:^(id x) {
        
        if(!self.progressShowInView || ![self.progressShowInView isKindOfClass:[UIView class]]) {
        
            return;
            
        }
        
        if([x isEqualToNumber:@(YES)]) {
            
            [MBProgressHUD showHUDAddedTo:self.progressShowInView animated:YES];
        
        } else {
    
            [MBProgressHUD hideHUDForView:self.progressShowInView animated:YES];
            
        }
    }];
    
}

@end
