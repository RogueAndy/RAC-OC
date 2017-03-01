//
//  Book.m
//  RAC-OC
//
//  Created by rogue on 2017/2/23.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import "Book.h"

@implementation Book

+ (instancetype)modelWithDict:(id)value {
    
    Book *book = [[Book alloc] init];
    book.subtitle = value[@"subtitle"];
    book.title = value[@"title"];
    
    return book;
    
}

@end
