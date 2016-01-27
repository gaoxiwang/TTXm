//
//  LunboTableViewController.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/18.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "LunboTableViewController.h"

@interface LunboTableViewController ()

@property (strong,nonatomic) NSMutableArray *dataArray;
@property (assign,nonatomic) NSInteger index;


@end

static NSString * const systemCell = @"systemCell";
@implementation LunboTableViewController

-(instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:style]) {
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-fanhui"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction)];
        
    }
    return self;


}

-(void)returnAction
{

    [self.navigationController popViewControllerAnimated:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OtherTableViewCell" bundle:nil] forCellReuseIdentifier:systemCell];
    self.gender = [[[NSUserDefaults standardUserDefaults] stringForKey:@"gender"] integerValue];
    self.generation = [[[NSUserDefaults standardUserDefaults] stringForKey:@"generation"] integerValue];
    
    __block typeof(self) weakSelf = self;
    
    [[AnalysisTool new] lunBoListdataAnalysisWithIndex:self.index _id:self._id gender:self.gender generation:self.generation passValue:^(NSMutableArray *dataArray) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.dataArray = dataArray;
            GiftListModel *model = [GiftListModel new];
            model = self.dataArray[0];
            self.navigationItem.title = model.allTitle;
            
//            [weakSelf.tableView.mj_footer beginRefreshing];
//            [weakSelf.tableView.mj_header beginRefreshing];
            [weakSelf.tableView reloadData];
        });
        
        
    }];
    
    
    
#pragma mark == 上拉加载和下拉刷新
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadDownData)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDownData1)];
    
    
    
    
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

    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 160;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OtherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:systemCell forIndexPath:indexPath];
    GiftListModel *model = self.dataArray[indexPath.row];
    cell.introduceLabel.text = model.content_title;
    [cell.backgroundImgview sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
    cell.collectLabel.text = [NSString stringWithFormat:@"%@",model.likes_count];
    
    
    return cell;
}

//上拉
- (void)loadDownData{
    _index += 20;
    __block typeof(self) weakSelf = self;
    
    [[AnalysisTool new] lunBoListdataAnalysisWithIndex:self.index _id:self._id gender:self.gender generation:self.generation passValue:^(NSMutableArray *dataArray) {
        
        [self.dataArray addObjectsFromArray:dataArray];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
        
    }];
}

//下拉
- (void)loadDownData1{
    _index = 0;
    __block typeof(self) weakSelf = self;

    [[AnalysisTool new] lunBoListdataAnalysisWithIndex:self.index _id:self._id gender:self.gender generation:self.generation passValue:^(NSMutableArray *dataArray) {
        weakSelf.dataArray = dataArray;
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        
    }];
    
}


- (NSMutableArray *)dataArray
{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
    
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
