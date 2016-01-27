//
//  UIBarButtonItem+ZBBarButton.h
//  ZB豆瓣
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 张宝. All rights reserved.
//  

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZBBarButton)
+ (UIBarButtonItem *)barButtonItemWithTarget:(id)target action:(SEL)action Image:(NSString *)image selectedImage:(NSString *)selectedImage;
@end
