//
//  JLStrategyController.h
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JLStrategyController : UITableViewController
@property (strong, nonatomic) NSMutableArray *dataArray;
/** 便利构造器 */
+ (instancetype)strategyControllerWithContoller:(UIViewController *)controller;
@end
