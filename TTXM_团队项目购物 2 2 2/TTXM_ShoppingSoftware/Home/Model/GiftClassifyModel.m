//
//  GiftClassifyModel.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/16.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "GiftClassifyModel.h"

@implementation GiftClassifyModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self._id = value;
    }


}



@end
