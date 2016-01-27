//
//  GiftCollectionViewCell.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/20.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "GiftCollectionViewCell.h"

@implementation GiftCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self draw];
    }
    return self;
}

-(void)draw
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth/5, kHeight/8)];
    
    [self.contentView addSubview:_imgView];
    _nameLable = [[UILabel alloc]initWithFrame:CGRectMake(0, kHeight/8, kWidth/5, 60)];
    _nameLable.textAlignment = NSTextAlignmentCenter;
    _nameLable.numberOfLines = 0;
    _nameLable.font = [UIFont systemFontOfSize:14];
    
    [self.contentView addSubview:_nameLable];
}
@end
