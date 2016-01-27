//
//  UIBarButtonItem+ZBBarButton.m
//  ZB豆瓣
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 张宝. All rights reserved.
//

#import "UIBarButtonItem+ZBBarButton.h"
#import "UIImage+ZBTint.h"


@implementation UIBarButtonItem (ZBBarButton)
+ (UIBarButtonItem *)barButtonItemWithTarget:(id)target action:(SEL)action Image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    //改变图片颜色
    UIImage *ima = [UIImage imageNamed:image];
    UIImage *imaged = [ima zb_tintedImageWithColor:[UIColor whiteColor] level:1.0f];
    UIImage *selecedIma = [UIImage imageNamed:selectedImage];
    UIImage *selectedImaged = [selecedIma zb_tintedImageWithColor:[UIColor whiteColor] level:1.0f];
    
    //创建button
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:imaged forState:UIControlStateNormal];
    [btn setImage:selectedImaged forState:UIControlStateSelected];
    btn.size = btn.currentImage.size;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
