//
//  MLIndexPathTableViewController.h
//  TTXM_ShoppingSoftware
//
//  Created by 小明 on 16/1/19.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLIndexPathTableViewController : UITableViewController
@property (nonatomic,strong) HotDeaModel *model;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *money;
@property (nonatomic,strong) UILabel *picLabel;
@property (nonatomic,strong) UILabel *descriptionLabel;
//购物Button
@property (nonatomic,strong) UIButton *shoping;
@end
