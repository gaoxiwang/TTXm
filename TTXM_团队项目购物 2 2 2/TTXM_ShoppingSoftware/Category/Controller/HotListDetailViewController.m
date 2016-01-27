//
//  HotListDetailViewController.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/27.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "HotListDetailViewController.h"
#import <WebKit/WebKit.h>
@interface HotListDetailViewController ()
@property(strong,nonatomic)WKWebView *webView;
@property(strong,nonatomic)UIWebView *web;


@end

@implementation HotListDetailViewController




-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _webView = [[WKWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    NSLog(@"%@",_urlString);
//    [_webView loadHTMLString:_urlString baseURL:nil];
//    [self.view addSubview:_webView];
  
    self.web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-15)];
    //self.web = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.web.scalesPageToFit = YES;
    [self.view addSubview:self.web];
    NSMutableURLRequest *re = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_urlString]];
    [self.web loadRequest:re];
    
    
    // Do any additional setup after loading the view.
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
