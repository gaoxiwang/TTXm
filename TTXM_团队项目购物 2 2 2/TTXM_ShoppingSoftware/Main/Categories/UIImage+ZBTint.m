//
//  UIImage+ZBTint.m
//  ZB豆瓣
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 张宝. All rights reserved.
//

#import "UIImage+ZBTint.h"

@implementation UIImage (ZBTint)


// Tint: Color
-(UIImage*)zb_tintedImageWithColor:(UIColor*)color {
    return [self zb_tintedImageWithColor:color level:1.0f];
}

// Tint: Color + level
-(UIImage*)zb_tintedImageWithColor:(UIColor*)color level:(CGFloat)level {
    CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    return [self zb_tintedImageWithColor:color rect:rect level:level];
}

// Tint: Color + Rect
-(UIImage*)zb_tintedImageWithColor:(UIColor*)color rect:(CGRect)rect {
    return [self zb_tintedImageWithColor:color rect:rect level:1.0f];
}

// Tint: Color + Rect + level
-(UIImage*)zb_tintedImageWithColor:(UIColor*)color rect:(CGRect)rect level:(CGFloat)level {
    CGRect imageRect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self drawInRect:imageRect];
    
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextSetAlpha(ctx, level);
    CGContextSetBlendMode(ctx, kCGBlendModeSourceAtop);
    CGContextFillRect(ctx, rect);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *darkImage = [UIImage imageWithCGImage:imageRef
                                             scale:self.scale
                                       orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    
    UIGraphicsEndImageContext();
    
    return darkImage;
}

// Tint: Color + Insets
-(UIImage*)zb_tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets {
    return [self zb_tintedImageWithColor:color insets:insets level:1.0f];
}

// Tint: Color + Insets + level
-(UIImage*)zb_tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets level:(CGFloat)level {
    CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    return [self zb_tintedImageWithColor:color rect:UIEdgeInsetsInsetRect(rect, insets) level:level];
}

// Light: Level
-(UIImage*)zb_lightenWithLevel:(CGFloat)level {
    return [self zb_tintedImageWithColor:[UIColor whiteColor] level:level];
}

// Light: Level + Insets
-(UIImage*)zb_lightenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets {
    return [self zb_tintedImageWithColor:[UIColor whiteColor] insets:insets level:level];
}

// Light: Level + Rect
-(UIImage*)zb_lightenRect:(CGRect)rect withLevel:(CGFloat)level {
    return [self zb_tintedImageWithColor:[UIColor whiteColor] rect:rect level:level];
}

// Dark: Level
-(UIImage*)zb_darkenWithLevel:(CGFloat)level {
    return [self zb_tintedImageWithColor:[UIColor blackColor] level:level];
}

// Dark: Level + Insets
-(UIImage*)zb_darkenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets {
    return [self zb_tintedImageWithColor:[UIColor blackColor] insets:insets level:level];
}

// Dark: Level + Rect
-(UIImage*)zb_darkenRect:(CGRect)rect withLevel:(CGFloat)level {
    return [self zb_tintedImageWithColor:[UIColor blackColor] rect:rect level:level];
}
@end
