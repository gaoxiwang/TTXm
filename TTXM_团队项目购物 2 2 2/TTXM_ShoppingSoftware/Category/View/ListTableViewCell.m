//
//  ListTableViewCell.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/26.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self draw];
    }
    return self;
}

-(void)draw
{
    _nameLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWidth/4, kHeight/14)];
    _nameLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_nameLable];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
