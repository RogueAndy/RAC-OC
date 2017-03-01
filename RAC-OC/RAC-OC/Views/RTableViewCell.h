//
//  RTableViewCell.h
//  RAC-OC
//
//  Created by rogue on 2017/2/23.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import "RBaseTableViewCell.h"

@interface RTableViewCell : RBaseTableViewCell

@property (nonatomic, strong, readonly) UILabel *subLabel;

@property (nonatomic, strong, readonly) UILabel *titLabel;

@end
