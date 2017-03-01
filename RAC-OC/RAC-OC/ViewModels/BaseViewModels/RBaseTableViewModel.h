//
//  RBaseTableViewModel.h
//  RAC-OC
//
//  Created by rogue on 2017/3/1.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class RACCommand, RBaseModel;

@interface RBaseTableViewModel : NSObject<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong, readonly) RACCommand *requestCommand;

@property (nonatomic, strong) NSMutableArray *models;

/**
 记录 Model 数据类型, 尽量在 RequestViewModel 的 init 方法里，在 [super init] 之前写入
 */
@property (nonatomic, strong) Class modelType;

/**
 记录 TableViewCell 类型, 尽量在 RequestViewModel 的 init 方法里，在 [super init] 之前写入
 */
@property (nonatomic, strong) Class cellType;

@end
