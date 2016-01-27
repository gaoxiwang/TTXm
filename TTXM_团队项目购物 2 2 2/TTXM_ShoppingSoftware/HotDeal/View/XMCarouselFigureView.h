//
//  XMCarouselFigureView.h
//  CarouselFigureView封装轮播图
//
//  Created by 小明 on 15/12/12.
//  Copyright © 2015年 小明. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMCarouselFigureView;
@protocol XMCarouselFigureViewDelegate <NSObject>



//轮播图被点击时触发的代理方法
//carouselFigureView 轮播图本身
//@param index  c传递给外界的下标
-(void)carouselFigureViewDidCarousel:(XMCarouselFigureView *)carouselFigureView withIndex:(NSUInteger)index;

@end


@interface XMCarouselFigureView : UIView

//图片数组,外界赋值轮播图片时候使用,或者获取轮播图片时使用
@property (nonatomic, strong)NSArray *images;
//图片切换间隔
@property (nonatomic, assign)NSTimeInterval duration;//default is 2.0
//当前下标
@property (nonatomic, assign)NSUInteger currenIndx;
//代理对象
@property (nonatomic,weak)id<XMCarouselFigureViewDelegate>delegate;







@end
