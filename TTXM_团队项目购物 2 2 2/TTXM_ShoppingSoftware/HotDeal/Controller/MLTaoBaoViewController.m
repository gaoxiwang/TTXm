//
//  MLTaoBaoViewController.m
//  TTXM_ShoppingSoftware
//
//  Created by 小明 on 16/1/19.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "MLTaoBaoViewController.h"

@interface MLTaoBaoViewController ()

@end

@implementation MLTaoBaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc ]initWithImage:[UIImage imageNamed:@"返回"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
    
    
    
}
-(void)leftAction:(UIButton *)button{
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
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
