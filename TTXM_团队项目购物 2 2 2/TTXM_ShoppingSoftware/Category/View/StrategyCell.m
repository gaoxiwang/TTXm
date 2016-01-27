//
//  StrategyCell.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/18.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "StrategyCell.h"

@implementation StrategyCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self draw];
    }
    return self;
}

-(void)draw
{
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, (kWidth-80)/4, (kWidth-80)/4)];
    _imgView.layer.cornerRadius = (kWidth-80)/8;
    _imgView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.imgView];
    self.title = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+(kWidth-80)/4, (kWidth-80)/4, 30)];
    [self.contentView addSubview:_title];
    
}
@end
