//
//  UserSingle.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/28.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "UserSingle.h"

@implementation UserSingle

+ (instancetype)singleInOrNot
{
    static UserSingle *US = nil;
    if (US == nil) {
        static dispatch_once_t token;
        dispatch_once(&token, ^{
            US = [[UserSingle alloc] init];
            US.singleOrNot = NO;
            
        });
        
    }
    return US;
    
}


@end
