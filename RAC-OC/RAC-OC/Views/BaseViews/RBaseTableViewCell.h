//
//  RBaseTableViewCell.h
//  RAC-OC
//
//  Created by rogue on 2017/3/1.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBaseModel.h"

@interface RBaseTableViewCell : UITableViewCell

- (void)loadBaseView;

- (void)loadLayout;

- (void)setModel:(RBaseModel *)model;

@end
