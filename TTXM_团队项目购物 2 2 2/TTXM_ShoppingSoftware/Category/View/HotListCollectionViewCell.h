//
//  HotListCollectionViewCell.h
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/22.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotListCollectionViewCell : UICollectionViewCell
@property(strong,nonatomic)UIImageView *imgView;
@property(strong,nonatomic)UILabel *nameLabel;
@property(strong,nonatomic)UILabel *priceLabel;
@property(strong,nonatomic)UIButton *likeButton;

@end
