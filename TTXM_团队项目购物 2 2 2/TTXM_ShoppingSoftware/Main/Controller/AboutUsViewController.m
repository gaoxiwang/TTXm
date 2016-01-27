//
//  AboutUsViewController.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/16.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"感谢您使用礼物说";
    // 设置导航属性
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(backClick) Image:@"back" selectedImage:@"back"];
    //添加背景图片和textView
    [self addImageView];

}
#pragma mark - 返回按钮
- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addImageView
{
    CGFloat widthScale = self.view.bounds.size.width/375;
    CGFloat heightScale = self.view.bounds.size.height/667;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AboutOurs.jpg"]];
    // 开启用户交互
    imageView.userInteractionEnabled = YES;
    [imageView setFrame:self.view.bounds];
    [self.view addSubview:imageView];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, (self.view.bounds.size.width - 30)*widthScale, 250*heightScale)];
    textView.center = CGPointMake(self.view.bounds.size.width/2, 480*heightScale);
    textView.backgroundColor = [UIColor whiteColor];
    textView.alpha = 0.5;
    [textView setEditable:NO];
    // 设置textView的字体及大小
    textView.font = [UIFont fontWithName:@"Arial" size:16];
    textView.textAlignment = NSTextAlignmentCenter;
    textView.text = [NSString stringWithFormat:@"   本应用高希望 周洪庆 马明亮 李金亮合作完成,历时2周有余,感谢您的支持!关于本App如有更好的建议，或者在哪方面有什么不足,请发送信息邮箱\n\nlijinliang163163.163.com"];
    
    // 圆角
    textView.layer.cornerRadius = 10;
    textView.layer.masksToBounds = YES;
    [imageView addSubview:textView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
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
