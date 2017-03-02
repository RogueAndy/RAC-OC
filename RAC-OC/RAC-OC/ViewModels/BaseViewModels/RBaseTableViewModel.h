//
//  RBaseTableViewModel.h
//  RAC-OC
//
//  Created by rogue on 2017/3/1.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class RACCommand;

@interface RBaseTableViewModel : NSObject<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong, readonly) RACCommand *requestCommand;

/**
 得到返回的数组
 */
@property (nonatomic, strong, readonly) NSMutableArray *models;

/**
 填入需要发送的参数
 */
@property (nonatomic, strong) NSMutableDictionary *netParameters;

/**
 记录 Model 数据类型, 尽量在 RequestViewModel 的 init 方法里，在 [super init] 之前写入
 */
@property (nonatomic, strong, readonly) Class modelType;

/**
 记录 TableViewCell 类型, 尽量在 RequestViewModel 的 init 方法里，在 [super init] 之前写入
 */
@property (nonatomic, strong, readonly) Class cellType;

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, assign) BOOL headLoading;

@property (nonatomic, assign) BOOL footerLoading;

@end
