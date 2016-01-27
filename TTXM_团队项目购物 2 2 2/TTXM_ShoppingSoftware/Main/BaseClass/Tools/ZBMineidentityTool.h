//
//  ZBMineidentityTool.h
//  GiftSpeak
//
//  Created by lanou3g on 15/8/21.
//  Copyright (c) 2015年 TWZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBMineidentityTool : NSObject
singleton_interface(ZBMineidentityTool);

/** 获取当前用户性别 */
@property (assign, nonatomic) NSNumber *gender;

/** 获取当前用户职业 */
@property (assign, nonatomic) NSNumber *generation;

/** 获取当前用户性别 */
@property (copy, nonatomic) NSString *genderStr;

/** 获取当前用户职业 */
@property (copy, nonatomic) NSString *generationStr;

@end
