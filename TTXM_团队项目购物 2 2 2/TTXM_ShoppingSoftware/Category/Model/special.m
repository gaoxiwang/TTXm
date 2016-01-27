//
//  special.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/18.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "special.h"

@implementation special

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        _s_id = value;
    }
    
}

@end
