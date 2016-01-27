//
//  MLHotDealSectionView.m
//  TTXM_ShoppingSoftware
//
//  Created by 小明 on 16/1/19.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "MLHotDealSectionView.h"
@implementation MLHotDealSectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    
    return self;
    
}

- (void)awakeFromNib
{
    [self setUp];
}

- (void)setUp
{
    //背景色和阴影
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.likeBtn = [UIButton new];
    [self addBtnToView:self.likeBtn title:@"图文介绍" tag:0];
    self.strategyBtn = [UIButton new];
    [self addBtnToView:self.strategyBtn title:@"评论" tag:1];
    
    self.slideLineView = [UIView new];
    self.slideLineView.backgroundColor = [UIColor redColor];
    [self addSubview:self.slideLineView];
    
    self.centerLineView = [UIView new];
    self.centerLineView.backgroundColor = [UIColor colorWithWhite:0.200 alpha:1.000];
    [self addSubview:self.centerLineView];
    
    [self.likeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [self.strategyBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
}

- (void)addBtnToView:(UIButton *)btn title:(NSString *)title tag:(NSInteger)tag
{
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.tag = tag;
    [self addSubview:btn];
}

//便利构造方法
+ (instancetype)selectView
{
    MLHotDealSectionView *selectView = [[self alloc] init];
    return selectView;
}


//设置控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat viewH = self.bounds.size.height;
    CGFloat viewW = self.bounds.size.width;
    CGFloat btnW = viewW * 0.5;
    CGFloat btnH = viewH;
    //计算间距
    
    self.likeBtn.frame = CGRectMake(0, 0, btnW, btnH);
    self.strategyBtn.frame = CGRectMake(btnW , 0, btnW, btnH);
    self.slideLineView.frame = CGRectMake(0, viewH - 2, btnW, 2);
    self.centerLineView.frame = CGRectMake(btnW, 0, 0.5, viewH);
}

#pragma mark - 按钮的Action
- (void)btnClick:(UIButton *)sender
{
    if (self.nowSelectedBtn == sender) return;
    
    //通知代理点击
    if ([self.delegate respondsToSelector:@selector(selectView:didSelectedButtonFrom:to:)]) {
        [self.delegate selectView:self didSelectedButtonFrom:self.nowSelectedBtn.tag to:sender.tag];
    }
    
    //给滑动小条做动画
    CGRect rect = self.slideLineView.frame;
    rect.origin.x = sender.frame.origin.x;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.slideLineView.frame = rect;
    }];
    
    self.nowSelectedBtn = sender;
}

//有代理时，点击按钮
- (void)setDelegate:(id<MLHotDealSectionDelegate>)delegate
{
    _delegate = delegate;
    
    [self btnClick:self.likeBtn];
}


- (void)lineToIndex:(NSInteger)index
{
    
    switch (index) {
        case 0:
            if ([self.delegate respondsToSelector:@selector(selectView:didChangeSelectedView:)]) {
                [self.delegate selectView:self didChangeSelectedView:0];
            }
            self.nowSelectedBtn = self.likeBtn;
            break;
        case 1:
            if ([self.delegate respondsToSelector:@selector(selectView:didChangeSelectedView:)]) {
                [self.delegate selectView:self didChangeSelectedView:1];
            }
            self.nowSelectedBtn = self.strategyBtn;
            break;
        default:
            break;
    }
    
    CGRect rect = self.slideLineView.frame;
    rect.origin.x = self.nowSelectedBtn.frame.origin.x;
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.slideLineView.frame = rect;
    }];
    
}





@end
