//
//  JLMineHeaderTableViewModel.h
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLMineHeaderTableViewModel : NSObject
@property (copy, nonatomic) NSString *name;

@property (copy, nonatomic) NSString *image;

- (instancetype)initWithDict:(NSDictionary *)dic;
+ (instancetype)mineHeaderTVMWithDict:(NSDictionary *)dic;
@end
