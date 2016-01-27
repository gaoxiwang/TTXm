//
//  ZBLikeViewCell.h
//  GiftSpeak
//
//  Created by lanou3g on 15/8/22.
//  Copyright (c) 2015年 TWZ. All rights reserved.
//

#import <UIKit/UIKit.h>
//精品的model
@class ZBItemModel;

@interface ZBLikeViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (strong, nonatomic) ZBItemModel *model;

@end
