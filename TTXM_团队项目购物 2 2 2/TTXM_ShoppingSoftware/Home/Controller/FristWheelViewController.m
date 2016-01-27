//
//  FristWheelViewController.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "FristWheelViewController.h"

@interface FristWheelViewController ()<UIScrollViewDelegate>

#pragma mark - 私有属性
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *openButton;



@end

#define kWidth self.view.bounds.size.width
#define kHeight self.view.bounds.size.height
#define kGap kWidth/20

@implementation FristWheelViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self getGuideView];
}

#pragma mark - 设置引导图
- (void)getGuideView
{
    NSInteger imageCount = 4;  // 4张图片
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * imageCount, self.view.bounds.size.height);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    for (int i = 0; i < imageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * i, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_image.jpg", i + 1]];
        [self.scrollView addSubview:imageView];
        
        // 到第四张图片时添加“开始体验”按钮
        if (i == 3) {
            [self setUpExperienceButton:imageView];
        }
    }
    [self.view addSubview:self.scrollView];
    [self setPageControl];
}

#pragma mark 设置下面的PageControl
- (void)setPageControl
{
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 200) * 0.5, self.view.bounds.size.height - 30, 200, 30)];
    self.pageControl.numberOfPages = 4;
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor cyanColor];
    
    [self.view insertSubview:self.pageControl aboveSubview:self.scrollView];
}

#pragma mark 设置“开始体验按钮”
- (void)setUpExperienceButton:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    UIButton *enterButton = [[UIButton alloc] init];
    [enterButton setTitle:@"开始体验" forState:UIControlStateNormal];
    [enterButton setTitleColor:[UIColor colorWithRed:0.855 green:0.492 blue:0.640 alpha:1.000] forState:UIControlStateNormal];
    enterButton.titleLabel.font = [UIFont systemFontOfSize:20];
    enterButton.backgroundColor = [UIColor whiteColor];
    enterButton.alpha = 0.8;
    [enterButton.layer setCornerRadius:5];
    enterButton.frame = CGRectMake((self.view.bounds.size.width - 180) * 0.5, self.view.bounds.size.height - 100, 180, 40);
    [enterButton addTarget:self action:@selector(removeGuideView) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:enterButton];
}

#pragma mark 按钮点击事件
- (void)removeGuideView
{
    if (self.didSelectedEnder) {
        self.didSelectedEnder();
    }
}

#pragma mark scrollView滑动时pageControl跟着变化
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / self.view.bounds.size.width;
    self.pageControl.currentPage = page;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
