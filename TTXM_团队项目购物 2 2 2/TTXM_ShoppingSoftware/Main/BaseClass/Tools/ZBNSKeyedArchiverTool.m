//
//  ZBNSKeyedArchiverTool.m
//  GiftSpeak
//
//  Created by lanou3g on 15/8/22.
//  Copyright (c) 2015年 TWZ. All rights reserved.
//

#define filePath(path) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:path]

#import "ZBNSKeyedArchiverTool.h"

@interface ZBNSKeyedArchiverTool ()

@end

@implementation ZBNSKeyedArchiverTool
singleton_implementation(ZBNSKeyedArchiverTool);

/** 取出 */
- (NSMutableArray *)objectForKeyPath:(NSString *)path {
    
    // 取出路径下的文件
    NSMutableArray *savedArray = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath(path)];
    
    return savedArray;
}

/** 添加 */
- (void)addObject:(id)object forKeyPath:(NSString *)path {
    
    NSMutableArray *savedArray = [self objectForKeyPath:path];
    NSMutableArray *savedArr = [NSMutableArray arrayWithArray:savedArray];
    
    [savedArr addObject:object];
    [NSKeyedArchiver archiveRootObject:savedArr toFile:filePath(path)];
    NSLog(@"喜欢的礼物 -- %ld", (unsigned long)savedArr.count);

}

/** 移除 */
- (void)removeObject:(id)object objectKey:(NSString *)key forKeyPath:(NSString *)path {
    
    NSMutableArray *savedArray = [self objectForKeyPath:path];
    NSMutableArray *savedArr = [NSMutableArray arrayWithArray:savedArray];
    
    if (key) {
        for (id obj in savedArr) {
            
            if ([[object valueForKey:key] isEqual:[obj valueForKey:key]]) {
                [savedArr removeObject:obj];
            }
            
        }
        [NSKeyedArchiver archiveRootObject:savedArr toFile:filePath(path)];
         NSLog(@"喜欢的礼物 -- %ld", (unsigned long)savedArr.count);
    }else {
        
        [savedArr removeObject:object];
        [NSKeyedArchiver archiveRootObject:savedArr toFile:filePath(path)];
        NSLog(@"喜欢的礼物 -- %ld", (unsigned long)savedArr.count);
    }
   
}

/** 判断当前对象是否存在 */
- (BOOL)isExistingWithObjcet:(id)object objectKey:(NSString *)key forKeyPath:(NSString *)path {
    NSMutableArray *savedArray = [self objectForKeyPath:path];
    
    NSLog(@"object%@",[object valueForKey:key]);
    
    if (key) {
        for (id obj in savedArray) {
            NSLog(@"obj%@",[obj valueForKey:key]);
            if ([[object valueForKey:key] isEqual:[obj valueForKey:key]]) {
                return YES;            }
        }
        return NO;
    }else {
        
        for (id obj in savedArray) {
            
            if ([object isEqual:obj]) {
                return YES;
            }
        }
    }
    return NO;
}



@end
