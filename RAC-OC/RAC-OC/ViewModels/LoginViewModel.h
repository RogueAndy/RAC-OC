//
//  LoginViewModel.h
//  RAC-OC
//
//  Created by rogue on 2017/2/23.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import "RBaseViewModel.h"
#import "Account.h"

@class RACSignal, RACCommand;

// 在获取网络数据的时候，如果需要显示 MBProgressHUD，那么需要调用 [RACCommand execute:nil] 传入参数为 view,否则不会调用 MBProgressHUD

@interface LoginViewModel : RBaseViewModel

@property (nonatomic, strong) Account *account;

@property (nonatomic, strong, readonly) RACSignal *enableLoginSignal;

@property (nonatomic, strong, readonly) RACCommand *loginCommand;

@end
