//
//  SelectView.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SelectView.h"

@interface SelectView ()

#pragma mark - 私有属性
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIView *selectingView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *maleButton;
@property (nonatomic, strong) UIButton *famaleButton;
@property (nonatomic, strong) UIDynamicAnimator *animator;

@end


@implementation SelectView

#define kSeperate 7
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.673 green:1.000 blue:0.994 alpha:1.000];
        [self SetSelectView];
    }
    return self;
}

- (void)SetSelectView
{
    
    
    // 小view显示性别和年代
    self.selectingView = [[UIView alloc] initWithFrame:CGRectMake((self.bounds.size.width * 0.5 - 90), -180, 180, 250)];
    self.selectingView.backgroundColor = [UIColor colorWithRed:1.000 green:0.983 blue:0.875 alpha:1.000];
    [self addSubview:self.selectingView];
    
    // 用于提示的view
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.selectingView.bounds), CGRectGetMinY(self.selectingView.bounds), self.selectingView.bounds.size.width, 44)];
    self.label.text = @"请选择您的性别";
    self.label.textColor = [UIColor colorWithRed:0.907 green:0.745 blue:0.096 alpha:1.000];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:15];
    [self.selectingView addSubview:self.label];
    
    // 分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 180, 1)];
    line.backgroundColor = [UIColor grayColor];
    [self.selectingView addSubview:line];
    
    // 男孩按钮
    self.maleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.maleButton.frame = CGRectMake(CGRectGetMidX(self.selectingView.bounds) - 80, CGRectGetMidY(self.selectingView.bounds) - 40, 70, 70);
    [self.maleButton setImage:[UIImage imageNamed:@"ic_gender_boy.png"] forState:UIControlStateNormal];
    [self.maleButton addTarget:self action:@selector(maleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectingView addSubview:self.maleButton];
    
    // 女孩按钮
    self.famaleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.famaleButton.frame = CGRectMake(CGRectGetMidX(self.selectingView.bounds) + 10, CGRectGetMidY(self.selectingView.bounds) - 40, 70, 70);
    [self.famaleButton setImage:[UIImage imageNamed:@"ic_gender_girl.png"] forState:UIControlStateNormal];
    [self.famaleButton addTarget:self action:@selector(famaleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectingView addSubview:self.famaleButton];
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.selectingView]];
    [self.animator addBehavior:gravity];
    gravity.magnitude = 1;
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.selectingView]];
    [collision addBoundaryWithIdentifier:@"sdg" fromPoint:CGPointMake(0, self.bounds.size.height / 3 * 2 - 30) toPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height / 3 * 2 - 30)];
    [self.animator addBehavior:collision];
    
}
#pragma mark - 按钮点击事件
#pragma mark 男孩按钮点击事件
- (void)maleButtonAction:(UIButton *)sender
{
    [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"gender"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self removeButtonFromSelectingView:sender];
}

#pragma mark 女孩按钮点击事件
- (void)famaleButtonAction:(UIButton *)sender
{
    
    [[NSUserDefaults standardUserDefaults] setObject:@2 forKey:@"gender"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self removeButtonFromSelectingView:sender];
}

#pragma mark 移除按钮，更改Label的文字
- (void)removeButtonFromSelectingView:(UIButton *)sender
{
    [self.maleButton removeFromSuperview];
    [self.famaleButton removeFromSuperview];
    self.label.text = @"请选择您的身份";
    [self setSubViewsOfCoverView];
}

#pragma mark - 设置年代信息
- (void)setSubViewsOfCoverView
{
    NSArray *array = @[@"初中生", @"高中生", @"大学生", @"职场新人", @"资深工作党"];
    
    // 年代按钮的颜色
    UIColor *firstColor = [UIColor colorWithRed:0.335 green:1.000 blue:0.458 alpha:1.000];
    UIColor *secondColor = [UIColor colorWithRed:0.913 green:0.336 blue:0.432 alpha:1.000];
    UIColor *thirdColor = [UIColor colorWithRed:0.400 green:0.454 blue:1.000 alpha:1.000];
    UIColor *fourthColor = [UIColor colorWithRed:0.938 green:0.469 blue:1.000 alpha:1.000];
    UIColor *fifthColor = [UIColor colorWithRed:0.836 green:0.671 blue:0.504 alpha:1.000];
    
    NSArray *colorArray = @[firstColor, secondColor, thirdColor, fourthColor, fifthColor];
    
    // 设置年代按钮
    for (int i = 0; i < 5; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(CGRectGetMinX(self.selectingView.bounds) + 15, CGRectGetMinY(self.selectingView.bounds) + 60 + i * (kSeperate + 30), self.selectingView.bounds.size.width - 15 * 2, 30);
        [button setTitle:array[i] forState:UIControlStateNormal];
        button.backgroundColor = colorArray[i];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.selectingView addSubview:button];
        button.tag = 204 - i;   // 设置tag值，根据tag值取到generation对应的数字
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark 年代按钮的点击事件
- (void)buttonAction:(UIButton *)sender
{
    // 点击按钮返回generation的值
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:(sender.tag - 200)] forKey:@"generation"];
    
    // 点击年代之后将覆盖的view整个移除
    [[NSNotificationCenter defaultCenter] postNotificationName:@"open" object:nil userInfo:@{@"OK":@2}];
    [self removeFromSuperview];
    
}





@end
