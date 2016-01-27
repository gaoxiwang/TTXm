//
//  CategoryCell.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/16.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self draw];
    }
    return self;
}

-(void)draw
{
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (kWidth-80)/4, (kWidth-80)/4)];
    _imgView.layer.cornerRadius = (kWidth-80)/8;
    _imgView.layer.masksToBounds = YES;
    [self.contentView addSubview:_imgView];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0+(kWidth-80)/4, (kWidth-80)/4, 30)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:_titleLabel];
    
    
}
@end
