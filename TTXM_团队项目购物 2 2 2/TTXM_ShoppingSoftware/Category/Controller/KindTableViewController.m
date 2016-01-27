//
//  KindTableViewController.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "KindTableViewController.h"

@interface KindTableViewController ()
@property(strong,nonatomic)NSMutableArray *dataArray;
@property(assign,nonatomic)NSInteger fresh;

@end

@implementation KindTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    [self json:_urlString];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    


}
-(void)loadMoreData
{
    _fresh += 20;
    [self.tableView.mj_footer beginRefreshing];
    
    [self json:[NSString stringWithFormat:@"http://api.liwushuo.com/v2/channels/111/items?generation=2&gender=1&order_by=now&limit=20&offset=%ld",_fresh]];
    [self.tableView reloadData];
    
    
    [self.tableView.mj_footer endRefreshing];
}
-(void)loadNewData
{
    [self.tableView.mj_header beginRefreshing];
    if (_dataArray == nil)
    {
        [self json:_urlString];
    }
    [self.tableView reloadData];
    
    [self.tableView.mj_header endRefreshing];
    
}

-(void)json:(NSString *)string
{
    NSURL *url = [NSURL URLWithString:string];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            
            NSMutableArray *array = [dic[@"data"] objectForKey:@"items"];
            for (NSDictionary *dicc in array)
            {
                HeadDeatilModel *model = [HeadDeatilModel new];
                [model setValuesForKeysWithDictionary:dicc];
                [_dataArray addObject:model];
                
                
            }
            
            [self.tableView registerClass:[HeadDetailTableViewCell class] forCellReuseIdentifier:@"cell"];
            [self.tableView reloadData];
            
        });
        
    }];
    
    [task resume];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHeight/4+10;
}
//贴了一层灰色图层 圆角显示不是很明显 不过效果还可以
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HeadDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    HeadDeatilModel *model = [HeadDeatilModel new];
    model = _dataArray[indexPath.row];
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
    cell.imgView.layer.cornerRadius = 15;
    cell.imgView.layer.masksToBounds = YES;
    cell.title.text = model.title;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyWebViewController *web = [MyWebViewController new];
    HeadDeatilModel *model = _dataArray[indexPath.row];
    web.string = model.content_url;
    [self.navigationController pushViewController:web animated:YES];
    
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
