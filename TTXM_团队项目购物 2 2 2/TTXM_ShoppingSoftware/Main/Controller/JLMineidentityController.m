//
//  JLMineidentityController.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "JLMineidentityController.h"
#import "UIBarButtonItem+ZBBarButton.h"
#import "ZBMineidentityTool.h"
#import "JLChooseIdentityController.h"
#import "ZBIdentityFooder.h"

@interface JLMineidentityController ()

@end

@implementation JLMineidentityController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航属性
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(backClick) Image:@"back" selectedImage:@"back"];
   
    self.navigationItem.title = @"我的身份";
    
    //设置没有数据的cell分隔线celar
    [self setExtraCellLineHidden:self.tableView];
    
    // 设置提示文字
    [self.tableView addSubview:[ZBIdentityFooder identityFooder]];
    
    // 设置背景色和偏移量
    self.tableView.backgroundColor = ZBColor(233, 233, 233, 1);
    self.tableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);

    
    
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
    [self.tableView reloadData];
}
#pragma mark - 返回按钮
- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"minedentityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString *genderStr = [ZBMineidentityTool sharedZBMineidentityTool].genderStr;
    NSString *generationStr = [ZBMineidentityTool sharedZBMineidentityTool].generationStr;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"性别";
        cell.detailTextLabel.text = genderStr;
    }else {
        cell.textLabel.text = @"角色";
        cell.detailTextLabel.text = generationStr;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JLChooseIdentityController *chooseVC = [JLChooseIdentityController new];
    if (indexPath.row == 0) {
        chooseVC.textLabelArray = @[@"男孩", @"女孩"];
    }else {
        chooseVC.textLabelArray = @[@"初中生", @"高中生", @"大学生", @"职场新人",  @"资深工作党"];
    }
    [self.navigationController pushViewController:chooseVC animated:YES];
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
