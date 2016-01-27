//
//  OtherTableViewCell.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/18.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "OtherTableViewCell.h"

@implementation OtherTableViewCell

- (void)awakeFromNib {
    
    self.foreView.backgroundColor = [UIColor blackColor];
    self.foreView.alpha = 0.6;
    self.introduceLabel.textColor = [UIColor whiteColor];
    self.introduceLabel.backgroundColor = [UIColor clearColor];
    self.backgroundImgview.layer.cornerRadius = 5;
    self.backgroundImgview.layer.masksToBounds = YES;
    
    self.collectLabel.textColor = [UIColor whiteColor];
    self.collectLabel.backgroundColor = [UIColor clearColor];
    self.collectLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
