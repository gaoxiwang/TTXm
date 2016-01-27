//
//  JLMineHeaderInSectionView.h
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JLMineHeaderInSectionView;

@protocol JLMineHeaderInSectionViewDelegate <NSObject>

@optional

//当按钮点击时通知代理
- (void)selectView:(JLMineHeaderInSectionView *)selectView didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to;

- (void)selectView:(JLMineHeaderInSectionView *)selectView didChangeSelectedView:(NSInteger)to;




@end



@interface JLMineHeaderInSectionView : UIView
@property(nonatomic, weak) id <JLMineHeaderInSectionViewDelegate> delegate;

/** 便利构造器 */
+ (instancetype)selectView;

//提供给外部一个可以滑动底部line的方法
- (void)lineToIndex:(NSInteger)index;
@end
