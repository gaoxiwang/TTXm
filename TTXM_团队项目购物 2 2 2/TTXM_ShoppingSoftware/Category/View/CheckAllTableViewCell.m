//
//  CheckAllTableViewCell.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "CheckAllTableViewCell.h"

@implementation CheckAllTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self draw];
    }
    return self;
}

-(void)draw
{
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, kWidth-20, kWidth/3+20)];
    _imgView.layer.cornerRadius = 20;
    _imgView.layer.masksToBounds = YES;
    [self.contentView addSubview:_imgView];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 10, kWidth-20, kWidth/3+20)];
    view.backgroundColor = [UIColor grayColor];
    view.alpha = 0.4;
    [self.contentView addSubview:view];
    _lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, kWidth-20, 40)];
    _lab1.textAlignment = NSTextAlignmentCenter;
    _lab1.font = [UIFont systemFontOfSize:20];
    _lab1.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_lab1];
    _lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_lab1.frame)+10, kWidth-20, 30)];
    _lab2.textAlignment = NSTextAlignmentCenter;
    _lab2.font = [UIFont systemFontOfSize:20];
    _lab2.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_lab2];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
