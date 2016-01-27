//
//  SearchCollectionCell.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/22.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "SearchCollectionCell.h"

@implementation SearchCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        // 获取ZBMoviewCollectionViewCell下所有子视图
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"SearchCollectionCell" owner:self options: nil];
        if(arrayOfViews.count < 1){return nil;}
        if(![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]){
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        
        //设置cell属性
        [self setupCell];
    }
    return self;

}

/**
 *  初始化cell属性只设置一次
 */
- (void)setupCell {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
}

// 设置cell的View显示视图
- (void)setSearchCollectionModel:(SearchCollectionModel *)searchCollectionModel
{
    _searchCollectionModel = searchCollectionModel;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:searchCollectionModel.cover_image_url]];
    self.titleLabel.text = searchCollectionModel.name;
    self.priceLabel.text = searchCollectionModel.price;
    self.like_countLabel.text = [NSString stringWithFormat:@"%@",searchCollectionModel.like_count];

}




- (void)awakeFromNib {
    // Initialization code
}

@end
