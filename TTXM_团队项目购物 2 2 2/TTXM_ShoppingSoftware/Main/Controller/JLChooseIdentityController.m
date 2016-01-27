//
//  JLChooseIdentityController.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "JLChooseIdentityController.h"
#import "ZBMineidentityTool.h"
@interface JLChooseIdentityController ()
@property (assign, nonatomic) NSInteger count;
@end

@implementation JLChooseIdentityController
- (NSInteger)count {
    return self.textLabelArray.count;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.count == 2) {
        self.title = @"选择性别";
    }else {
        self.title = @"选择角色";
    }
    
    //设置没有数据的cell分隔线celar
    [self setExtraCellLineHidden:self.tableView];
    
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

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.textLabelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"chooseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:ID];
    }
    cell.textLabel.text = self.textLabelArray[indexPath.row];
    cell.textLabel.textAlignment = UITextLayoutDirectionLeft;
    NSNumber *gender = [ZBMineidentityTool sharedZBMineidentityTool].gender;
    NSNumber *generation = [ZBMineidentityTool sharedZBMineidentityTool].generation;
    
    if (self.count == 2) { // 判断性别还是角色
        if ([gender isEqual:@1] && indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else if ([gender isEqual:@2] && indexPath.row == 1) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
    }else {
        if ([generation isEqual:@(self.count - indexPath.row - 1)]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
        
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZBMineidentityTool *genderTool = [ZBMineidentityTool sharedZBMineidentityTool];
    ZBMineidentityTool *generationTool = [ZBMineidentityTool sharedZBMineidentityTool];
    NSInteger count = self.textLabelArray.count;

    if (count == 2) {
        genderTool.gender = @(indexPath.row + 1);
    }else {
        generationTool.generation = @(count - 1 - indexPath.row);
    }
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"user" object:nil userInfo:@{@"gender":genderTool.gender, @"generation":genderTool.generation}];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
