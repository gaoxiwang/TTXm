//
//  HotDeaModel.m
//  TTXM_ShoppingSoftware
//
//  Created by 小明 on 16/1/15.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "HotDeaModel.h"

@implementation HotDeaModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"description"]) {
        
        self.t_description = value;
    }
    
    
}
@end
