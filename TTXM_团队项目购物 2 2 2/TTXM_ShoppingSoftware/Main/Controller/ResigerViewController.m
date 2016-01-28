//
//  ResigerViewController.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/28.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "ResigerViewController.h"

@interface ResigerViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@end

@implementation ResigerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resigerAction:(id)sender {
    
    AVUser *user = [AVUser user];
    user.username = self.userNameTextField.text;
    user.password = self.passwordTextField.text;
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(注册成功) userInfo:nil repeats:NO];
            
            
        }else
        {
            NSLog(@"%@",error);
            
        }
        
    }];

    
    
}

-(void)注册成功
{
    
    [self.view endEditing:YES];
    
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (IBAction)outsideAction:(id)sender {
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
