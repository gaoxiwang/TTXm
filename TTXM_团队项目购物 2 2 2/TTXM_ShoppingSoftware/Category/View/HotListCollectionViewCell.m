//
//  HotListCollectionViewCell.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/22.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "HotListCollectionViewCell.h"

@implementation HotListCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self draw];
    }
    return self;
}

-(void)draw
{
    
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, (kWidth-20)/2, kHeight/3)];
    _imgView.layer.cornerRadius = 10;
    _imgView.layer.masksToBounds = YES;
    [self.contentView addSubview:_imgView];
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kHeight/3+10, (kWidth-20)/2, 40)];
    _nameLabel.numberOfLines = 0;
    _nameLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_nameLabel];
    _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kHeight/3+40, (kWidth-20)/4, 30)];
    [self.contentView addSubview:_priceLabel];
    
    _likeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _likeButton.frame = CGRectMake((kWidth-20)/4+10, kHeight/3+40, (kWidth-20)/4, 30);
    [_likeButton setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    _likeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_likeButton];
    
}

@end
