//
//  ChonseList.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/23.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "ChonseList.h"

@implementation ChonseList
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _s_id = value;
    }
    if ([key isEqualToString:@"description"]) {
        _s_description = value;
    }
    
    
}
@end
