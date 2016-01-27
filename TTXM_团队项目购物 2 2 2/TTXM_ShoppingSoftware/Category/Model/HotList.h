//
//  HotList.h
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/22.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotList : NSObject
@property(strong,nonatomic)NSString *cover_image_url;
@property(strong,nonatomic)NSString *created_at;
@property(strong,nonatomic)NSString *category_id;
@property(strong,nonatomic)NSString *s_description;
@property(strong,nonatomic)NSString *editor_id;
@property(strong,nonatomic)NSString *s_id;
@property(strong,nonatomic)NSMutableArray *image_urls;
@property(strong,nonatomic)NSString *name;
@property(strong,nonatomic)NSString *price;
@property(strong,nonatomic)NSString *url;
@property(strong,nonatomic)NSString *detail_html;
@property(strong,nonatomic)NSString *purchase_url;


@end
