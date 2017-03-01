//
//  Book.h
//  RAC-OC
//
//  Created by rogue on 2017/2/23.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import "RBaseModel.h"

@interface Book : RBaseModel

@property (nonatomic, strong) NSString *subtitle;

@property (nonatomic, strong) NSString *title;

@end
