//
//  SomeCollectionViewCell.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/26.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "SomeCollectionViewCell.h"

@implementation SomeCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self drawView];
    }
    return self;
}

-(void)drawView
{

    [self.contentView addSubview:self.searchNameLabel];

}

- (UILabel *)searchNameLabel
{

    if (!_searchNameLabel) {
        _searchNameLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        _searchNameLabel.text = @"脚蹬裤";
        _searchNameLabel.layer.borderWidth = 1;
        _searchNameLabel.layer.borderColor = [UIColor grayColor].CGColor;
        _searchNameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _searchNameLabel;


}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //每次布局的时候完成新的坐标计算
    self.searchNameLabel.frame = self.contentView.bounds;
}

@end
