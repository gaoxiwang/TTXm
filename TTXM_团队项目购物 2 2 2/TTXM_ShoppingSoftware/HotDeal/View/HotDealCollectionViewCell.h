//
//  HotDealCollectionViewCell.h
//  TTXM_ShoppingSoftware
//
//  Created by 小明 on 16/1/15.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotDealCollectionViewCell : UICollectionViewCell

//封面图片
@property (nonatomic,strong) UIImageView *cover_image_urlView;
//钱图片
@property (nonatomic,strong) UIImageView *money;
//收藏图片
@property (nonatomic,strong) UIImageView *collection;
//收藏
@property (nonatomic,strong) UILabel *favorites_counLabel;
//名称
@property (nonatomic,strong) UILabel *nameLabel;
//价格
@property (nonatomic,strong) UILabel *priceLabel;

@property (nonatomic,strong) HotDeaModel *model;

@end
