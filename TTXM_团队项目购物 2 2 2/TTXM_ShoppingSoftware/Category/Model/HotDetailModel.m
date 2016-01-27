//
//  HotDetailModel.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/20.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "HotDetailModel.h"

@implementation HotDetailModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        _s_id = value;
    }
}
@end
