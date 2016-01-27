//
//  ZBStrategyViewCell.m
//  GiftSpeak
//
//  Created by lanou3g on 15/8/22.
//  Copyright (c) 2015年 TWZ. All rights reserved.
//

#import "ZBStrategyViewCell.h"
//引入分类model
//#import "Subject.h"
#import "UIImageView+WebCache.h"

@interface ZBStrategyViewCell()
@property (strong, nonatomic) IBOutlet UIImageView *myImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;


@end

@implementation ZBStrategyViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"likeCell";
    ZBStrategyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
    }
    return cell;
}

//赋值
- (void)setSubjectList:(SubjectList *)subjectList {
    _subjectList = subjectList;
    
    //self.nameLabel.text = subjectList.title;
    
    //[self.myImageView sd_setImageWithURL:[NSURL URLWithString:subjectList.cover_image_url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

@end
