//
//  AnalysisTool.h
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/16.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PassValue) (NSMutableArray *dataArray);

@interface AnalysisTool : NSObject

//其它页数据解析
-(void)dataAnalysisWithIndex:(NSInteger)index _id:(NSNumber *)_id gender:(NSInteger)gender generation:(NSInteger)generation passValue:(PassValue)passValue;

//精选页轮播图数据解析
-(void)lunBoDataAnalysisWithPassValue:(PassValue)passValue;

//精选页轮播图进入列表详情页数据解析
-(void)lunBoListdataAnalysisWithIndex:(NSInteger)index _id:(NSNumber *)_id gender:(NSInteger)gender generation:(NSInteger)generation passValue:(PassValue)passValue;

-(void)collectionDataAnalysisWithGender:(NSInteger)gender generation:(NSInteger)generation passValue:(PassValue)passValue;

//搜索详情页数据解析
-(void)searchDataAnalysisWithID:(NSNumber *)ID passValue:(PassValue)passValue;



@end
