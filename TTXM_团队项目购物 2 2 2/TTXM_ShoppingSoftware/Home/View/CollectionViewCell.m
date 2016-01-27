//
//  CollectionViewCell.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self drawView];
    }
    return self;
}

-(void)drawView
{
    
    [self.contentView addSubview:self.imgView];
    
    
}

-(UIImageView *)imgView
{
    
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        _imgView.backgroundColor = [UIColor whiteColor];
        
    }
    return _imgView;
}

@end
