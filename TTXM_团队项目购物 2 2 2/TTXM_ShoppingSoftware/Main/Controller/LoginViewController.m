//
//  LoginViewController.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/28.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *resigerButton;
@property (strong,nonatomic) UserSingle *single;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.single = [UserSingle singleInOrNot];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginAction:(id)sender {
    
    
    if ([self.userNameTextField.text isEqualToString:@""]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名或密码不能为空,请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    [AVUser logInWithUsernameInBackground:self.userNameTextField.text password:self.passwordTextField.text block:^(AVUser *user, NSError *error) {
        if (user) {
            
            UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"登陆成功" preferredStyle:UIAlertControllerStyleAlert];
            
            self.single.singleOrNot = YES;
            
            [self presentViewController:alertController animated:YES completion:nil];
            
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(登陆成功) userInfo:nil repeats:NO];
            
        } else {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"账号或密码错误,请重新输入" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            self.single.singleOrNot = NO;
            
        }
    }];
    

}

-(void)登陆成功
{
    [self.view endEditing:YES];
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (IBAction)resigerAction:(id)sender {
    
    ResigerViewController *resigerVC = [[ResigerViewController alloc] init];
    [self.navigationController pushViewController:resigerVC animated:YES];
    
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
