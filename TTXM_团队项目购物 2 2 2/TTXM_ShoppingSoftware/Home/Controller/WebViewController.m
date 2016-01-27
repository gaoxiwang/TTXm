//
//  WebViewController.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>

@property (strong,nonatomic) UIWebView *webView;

@property (strong,nonatomic)UIActivityIndicatorView *activityIC;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    //设置自动适应屏幕大小
    self.webView.scalesPageToFit = YES;
    //设置用户交互
    self.webView.userInteractionEnabled = YES;
    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;
   
    //添加到视图
    [self.view addSubview:self.webView];
    //网络加载
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.webViewStr]];
    NSLog(@"WWWWWWW%@",self.webViewStr);
    //加载
    [self.webView loadRequest:request];
}

//代理方法
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    UIView *aView = [[UIView alloc] initWithFrame:self.view.bounds];
    aView.tag = 101;
    aView.alpha = 0.5;
    aView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:aView];
    //创建activityIC
    self.activityIC = [[UIActivityIndicatorView alloc] initWithFrame:self.view.bounds];
    self.activityIC.center = aView.center;
    [aView addSubview:self.activityIC];
    //动画开始
    [self.activityIC startAnimating];
    NSLog(@"开始加载");
    
    
    
}

//加载完成

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //通过tag值获取aView
    UIView *aView = [self.view viewWithTag:101];
    //停止动画
    [self.activityIC stopAnimating];
    //移除aView
    [aView removeFromSuperview];
    
    NSLog(@"开始完成");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    //通过tag获取aView
    UIView *aView = [self.view viewWithTag:101];
    //停止动画
    [self.activityIC stopAnimating];
    //移除aView
    [aView removeFromSuperview];
    NSLog(@"加载出错");
    
    
    
    
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
