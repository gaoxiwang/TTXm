//
//  JLLIkeController.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "JLLIkeController.h"
#import "ZBLikeViewCell.h"
#import "ZBHttpTool.h"
//#import "ZBItemModel.h"
//#import "MJExtension.h"
#import "ZBNSKeyedArchiverTool.h"
#import "JLMainViewController.h"
//#import "Reachability.h"

@interface JLLIkeController ()

@end

@implementation JLLIkeController
#pragma mark - 懒加载
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

#pragma mark - 便利构造器
+ (instancetype)likeControllerWithContoller:(UIViewController *)controller {
    JLLIkeController *like= [[JLLIkeController alloc] init];
    [controller addChildViewController:like];
    return like;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置没有数据的cell分隔线celar
    [self setExtraCellLineHidden:self.tableView];
    
    // 设置区未
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    self.tableView.tableFooterView = footerView;
  


}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 加载数据
    [self loadLocalDatas];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.dataArray removeAllObjects];
}

#pragma mark - 设置没有数据的cell分隔线celar
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}

#pragma mark - 加载数据
- (void)loadLocalDatas {
    ZBNSKeyedArchiverTool *tool = [ZBNSKeyedArchiverTool sharedZBNSKeyedArchiverTool];
    NSMutableArray *savedLikes = [tool objectForKeyPath:@"sevedLike"];
    [self.dataArray addObjectsFromArray:savedLikes];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZBLikeViewCell *cell = [ZBLikeViewCell cellWithTableView:tableView];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
