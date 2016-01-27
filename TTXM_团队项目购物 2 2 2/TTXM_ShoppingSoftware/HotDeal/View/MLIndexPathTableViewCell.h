//
//  MLIndexPathTableViewCell.h
//  TTXM_ShoppingSoftware
//
//  Created by 小明 on 16/1/20.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLIndexPathTableViewCell : UITableViewCell

/** 最底部的scrollView，用来掌控所有控件的滚动 */
@property (nonatomic, strong) UIScrollView               *backgroundScrollView;
@property (nonatomic, strong) HotDeaModel *model;
/** 评价tableview */
@property (nonatomic, strong) UITableView *evaluationTableView;



@end
