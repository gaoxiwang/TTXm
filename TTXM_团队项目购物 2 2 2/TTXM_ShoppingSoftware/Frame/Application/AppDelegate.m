//
//  AppDelegate.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (strong,nonatomic) FristWheelViewController *firstWheelVC;
@end

@implementation AppDelegate

#pragma mark -----------首页 ----------------

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 判断是不是第一次打开应用，如果是第一次显示引导页
    NSLog(@"%d",[[NSUserDefaults standardUserDefaults] boolForKey:@"first"]);
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"first"]) {
        self.firstWheelVC = [[FristWheelViewController alloc] init];
        self.window.rootViewController = self.firstWheelVC;
        
        __weak AppDelegate *weakSelf = self;
        self.firstWheelVC.didSelectedEnder = ^(){
            
            NSLog(@"jdsarieowfksdnzvkdhjirhagfivjfiasl/kmld");
            
            
            // 选择性别gender和年代generation的view
            SelectView *selectView = [[SelectView alloc] initWithFrame:CGRectMake(0, 0, weakSelf.window.bounds.size.width, weakSelf.window.bounds.size.height)];
            [weakSelf.window addSubview:selectView];
            [weakSelf.firstWheelVC.view removeFromSuperview];
            weakSelf.firstWheelVC = nil;
            
            [[NSNotificationCenter defaultCenter] addObserver:weakSelf selector:@selector(didRecieveNotification:) name:@"open" object:nil];
        };
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"first"];
        
    } else {
        
        HQTabBarController *tabBar = [[HQTabBarController alloc] init];
        self.window.rootViewController = tabBar;
        NSLog(@"jdsarieowfksdnzvkdhjirhagfivjfiasl/kmld");
    }
    
    
#pragma mark -----------第二页 分享 ----------------
    //微博
    [UMSocialData setAppKey:@"569f907667e58e1c20002ca3"];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wxe748380a414bc7c4" appSecret:@"fbca17bfd07aeaf9fce9a13652d96b70" url:@"http://www.umeng.com/social"];
    
    return YES;
}

#pragma mark -----------首页 导入的方法 ----------------

- (void)didRecieveNotification:(NSNotification *)sender
{
    // 初始化主页homeVC
    HQTabBarController *tabBar = [[HQTabBarController alloc] init];
    self.window.rootViewController = tabBar;
    
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
