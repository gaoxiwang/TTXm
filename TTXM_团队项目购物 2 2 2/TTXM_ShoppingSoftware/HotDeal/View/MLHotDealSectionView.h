//
//  MLHotDealSectionView.h
//  TTXM_ShoppingSoftware
//
//  Created by 小明 on 16/1/19.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MLHotDealSectionView;
//自定义代理
@protocol MLHotDealSectionDelegate <NSObject>

//当按钮点击时通知代理
- (void)selectView:(MLHotDealSectionView *)selectView didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to;

- (void)selectView:(MLHotDealSectionView *)selectView didChangeSelectedView:(NSInteger)to;
@end





@interface MLHotDealSectionView : UIView

@property(nonatomic, weak) id <MLHotDealSectionDelegate> delegate;

/** 喜欢的礼物 */
@property (nonatomic, strong) UIButton *likeBtn;
/** 喜欢的攻略 */
@property (nonatomic, strong) UIButton *strategyBtn;
/** 底部滑动的动画条 */
@property (nonatomic, strong) UIView *slideLineView;
/** 中间分隔线 */
@property (nonatomic, strong) UIView *centerLineView;

//记录当前被选中的按钮
@property (nonatomic, weak) UIButton *nowSelectedBtn;







/** 便利构造器 */
+ (instancetype)selectView;

//提供给外部一个可以滑动底部line的方法
- (void)lineToIndex:(NSInteger)index;











@end
