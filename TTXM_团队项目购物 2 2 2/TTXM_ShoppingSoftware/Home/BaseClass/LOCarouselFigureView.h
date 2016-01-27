//
//  LOCarouselFigureView.h
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/18.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LOCarouselFigureView;
@protocol LOCarouseFigurelViewDelegate <NSObject>

//轮播图被点击时出发的方法
//carouselFigureView 轮播图本身
//index 传递给外界的下标

- (void)carouselFigureViewDidCarousel:(LOCarouselFigureView *)carouselFigureView withIndex:(NSNumber *)index;

@end
@interface LOCarouselFigureView : UIView

//图片数组,外界赋值轮播图片的时候使用,或者获取轮播图片的时候使用
@property (strong,nonatomic)NSArray *images;

//图片切换间隔
@property (assign,nonatomic)NSTimeInterval duration;//defult is 2.0

//当前下标
@property (assign,nonatomic)NSUInteger currentIndex;

@property (strong,nonatomic)NSMutableArray *dataArray;

//代理对象
@property (weak,nonatomic)id<LOCarouseFigurelViewDelegate> delegate;



@end
