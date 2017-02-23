//
//  Book.h
//  RAC-OC
//
//  Created by rogue on 2017/2/23.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property (nonatomic, strong) NSString *subtitle;

@property (nonatomic, strong) NSString *title;

+ (instancetype)bookWithDict:(id)value;

@end
