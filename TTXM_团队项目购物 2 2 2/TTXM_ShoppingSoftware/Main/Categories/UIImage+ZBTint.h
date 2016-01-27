//
//  UIImage+ZBTint.h
//  ZB豆瓣
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 张宝. All rights reserved.

// 介绍:UIImage的一个Category，可以很方便给图片进行染色（Tinting）、增加亮度（lightening）以及降低亮度（darkening）。
// 使用方法:
// #import "UIImage+RTTint.h"
// UIImage *image = [UIImage imageNamed:@"Logo.png"];
// UIImage *tinted = [image rt_tintedImageWithColor:[UIColor redColor] level:0.5f];

#import <UIKit/UIKit.h>

@interface UIImage (ZBTint)

-(UIImage*)zb_tintedImageWithColor:(UIColor*)color;
-(UIImage*)zb_tintedImageWithColor:(UIColor*)color level:(CGFloat)level;
-(UIImage*)zb_tintedImageWithColor:(UIColor*)color rect:(CGRect)rect;
-(UIImage*)zb_tintedImageWithColor:(UIColor*)color rect:(CGRect)rect level:(CGFloat)level;
-(UIImage*)zb_tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets;
-(UIImage*)zb_tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets level:(CGFloat)level;

-(UIImage*)zb_lightenWithLevel:(CGFloat)level;
-(UIImage*)zb_lightenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets;
-(UIImage*)zb_lightenRect:(CGRect)rect withLevel:(CGFloat)level;

-(UIImage*)zb_darkenWithLevel:(CGFloat)level;
-(UIImage*)zb_darkenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets;
-(UIImage*)zb_darkenRect:(CGRect)rect withLevel:(CGFloat)level;

@end
