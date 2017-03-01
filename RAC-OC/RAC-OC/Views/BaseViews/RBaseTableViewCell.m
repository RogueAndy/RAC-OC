//
//  RBaseTableViewCell.m
//  RAC-OC
//
//  Created by rogue on 2017/3/1.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import "RBaseTableViewCell.h"

@implementation RBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self loadBaseView];
        [self loadLayout];
        
    }
    
    return self;
    
}

- (void)loadBaseView {}

- (void)loadLayout {}

- (void)setModel:(RBaseModel *)model {}

@end
