//
//  MyWebViewController.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "MyWebViewController.h"
#import <WebKit/WebKit.h>
@interface MyWebViewController ()<UIWebViewDelegate>
@property(strong,nonatomic)UIWebView *webView;
@property(strong,nonatomic)WKWebView *web;


@end

@implementation MyWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    NSURLRequest *req = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:_string]];
    [_webView loadRequest:req];
    _webView.userInteractionEnabled = YES;
    _webView.scalesPageToFit = YES;
    
    [self.view addSubview:_webView];
    
//    _web = [[WKWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    [_web loadHTMLString:_string baseURL:nil];
//    [self.view addSubview:_web];
    
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
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
