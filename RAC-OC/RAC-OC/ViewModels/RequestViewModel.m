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

@synthesize cellType = _cellType, modelType = _modelType;

- (instancetype)init {
    
    _cellType = [RTableViewCell class];
    _modelType = [Book class];
    return [super init];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [super tableView:tableView didSelectRowAtIndexPath:indexPath];

}

@end
