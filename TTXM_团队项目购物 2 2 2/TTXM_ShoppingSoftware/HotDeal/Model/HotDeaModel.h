//
//  HotDeaModel.h
//  TTXM_ShoppingSoftware
//
//  Created by 小明 on 16/1/15.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotDeaModel : NSObject
//封面图片
@property (nonatomic,strong) NSString *cover_image_url;
//描述
@property (nonatomic,strong) NSString *t_description;
//收藏
@property (nonatomic,strong) NSString *favorites_count;
//轮播图(数组)
@property (nonatomic,strong) NSMutableArray *image_urls;
//名称
@property (nonatomic,strong) NSString *name;
//价格
@property (nonatomic,strong) NSString *price;
//淘宝链接
@property (nonatomic,strong) NSString *purchase_url;
//图文链接
@property (nonatomic,strong) NSString *url;



@end
