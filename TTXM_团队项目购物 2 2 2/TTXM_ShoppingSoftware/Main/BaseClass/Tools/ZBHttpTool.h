//
//  ZBHttpTool.h
//  GiftTalk
//
//  Created by lanou3g on 15/8/16.
//  Copyright (c) 2015年 Mr.Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBHttpTool : NSObject
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end
