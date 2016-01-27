//
//  GiftListModel.h
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/16.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GiftListModel : NSObject

@property (strong,nonatomic)NSString *content_title;//礼物简介

@property (strong,nonatomic)NSString *cover_image_url;//礼物图片

@property (strong,nonatomic)NSNumber *likes_count;//收藏人数
@property (strong,nonatomic)NSString *allTitle;

@property (strong,nonatomic)NSString *url;//转跳的网址

@property (assign,nonatomic)NSInteger created_at;

@property (nonatomic, copy) NSString *content_url;

@property (nonatomic, copy) NSString *share_msg;

@property (nonatomic, copy) NSString *short_title;
@property (nonatomic, assign) BOOL liked;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, strong) NSString *typed;

@end
