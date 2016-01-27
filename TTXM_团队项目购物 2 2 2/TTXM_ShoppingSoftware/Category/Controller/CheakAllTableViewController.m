//
//  CheakAllTableViewController.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "CheakAllTableViewController.h"

@interface CheakAllTableViewController ()
@property(strong,nonatomic)NSMutableArray *dataArray;
@property(assign,nonatomic)NSInteger fresh;
@end

@implementation CheakAllTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"全部专题";
    _dataArray = [NSMutableArray array];
    [self json:checkAllURL];

    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction   :@selector(loadNewData)];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}
-(void)json:(NSString *)urlString
{
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            NSMutableArray *array = [dic[@"data"] objectForKey:@"collections"];
            for (NSDictionary *dicc in array) {
                special *model = [special new];
                [model setValuesForKeysWithDictionary:dicc];
                [_dataArray addObject:model];
            }
            
            [self.tableView registerClass:[CheckAllTableViewCell class] forCellReuseIdentifier:@"check"];
            self.tableView.delegate = self;
            self.tableView.dataSource = self;
            [self.tableView reloadData];
            
        });
        
        
    }];
    
    [task resume];
}


-(void)loadMoreData
{
    
    _fresh += 20;
    [self.tableView.mj_footer beginRefreshing];
    [self json:[NSString stringWithFormat:@"http://api.liwushuo.com/v2/collections?limit=20&offset=%ld",_fresh]];
    [self.tableView reloadData];
    
    [self.tableView.mj_footer endRefreshing];
    
}
-(void)loadNewData
{
    [self.tableView.mj_header beginRefreshing];
    if (_dataArray == nil)
    {
        [self json:allURL];
        
    }
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CheckAllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"check" forIndexPath:indexPath];
    special *model = [special new];
    model = _dataArray[indexPath.row];
    
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
    cell.lab2.text = model.subtitle;
    cell.lab1.text = model.title;
    
    
    
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHeight/4;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeadDetailTableViewController *detail = [HeadDetailTableViewController new];
    special *model = [special new];
    model = _dataArray[indexPath.row];
    NSString *string = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/collections/%@/posts?limit=20&offset=0",model.s_id];
    detail.myUrl = string;
    [self.navigationController pushViewController:detail animated:YES];
    
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
