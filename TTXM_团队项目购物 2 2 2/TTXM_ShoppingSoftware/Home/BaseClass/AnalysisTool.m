//
//  AnalysisTool.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/16.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "AnalysisTool.h"

@interface AnalysisTool ()

@property (strong,nonatomic) NSMutableArray *dataArray;

@end

@implementation AnalysisTool

-(void)dataAnalysisWithIndex:(NSInteger)index _id:(NSNumber *)_id gender:(NSInteger)gender generation:(NSInteger)generation passValue:(PassValue)passValue
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    __block typeof(self) weakSelf = self;
    
    NSString *url = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/channels/%@/items?limit=20&offset=%lu&gender=%lu&generation=%lu",_id,index,gender,generation];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
            weakSelf.dataArray = [NSMutableArray array];
            for (NSDictionary *dict in responseObject[@"data"][@"items"]) {
                
                GiftListModel *model = [[GiftListModel alloc] init];
                model.content_title = dict[@"title"];
                model.cover_image_url = dict[@"cover_image_url"];
                model.likes_count = dict[@"likes_count"];
                model.url = dict[@"url"];
                [weakSelf.dataArray addObject:model];
                
            }
            passValue(weakSelf.dataArray);
            
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

-(void)lunBoDataAnalysisWithPassValue:(PassValue)passValue
{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    __block typeof(self) weakSelf = self;
    
    NSString *url = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/banners?channel=iOS"];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        weakSelf.dataArray = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"data"][@"banners"]) {
            
            WheelModel *model = [[WheelModel alloc] init];
            model.image_url = dict[@"image_url"];
            model.target_id = dict[@"target_id"];
            model.target_url = dict[@"target_url"];
            
            [weakSelf.dataArray addObject:model];
            
        }
        passValue(weakSelf.dataArray);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}

-(void)lunBoListdataAnalysisWithIndex:(NSInteger)index _id:(NSNumber *)_id gender:(NSInteger)gender generation:(NSInteger)generation passValue:(PassValue)passValue
{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    __block typeof(self) weakSelf = self;
    
    NSString *url = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/collections/%@/posts?gender=%lu&generation=%lu&limit=20&offset=%lu",_id,gender,generation,index];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
      
        weakSelf.dataArray = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"data"][@"posts"]) {
            GiftListModel *model = [[GiftListModel alloc] init];
            model.allTitle = responseObject[@"data"][@"title"];
            model.content_title = dict[@"title"];
            model.cover_image_url = dict[@"cover_image_url"];
            model.likes_count = dict[@"likes_count"];
            
            [weakSelf.dataArray addObject:model];
            
        }
        passValue(weakSelf.dataArray);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];



}

-(void)collectionDataAnalysisWithGender:(NSInteger)gender generation:(NSInteger)generation passValue:(PassValue)passValue
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    __block typeof(self) weakSelf = self;
    
    NSString *url = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/secondary_banners?gender=%lu&generation=%lu",gender,generation];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        weakSelf.dataArray = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"data"][@"secondary_banners"]) {
            collectionModel *model = [[collectionModel alloc] init];
            model.image_url = dict[@"image_url"];
            
            
            NSMutableString *string = [NSMutableString stringWithString:dict[@"target_url"]];
            //判断字符串中是否包含某段字符串,如果包含,删除这段字符串
            NSRange substr = [string rangeOfString:@"liwushuo:///page?type=topic&topic_id="];
            if (substr.location != NSNotFound) {
                [string deleteCharactersInRange:substr];
                model._id = string;
            }else
            {
            NSRange substr1 = [string rangeOfString:@"liwushuo:///page?type=post&post_id="];
                if (substr1.location != NSNotFound) {
                    [string deleteCharactersInRange:substr1];
                    NSRange substr2 = [string rangeOfString:@"&page_action=navigation"];
                    if (substr2.location != NSNotFound) {
                        [string deleteCharactersInRange:substr2];
                        model._id = string;
                    }
                    
                }else
                {
                    model._id = NULL;
                
                }
                
            }
            
            [weakSelf.dataArray addObject:model];
            
        }
        passValue(weakSelf.dataArray);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];


}

-(void)searchDataAnalysisWithID:(NSNumber *)ID passValue:(PassValue)passValue
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    __block typeof(self) weakSelf = self;
    
    NSString *url = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/items/%@",ID];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        weakSelf.dataArray = [NSMutableArray array];
        
        HotDeaModel *model = [[HotDeaModel alloc] init];
        model.t_description = responseObject[@"data"][@"description"];
        model.favorites_count = responseObject[@"data"][@"favorites_count"];
        model.cover_image_url = responseObject[@"data"][@"cover_image_url"];
        model.image_urls = responseObject[@"data"][@"image_urls"];
        model.name = responseObject[@"data"][@"name"];
        model.price = responseObject[@"data"][@"price"];
        model.purchase_url = responseObject[@"data"][@"purchase_url"];
        model.url = responseObject[@"data"][@"url"];
        
        [weakSelf.dataArray addObject:model];
        
        
        passValue(weakSelf.dataArray);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}



@end
