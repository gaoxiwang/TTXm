//
//  SearchCollectionModel.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/22.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "SearchCollectionModel.h"

@implementation SearchCollectionModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

    if ([key isEqualToString:@"id"]) {
        self._id = value;
    }

}



@end
