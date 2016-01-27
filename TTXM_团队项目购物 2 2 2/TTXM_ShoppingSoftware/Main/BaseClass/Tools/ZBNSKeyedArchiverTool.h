//
//  ZBNSKeyedArchiverTool.h
//  GiftSpeak
//
//  Created by lanou3g on 15/8/22.
//  Copyright (c) 2015年 TWZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBNSKeyedArchiverTool : NSObject
singleton_interface(ZBNSKeyedArchiverTool);

/** 取出 */
- (NSMutableArray *)objectForKeyPath:(NSString *)path;

/** 添加 */
- (void)addObject:(id)object forKeyPath:(NSString *)path;

/** 移除 */
- (void)removeObject:(id)object objectKey:(NSString *)key forKeyPath:(NSString *)path;

/** 判断当前对象是否存在 */
- (BOOL)isExistingWithObjcet:(id)object objectKey:(NSString *)key forKeyPath:(NSString *)path;

@end
