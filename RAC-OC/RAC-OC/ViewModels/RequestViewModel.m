//
//  RequestViewModel.m
//  RAC-OC
//
//  Created by rogue on 2017/2/23.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import "RequestViewModel.h"
#import "ReactiveCocoa.h"
#import "AFNetworking.h"
#import "Book.h"
#import "RTableViewCell.h"

@implementation RequestViewModel

- (instancetype)init {
    
    self.cellType = [RTableViewCell class];
    self.modelType = [Book class];
    return [super init];

}

@end
