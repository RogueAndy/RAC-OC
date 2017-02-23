//
//  RequestViewModel.h
//  RAC-OC
//
//  Created by rogue on 2017/2/23.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class RACCommand;

@interface RequestViewModel : NSObject<UITableViewDataSource>

@property (nonatomic, strong, readonly) RACCommand *requestCommand;

@property (nonatomic, strong) NSArray *models;

@end
