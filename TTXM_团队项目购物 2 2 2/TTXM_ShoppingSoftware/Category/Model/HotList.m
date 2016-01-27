//
//  HotList.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/22.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "HotList.h"

@implementation HotList
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _s_id = value;
    }
    else if ([key isEqualToString:@"description"])
    {
        _s_description = value;
    }
    
    
    
}
@end
