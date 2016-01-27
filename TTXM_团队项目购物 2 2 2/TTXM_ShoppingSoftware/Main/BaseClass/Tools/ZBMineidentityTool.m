//
//  ZBMineidentityTool.m
//  GiftSpeak
//
//  Created by lanou3g on 15/8/21.
//  Copyright (c) 2015年 TWZ. All rights reserved.
//

#import "ZBMineidentityTool.h"

@implementation ZBMineidentityTool
singleton_implementation(ZBMineidentityTool);

- (NSNumber *)gender {
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"gender"];
}

- (NSNumber *)generation {
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"generation"];
}

- (void)setGender:(NSNumber *)gender {
    [[NSUserDefaults standardUserDefaults] setObject:gender forKey:@"gender"];
}

- (void)setGeneration:(NSNumber *)generation {
    [[NSUserDefaults standardUserDefaults] setObject:generation forKey:@"generation"];
}



- (NSString *)genderStr {
    NSNumber *gender = [[NSUserDefaults standardUserDefaults] valueForKey:@"gender"];
    
   
    if ([gender isEqual:@1]) {
        return @"男";
        
        
    }else {
        
        return @"女";
        
    }
      
}

- (NSString *)generationStr {
    int generation = [[[NSUserDefaults standardUserDefaults] valueForKey:@"generation"] intValue];
    
    if (generation == 0) {
        return @"资深工作党";
    }else if (generation == 1) {
        return @"职场新人";
    }else if (generation == 2) {
        return @"大学生";
    }else if (generation == 3) {
        return @"高中生";
    }else {
        return @"初中生";
    }
}



@end
