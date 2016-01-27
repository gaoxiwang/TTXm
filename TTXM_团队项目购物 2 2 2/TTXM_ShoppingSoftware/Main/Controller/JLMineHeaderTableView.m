//
//  JLMineHeaderTableView.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "JLMineHeaderTableView.h"
#import "JLMineHeaderTableViewModel.h"
#import "JLMineidentityController.h"
#import "ZBMineidentityTool.h"
#import "HQNavigationController.h"
#import "AppDelegate.h"
#import "SDImageCache.h"
#import "AboutUsViewController.h"
@interface JLMineHeaderTableView ()<UIAlertViewDelegate>
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *dataArray2;
@property (strong,nonatomic) UISwitch *swith;//夜间模式开关
@property (strong,nonatomic) UIAlertView *alertView;
@property(strong,nonatomic) UIAlertView *alertView1;

@end

@implementation JLMineHeaderTableView
/** 懒加载数据 */
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray array];
        
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MineHeaderTableView" ofType:@"plist"]];
        for (NSDictionary *dic in array) {
            JLMineHeaderTableViewModel *model = [JLMineHeaderTableViewModel mineHeaderTVMWithDict:dic];
            [self.dataArray addObject:model];
        }
        
    }
    return _dataArray;
}
- (NSMutableArray *)dataArray2 {
    if (!_dataArray2) {
        
        _dataArray2 = [NSMutableArray array];
        
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MineHeaderTableView2" ofType:@"plist"]];
        for (NSDictionary *dic in array) {
            JLMineHeaderTableViewModel *model = [JLMineHeaderTableViewModel mineHeaderTVMWithDict:dic];
            [self.dataArray2 addObject:model];
        }
        
    }
    return _dataArray2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置没有数据的cell分隔线celar
    [self setExtraCellLineHidden:self.tableView];
    
    // 设置导航属性
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(backClick) Image:@"back" selectedImage:@"back"];
    self.tableView = [[UITableView alloc] initWithFrame:self.tableView.bounds style:UITableViewStyleGrouped];
    
    // title
    self.navigationItem.title = @"设置";
    //初始化开关
    self.swith = [[UISwitch alloc]init];
    [self.swith addTarget:self action:@selector(updateSwitchAtIndexPath:) forControlEvents:(UIControlEventValueChanged)];
   
    
    
}
#pragma mark - 返回按钮
- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}

//设置没有数据的cell分隔线celar
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 隐藏TabBar
    [self.tabBarController.tabBar setHidden:YES];
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 隐藏TabBar
    [self.tabBarController.tabBar setHidden:NO];
}
+ (instancetype)mineHeaderTableViewWithContoller:(UIViewController *)controller {
    JLMineHeaderTableView *headerTV = [[JLMineHeaderTableView alloc] init];
    [controller addChildViewController:headerTV];
    return headerTV;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }else{
        return 3;
    }
    
}
#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"headerCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    // 设置cell
    [self setupCell:cell indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
#pragma mark - 设置cell
- (void)setupCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        JLMineHeaderTableViewModel *model = self.dataArray[indexPath.row];
        cell.textLabel.text = model.name;
        cell.imageView.image = [UIImage imageNamed:model.image];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        // 我的身份
        if (indexPath.row == 0) {
            NSString *genderStr = [ZBMineidentityTool sharedZBMineidentityTool].genderStr;
            NSString *generationStr = [ZBMineidentityTool sharedZBMineidentityTool].generationStr;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",genderStr, generationStr];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        // 夜间模式
        if (indexPath.row == 1) {
            
            cell.accessoryView = self.swith;
        }
        
        // 设置清除缓存
        if (indexPath.row == 2) {
            cell.detailTextLabel.text = @"清清更健康";
        }
        
    }else {
        JLMineHeaderTableViewModel *model = self.dataArray2[indexPath.row];
        cell.textLabel.text = model.name;
        cell.imageView.image = [UIImage imageNamed:model.image];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}

-(void)updateSwitchAtIndexPath:(UISwitch *)sender{
    if ([self.swith isOn]) {
        self.view.window.alpha = 0.4;
    
    }else{
        
        self.view.window.alpha = 1;
    }
    
}
#pragma mark - cell点击事件代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            JLMineidentityController *mineidentityC = [JLMineidentityController new];
            [self.navigationController pushViewController:mineidentityC animated:YES];
        }
        
        if (indexPath.row == 2) {
            NSLog(@"清除缓存");
            self.alertView1 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否清除缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [_alertView1 show];

        }
    }else {
        if (indexPath.row == 0) {
            NSLog(@"意见反馈");
            AboutUsViewController *AboutUs=[AboutUsViewController new];
            [self showViewController:AboutUs sender:nil];
        }
        
        if (indexPath.row == 1) {
            NSLog(@"关于我们");
            
        }
        if (indexPath.row == 2) {
            NSLog(@"推出应用");
            self.alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否退出应用" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [_alertView show];
        }
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView==self.alertView && buttonIndex ==1) {
        AppDelegate *app=[UIApplication sharedApplication].delegate;
        UIWindow *window =app.window;
        [UIView animateWithDuration:0.7f animations:^{
            window.alpha =0;
            window.frame =CGRectMake(0, window.bounds.size.width, 0, 0);
        } completion:^(BOOL finished) {
            exit(0);
        }];
        //无动画
//        window.alpha=0;
//        window.frame=CGRectMake(0, window.bounds.size.width, 0, 0);
//        exit(0);
    }else if (alertView==self.alertView1 && buttonIndex==1){
        [MBProgressHUD showMessage:@"正在清理"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            float clearsize = [[SDImageCache sharedImageCache] checkTmpSize];
            [MBProgressHUD showSuccess:[NSString stringWithFormat:@"成功清理%.2fM缓存",clearsize]];
            [[SDImageCache sharedImageCache]clearDisk];
            [[SDImageCache sharedImageCache]clearDisk];
            [[SDImageCache sharedImageCache]clearMemory];
        });
    }
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
