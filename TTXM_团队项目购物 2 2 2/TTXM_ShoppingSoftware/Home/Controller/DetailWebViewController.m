//
//  DetailWebViewController.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/23.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "DetailWebViewController.h"

@interface DetailWebViewController ()

{

    UIWindow *__sheetWindow ;//window必须为全局变量或成员变量

}
/**
 *  攻略详情页，WebView，只加载内容视图
 */

@property (strong,nonatomic) UIWebView *webView;
@property (strong,nonatomic) UIScrollView *scrollView;

@end

@implementation DetailWebViewController

#define kWidth (self.view.bounds.size.width)
#define kHeight (self.view.bounds.size.height)
#define kGap kWidth/20


- (void)viewDidLoad {
    //判断网络
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable && [[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] == NotReachable) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(7*kGap, kHeight *1/3, 6*kGap, 6*kGap)];
        imgView.image = [UIImage imageNamed:@"iconfont-wuwangluo01"];
        [self.view addSubview:imgView];
        self.view.backgroundColor = [UIColor whiteColor];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setImage:[UIImage imageNamed:@"iconfont-fanhui"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, kGap *2, 4*kGap, kGap);
        [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
    }
    [super viewDidLoad];
    [self loadData];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 3.5f*kGap, kWidth, kHeight - 3.5f*kGap)];
    self.webView.scrollView.bounces = NO;
    
}
#pragma mark - 返回的点击事件
- (void)backAction
{

    [self dismissViewControllerAnimated:YES completion:nil];

}
#pragma mark - 加载主页面视图
- (void)loadData
{

    NSString *contenturlString = [self contentHtmlUrlStringFromCompleteUrlString:self.model.url];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:contenturlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.webView loadHTMLString:responseObject[@"data"][@"content_html"] baseURL:nil];
        [self.view addSubview:self.webView];
        UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 3.5f*kGap)];
        back.backgroundColor = [UIColor colorWithRed:0.949 green:0.141 blue:0.063 alpha:1.000];
        //返回的button
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
        backButton.frame = CGRectMake(1/2*kGap, 1.6f*kGap, kGap *4, 1.7f*kGap);
        [backButton  setImage:[[UIImage imageNamed:@"iconfont-fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kGap *6, 1.6f*kGap, kGap *8, 1.7f*kGap)];
        label.text = @"攻略详情";
        label.font = [UIFont systemFontOfSize:20];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.textColor = [UIColor whiteColor];
        [back addSubview:label];
        [back addSubview:backButton];
        [self.view addSubview:back];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        return ;
        
    }];
    
    


}

#pragma mark - 把网址拼接成可请求的网址，这里的网址只有增加了v2就能够解析的数据，取到contentHtml显示，可去掉广告
- (NSString *)contentHtmlUrlStringFromCompleteUrlString:(NSString *)completeUrlString
{
    NSMutableString *contentHtmlUrl = [NSMutableString stringWithString:completeUrlString];
    [contentHtmlUrl insertString:@"/v2" atIndex:23];
    return contentHtmlUrl;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
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
