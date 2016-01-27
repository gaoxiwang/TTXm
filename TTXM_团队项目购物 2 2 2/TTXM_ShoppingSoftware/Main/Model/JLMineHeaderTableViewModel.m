//
//  JLMineHeaderTableViewModel.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "JLMineHeaderTableViewModel.h"

@implementation JLMineHeaderTableViewModel
- (instancetype)initWithDict:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)mineHeaderTVMWithDict:(NSDictionary *)dic {
    return [[self alloc]initWithDict:dic];
}

@end
