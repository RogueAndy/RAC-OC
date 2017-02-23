//
//  LoginViewModel.h
//  RAC-OC
//
//  Created by rogue on 2017/2/23.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@class RACSignal, RACCommand;

@interface LoginViewModel : NSObject

@property (nonatomic, strong) Account *account;

@property (nonatomic, strong, readonly) RACSignal *enableLoginSignal;

@property (nonatomic, strong, readonly) RACCommand *loginCommand;

@end
