//
//  JingxuanTableViewController.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/16.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "JingxuanTableViewController.h"

@interface JingxuanTableViewController ()<LOCarouseFigurelViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UIView *aView;
@property (strong,nonatomic) NSMutableArray *dataArray;
@property (strong,nonatomic) UIView *mainView;
@property (strong,nonatomic) WebViewController *webViewVC;
@property (strong,nonatomic) UICollectionView *collectionView;
@property (strong,nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (strong,nonatomic) NSMutableArray *collectionDataArray;
@property (assign,nonatomic) NSInteger index;

@property (strong,nonatomic) NSMutableArray *dataArray1;

@end

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kGap kWidth/20

//cell重用标识符
static NSString * const cellReuseID = @"cellReuseID";
static NSString * const customcellReuseID = @"customcellReuseID";

//增补视图重用标识符
static NSString * const headerRuseID = @"headerRuseID";
static NSString * const footerRuseID = @"footerRuseID";
static NSString * const systemCell = @"systemCell";

@implementation JingxuanTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight* 4/9)];
    self.mainView.backgroundColor = [UIColor whiteColor];
    self.gender = [[[NSUserDefaults standardUserDefaults] stringForKey:@"gender"] integerValue];
    self.generation = [[[NSUserDefaults standardUserDefaults] stringForKey:@"generation"] integerValue];
    
    __block typeof(self) weakSelf = self;
    
    [[AnalysisTool new] lunBoDataAnalysisWithPassValue:^(NSMutableArray *dataArray) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            weakSelf.dataArray = dataArray;
        
            [self loadData];
        });
        
    }];
    
    [[AnalysisTool new] collectionDataAnalysisWithGender:self.gender generation:self.generation passValue:^(NSMutableArray *dataArray) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            weakSelf.collectionDataArray = dataArray;
            [self.collectionView reloadData];
            
        });
        
    }];
    
    self.tableView.tableHeaderView = self.mainView;

    [self collectionViewLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OtherTableViewCell" bundle:nil] forCellReuseIdentifier:systemCell];
    
    
    [[AnalysisTool new] dataAnalysisWithIndex:self.index _id:self._id gender:self.gender generation:self.generation passValue:^(NSMutableArray *dataArray) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.dataArray1 = dataArray;
            
//            [weakSelf.tableView.mj_footer beginRefreshing];
//            [weakSelf.tableView.mj_header beginRefreshing];
            [weakSelf.tableView reloadData];
        });
        
    }];
    
    
#pragma mark == 上拉加载和下拉刷新
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadDownData)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDownData1)];
}

-(void)loadData
{

    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < self.dataArray.count; i++) {
        WheelModel *model = self.dataArray[i];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.image_url]]]];
        [array addObject:image];
        
    }
    LOCarouselFigureView *carouseView = [[LOCarouselFigureView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight *2/8)];
    [self.mainView addSubview:carouseView];
    carouseView.duration = 3;
    carouseView.images = array;
    carouseView.delegate = self;
    carouseView.dataArray = self.dataArray;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (void)carouselFigureViewDidCarousel:(LOCarouselFigureView *)carouselFigureView withIndex:(NSNumber *)index
{
    NSLog(@"%@",index);
   // 重点: <null> 类型不是空,需要经过转换
    if (![index isEqual:[NSNull null]]) {
        if ([NSString stringWithFormat:@"%lu",[index integerValue]].length > 3) {
            self.webViewVC = [[WebViewController alloc] init];
            self.webViewVC.webViewStr = [NSString stringWithFormat:@"http://www.liwushuo.com/posts/%@",index];
            [self.navigationController pushViewController:self.webViewVC animated:YES];
        }else
        {
            LunboTableViewController *lunboVC = [[LunboTableViewController alloc] init];
            lunboVC._id = index;
            [self.navigationController pushViewController:lunboVC animated:YES];
            
        }
        
    }else
    {
        


        
    }
}

#pragma mark ------collectionView-------
-(void)collectionViewLoad
{

    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.itemSize = CGSizeMake(kGap *6, kGap *6);
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(1/2*kGap, 1/2*kGap, 1/2*kGap, 1/2*kGap);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kGap *9 - 2/4*kGap, kWidth, kGap *7 - 3/4*kGap) collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //设置区头区尾(增补视图)
    //设置视图的大小
    self.flowLayout.headerReferenceSize = CGSizeMake(kGap*1/5, kGap*1/5);
    self.flowLayout.footerReferenceSize = CGSizeMake(kGap*1/5, kGap*1/5);
    //注册增补视图
    [self.collectionView registerClass:[CollectionViewCell class]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerRuseID];
    [self.collectionView registerClass:[CollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerRuseID];
    //注册
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:cellReuseID];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:customcellReuseID];
    
    [self.mainView addSubview:self.collectionView];


}

//设置分区个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}

//每个分区有多少个Item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionDataArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseID forIndexPath:indexPath];
    collectionModel *model = self.collectionDataArray[indexPath.row];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
   
    return cell;
    
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerRuseID forIndexPath:indexPath];
    header.backgroundColor = [UIColor orangeColor];
    UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerRuseID forIndexPath:indexPath];
    footer.backgroundColor = [UIColor purpleColor];
    
    //根据kind来选择需要返回的视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        return header;
    }
    return footer;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    collectionModel *model = self.collectionDataArray[indexPath.item];
    NSLog(@"____+++++%@",model._id);
    if (model._id != NULL && [model._id length] < 5) {
        LunboTableViewController *lunboVC = [[LunboTableViewController alloc] init];
       
        lunboVC._id = @([model._id integerValue]);
        
        [self.navigationController pushViewController:lunboVC animated:YES];
    }else if (model._id != NULL && [model._id length]> 4)
    {
    
        WebViewController *webView = [[WebViewController alloc] init];
        webView.webViewStr = [NSString stringWithFormat:@"http://www.liwushuo.com/posts/%@",model._id];
        [self.navigationController pushViewController:webView animated:YES];
    
    }else
    {
    
    
        WebViewController *webView = [[WebViewController alloc] init];
        webView.webViewStr = @"https://event.liwushou.com";
        [self.navigationController pushViewController:webView animated:YES];
        
        
    }
    

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray1.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 150;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OtherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:systemCell forIndexPath:indexPath];
    GiftListModel *model = self.dataArray1[indexPath.row];
    cell.introduceLabel.text = model.content_title;
    [cell.backgroundImgview sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
    cell.collectLabel.text = [NSString stringWithFormat:@"%@",model.likes_count];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GiftListModel *model = self.dataArray1[indexPath.row];
    DetailWebViewController *detailWebViewVC = [[DetailWebViewController alloc] init];
    detailWebViewVC.model = model;
    [self.navigationController showDetailViewController:detailWebViewVC sender:nil];
    
    
    
}

//上拉
- (void)loadDownData{
    _index += 20;
    __block typeof(self) weakSelf = self;
    [[AnalysisTool new] dataAnalysisWithIndex:self.index _id:self._id gender:self.gender generation:self.generation passValue:^(NSMutableArray *dataArray) {
        [self.dataArray1 addObjectsFromArray:dataArray];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
        
    }];
    
}

//下拉
- (void)loadDownData1{
    _index = 0;
    __block typeof(self) weakSelf = self;
    [[AnalysisTool new] dataAnalysisWithIndex:self.index _id:self._id gender:self.gender generation:self.generation passValue:^(NSMutableArray *dataArray) {
        weakSelf.dataArray1 = dataArray;
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

- (NSMutableArray *)dataArray1
{
    
    if (!_dataArray1) {
        _dataArray1 = [NSMutableArray array];
    }
    return _dataArray1;
    
}

- (NSMutableArray *)collectionDataArray
{
    if (!_collectionDataArray) {
        _collectionDataArray = [NSMutableArray array];
    }
    return _collectionDataArray;
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
