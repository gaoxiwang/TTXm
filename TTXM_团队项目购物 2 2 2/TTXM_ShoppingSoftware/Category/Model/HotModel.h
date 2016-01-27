//
//  HotModel.h
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/20.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotModel : NSObject
@property(strong,nonatomic)NSString *name;
@property(strong,nonatomic)NSString *order;
@property(strong,nonatomic)NSMutableArray *subcategories;
@property(strong,nonatomic)NSString *s_id;

@end
