//
//  HotDealCollectionViewCell.m
//  TTXM_ShoppingSoftware
//
//  Created by 小明 on 16/1/15.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "HotDealCollectionViewCell.h"

@implementation HotDealCollectionViewCell

-(void)setModel:(HotDeaModel *)model{

    if (_model != model) {
        _model = nil;
        _model = model;
    
    }
    self.favorites_counLabel.text =[NSString stringWithFormat:@"%@",model.favorites_count];
    self.nameLabel.text =model.name;
    self.priceLabel.text =model.price;
    [self.cover_image_urlView sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
    
    
}
-(instancetype)initWithFrame:(CGRect)frame{
   
        self = [super initWithFrame:frame];
        if (self) {
            [self drawView];
        }
        return self;
    

}
-(void)drawView{
//图片
    self.cover_image_urlView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (kScreenWidth-30)/2,kScreenHeight/3)];
    self.cover_image_urlView.layer.cornerRadius=5;
    self.cover_image_urlView.layer.masksToBounds=YES;
    [self.contentView addSubview:self.cover_image_urlView];

    
//标题
    self.nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.cover_image_urlView.frame), (kScreenWidth-30)/2, 50)];
    self.nameLabel.font =[UIFont systemFontOfSize:14];
    self.nameLabel.numberOfLines=0;
   
    [self.contentView addSubview:self.nameLabel];

//钱
    self.money =[[UIImageView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.nameLabel.frame), 15, 15)];
    
    self.money.image=[UIImage imageNamed:@"钱"];
    
    [self.contentView addSubview:self.money];
    
//价格
    self.priceLabel =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.money.frame), CGRectGetMaxY(self.nameLabel.frame), 50, 20)];
    self.priceLabel.font =[UIFont systemFontOfSize:10];
    [self.contentView addSubview:self.priceLabel];
    
//收藏图片
    self.collection =[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.priceLabel.frame)+20, CGRectGetMaxY(self.nameLabel.frame), 15, 15)];
    
    self.collection.image=[UIImage imageNamed:@"收藏"];
    
    [self.contentView addSubview:self.collection];
    
//收藏
    self.favorites_counLabel =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.collection.frame), CGRectGetMaxY(self.nameLabel.frame), 40, 20)];
    self.favorites_counLabel.font =[UIFont systemFontOfSize:10];
    [self.contentView addSubview:self.favorites_counLabel];
    
    
    
}



@end
