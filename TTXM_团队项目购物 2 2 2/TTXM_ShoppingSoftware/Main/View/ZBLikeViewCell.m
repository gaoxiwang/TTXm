//
//  ZBLikeViewCell.m
//  GiftSpeak
//
//  Created by lanou3g on 15/8/22.
//  Copyright (c) 2015年 TWZ. All rights reserved.
//

#import "ZBLikeViewCell.h"
#import "UIImageView+WebCache.h"
//单品model
//#import "ZBItemModel.h"

@interface ZBLikeViewCell()

@property (strong, nonatomic) IBOutlet UIImageView *myImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation ZBLikeViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"likeCell";
    ZBLikeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
    }
    return cell;
}
//赋值
- (void)setModel:(ZBItemModel *)model {
    _model = model;
//    self.nameLabel.text = model.name;
//    self.descLabel.text = model.desc;
//
//    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
    
}

@end
