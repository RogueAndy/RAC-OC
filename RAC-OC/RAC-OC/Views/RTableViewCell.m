//
//  RTableViewCell.m
//  RAC-OC
//
//  Created by rogue on 2017/2/23.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import "RTableViewCell.h"
#import "Book.h"

@interface RTableViewCell()

@property (nonatomic, strong, readwrite) UILabel *subLabel;

@property (nonatomic, strong, readwrite) UILabel *titLabel;

@end

@implementation RTableViewCell

- (void)loadBaseView {

    self.subLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.subLabel.textColor = [UIColor colorWithRed:70/255.f green:70/255.f blue:70/255.f alpha:1];
    self.subLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.subLabel];
    
    self.titLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titLabel.font = [UIFont systemFontOfSize:14];
    self.titLabel.textColor = [UIColor colorWithRed:70/255.f green:70/255.f blue:70/255.f alpha:1];
    [self.contentView addSubview:self.titLabel];

}

- (void)loadLayout {

    self.subLabel.frame = CGRectMake(20, 10, 200, 25);
    self.titLabel.frame = CGRectMake(20, 40, 200, 25);
    
}

- (void)setModel:(RBaseModel *)model {

    Book *book = (Book *)model;
    self.subLabel.text = book.subtitle;
    self.titLabel.text = book.title;

}

@end
