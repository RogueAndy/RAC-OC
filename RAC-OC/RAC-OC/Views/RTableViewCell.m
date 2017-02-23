//
//  RTableViewCell.m
//  RAC-OC
//
//  Created by rogue on 2017/2/23.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import "RTableViewCell.h"

@implementation RTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        [self loadBaseView];
    
    }
    
    return self;

}

- (void)loadBaseView {

    self.subLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 25)];
    self.subLabel.textColor = [UIColor colorWithRed:70/255.f green:70/255.f blue:70/255.f alpha:1];
    self.subLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.subLabel];
    
    self.titLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 200, 25)];
    self.titLabel.font = [UIFont systemFontOfSize:14];
    self.titLabel.textColor = [UIColor colorWithRed:70/255.f green:70/255.f blue:70/255.f alpha:1];
    [self.contentView addSubview:self.titLabel];

}

@end
