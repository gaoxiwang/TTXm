//
//  HeadDetailTableViewController.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/18.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "HeadDetailTableViewController.h"

@interface HeadDetailTableViewController ()
@property(strong,nonatomic)NSMutableArray *dataArray;
@end

@implementation HeadDetailTableViewController


- (void)viewWillAppear:(BOOL)animated{
    
    }

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.dataArray = [NSMutableArray array];
    NSString * string = self.myUrl;
    NSURL *url = [NSURL URLWithString:string];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            if (data == nil)
            {
                dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
   
            }
            NSMutableArray *array = [dic[@"data"] objectForKey:@"posts"];
            for (NSDictionary *dicc in array)
            {
                HeadDeatilModel *model = [HeadDeatilModel new];
                [model setValuesForKeysWithDictionary:dicc];
                [_dataArray addObject:model];
                
            }
            self.tableView.delegate = self;
            self.tableView.dataSource = self;
            
            [self.tableView registerClass:[HeadDetailTableViewCell class] forCellReuseIdentifier:@"cell"];
            
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HeadDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    HeadDeatilModel *model = [HeadDeatilModel new];
    model = _dataArray[indexPath.row];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
    cell.title.text = model.title;

    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHeight/4+10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyWebViewController *myweb = [MyWebViewController new];
    HeadDeatilModel *model = [HeadDeatilModel new];
    model = _dataArray[indexPath.row];
    myweb.string = model.content_url;
    [self.navigationController pushViewController:myweb animated:YES];
    
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
