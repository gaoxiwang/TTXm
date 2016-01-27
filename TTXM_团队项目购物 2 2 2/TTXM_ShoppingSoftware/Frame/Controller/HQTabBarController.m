//
//  HQTabBarController.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "HQTabBarController.h"
#import "ZBMineidentityTool.h"

@interface HQTabBarController ()

@end

@implementation HQTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = [UIColor colorWithRed:243/255.0 green:53/255.0 blue:62/255.0 alpha:1];
    self.tabBar.barTintColor = [UIColor whiteColor];
    
    //添加控制器
    HQHomeViewController *HQHomeVC = [[HQHomeViewController alloc] init];
    [self addChildVC:HQHomeVC title:@"首页" image:@"iconfont-shouyeshouye"];
    
    MLHotDealViewController *MLHotDaelVC = [[MLHotDealViewController alloc] init];
    [self addChildVC:MLHotDaelVC title:@"热门" image:@"iconfont-remen"];
    
    XWCategoryViewController *XWCategoryVC = [[XWCategoryViewController alloc] init];
    [self addChildVC:XWCategoryVC title:@"分类" image:@"iconfont-fenlei"];
    
    JLMainViewController *JLMainVC = [[JLMainViewController alloc] init];
    [self addChildVC:JLMainVC title:@"我的" image:@"iconfont-wode"];
    
    //切换男女并记忆
    ZBMineidentityTool *identityTool = [ZBMineidentityTool sharedZBMineidentityTool];
    if ([identityTool.gender isEqual:@2]) {
        JLMainVC.tabBarItem.image = [UIImage imageNamed:@"Women"];
    }else{
        JLMainVC.tabBarItem.image = [UIImage imageNamed:@"Man"];
        
    }
}

-(void)addChildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image
{

    //设置子控制器的标题
    childVC.tabBarItem.title = title;

    childVC.tabBarItem.image = [UIImage imageNamed:image];
    
    //给子控制器添加一个导航控制器
    HQNavigationController *navNC = [[HQNavigationController alloc] initWithRootViewController:childVC];
    
    //添加子控制器
    [self addChildViewController:navNC];



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
