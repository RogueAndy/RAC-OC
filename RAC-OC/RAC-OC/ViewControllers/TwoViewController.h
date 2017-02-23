//
//  TwoViewController.h
//  RAC-OC
//
//  Created by rogue on 2017/2/23.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import "RBaseViewController.h"

@class RACSubject;

@interface TwoViewController : RBaseViewController

@property (nonatomic, strong) RACSubject *delegateSignal;

@end
