//
//  JLLIkeController.h
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JLLIkeController : UITableViewController
@property (strong, nonatomic) NSMutableArray *dataArray;

#pragma mark - 便利构造器
+ (instancetype)likeControllerWithContoller:(UIViewController *)controller;
@end
