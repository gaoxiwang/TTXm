//
//  SearchCollection.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/21.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "SearchCollection.h"

@implementation SearchCollection

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self drawView];
    }
    return self;
}

- (void)drawView
{

    self.layout = [[XLPlainFlowLayout alloc] init];
    self.layout.minimumLineSpacing = 10;
    self.layout.minimumInteritemSpacing = 10;
    self.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.layout.headerReferenceSize = CGSizeMake(0, 35);
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:self.layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.bounces = NO;
    [self addSubview:self.collectionView];
}
@end
