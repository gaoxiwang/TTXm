//
//  ZBIdentityFooder.m
//  GiftSpeak
//
//  Created by lanou3g on 15/8/21.
//  Copyright (c) 2015年 TWZ. All rights reserved.
//

#import "ZBIdentityFooder.h"

@interface ZBIdentityFooder()
@property (strong, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation ZBIdentityFooder

+ (instancetype)identityFooder
{
    ZBIdentityFooder *footView = [[NSBundle mainBundle] loadNibNamed:@"ZBIdentityFooder" owner:nil options:nil].firstObject;
    footView.backgroundColor = ZBColor(233, 233, 233, 1);
    footView.y = 88;
    footView.x = 0;
    footView.width = kScreenWidth;
    return footView;
}

@end
