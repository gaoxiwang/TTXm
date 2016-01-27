//
//  ZBStrategyViewCell.h
//  GiftSpeak
//
//  Created by lanou3g on 15/8/22.
//  Copyright (c) 2015年 TWZ. All rights reserved.
//

#import <UIKit/UIKit.h>
//分类model
@class SubjectList;

@interface ZBStrategyViewCell : UITableViewCell

@property (strong, nonatomic) SubjectList *subjectList;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
