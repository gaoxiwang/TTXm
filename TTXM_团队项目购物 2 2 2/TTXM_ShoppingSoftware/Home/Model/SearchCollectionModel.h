//
//  SearchCollectionModel.h
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/22.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchCollectionModel : NSObject

@property (strong,nonatomic)NSString *cover_image_url;
@property (strong,nonatomic)NSString *name;
@property (strong,nonatomic)NSString *price;
//用来进入详情页的参数
@property (strong,nonatomic)NSNumber *_id;
@property (strong,nonatomic)NSNumber *like_count;


@end
