//
//  FiltersModel.h
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/23.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FiltersModel : NSObject
@property(strong,nonatomic)NSMutableArray *channels;
@property(strong,nonatomic)NSString *s_id;
@property(strong,nonatomic)NSString *key;
@property(strong,nonatomic)NSString *name;
@property(strong,nonatomic)NSString *order;
@property(strong,nonatomic)NSString *status;

@end
