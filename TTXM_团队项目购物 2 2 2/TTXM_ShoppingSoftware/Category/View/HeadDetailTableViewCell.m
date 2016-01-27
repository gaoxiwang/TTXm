//
//  HeadDetailTableViewCell.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/18.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "HeadDetailTableViewCell.h"

@implementation HeadDetailTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self draw];
    }
    return self;
}

-(void)draw
{
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, kWidth-20, kHeight/4)];
    [self.contentView addSubview:_imgView];
    _imgView.layer.cornerRadius = 10;
    _imgView.layer.masksToBounds = YES;
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(10, 10, kWidth-20, kHeight/4)];
    backview.backgroundColor = [UIColor blackColor];
    backview.alpha = 0.3;
    [self.contentView addSubview:backview];
    _title = [[UILabel alloc]initWithFrame:CGRectMake(25, kHeight/4-60, kWidth-20, 60)];
    _title.textColor = [UIColor whiteColor];
    _title.numberOfLines = 0;
    _title.font = [UIFont systemFontOfSize:20];
    
    [self.contentView addSubview:_title];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
