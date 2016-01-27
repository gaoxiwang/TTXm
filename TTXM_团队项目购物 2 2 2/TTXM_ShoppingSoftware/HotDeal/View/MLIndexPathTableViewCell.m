//
//  MLIndexPathTableViewCell.m
//  TTXM_ShoppingSoftware
//
//  Created by 小明 on 16/1/20.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "MLIndexPathTableViewCell.h"

@interface MLIndexPathTableViewCell ()

@end

@implementation MLIndexPathTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        [self drawView];
        
    }

    return self;


}
-(void)drawView{

    
    
    //初始化最底部的scrollView,装tableView用
    self.backgroundScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.backgroundScrollView.contentSize = CGSizeMake(kScreenWidth * 2, 0);
    self.backgroundScrollView.backgroundColor = [UIColor greenColor];
    self.backgroundScrollView.pagingEnabled = YES;
    self.backgroundScrollView.bounces = NO;
    //是否能够滑动
    self.backgroundScrollView.scrollEnabled =NO;
    self.backgroundScrollView.showsHorizontalScrollIndicator = NO;
    //    self.backgroundScrollView.delegate = self;
    [self.contentView addSubview:self.backgroundScrollView];
    
  
    //评价tableView
    self.evaluationTableView = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight)];
    self.evaluationTableView.backgroundColor =[UIColor grayColor];
    [self.backgroundScrollView addSubview:self.evaluationTableView];
    
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
