//
//  HQNavigationController.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "HQNavigationController.h"

@interface HQNavigationController ()

@end

@implementation HQNavigationController
+ (void)initialize
{
    // 过去当前的navB和Item
    UINavigationBar *navB = [UINavigationBar appearance];
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    //设置整个Bartint的颜色
    navB.barTintColor = [UIColor colorWithRed:243/255.0 green:53/255.0 blue:62/255.0 alpha:1];;
    navB.tintColor = [UIColor whiteColor];
    navB.barStyle = UIBarStyleBlack;
    
    //设置title的字体颜色
    [navB setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:20],NSFontAttributeName, nil]];
    
    // 设置整个项目所有item的主题样式
    item.tintColor = [UIColor whiteColor];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
