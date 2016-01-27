//
//  MLHotDealViewController.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "MLHotDealViewController.h"


@interface MLHotDealViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) UICollectionView *collectionView;
//页数参数
@property(assign,nonatomic)NSInteger offset;
//性别参数
@property (assign,nonatomic)NSInteger gender;
//职业参数
@property (assign,nonatomic)NSInteger generation;
@end

@implementation MLHotDealViewController

#define URL(gender,generation,offset) [NSString stringWithFormat:@"http://api.liwushuo.com/v2/items?gender=%lu&generation=%lu&limit=20&offset=%lu",gender,generation,offset]

- (void)viewDidLoad {
    [super viewDidLoad];
    self.offset = 0;
    self.dataArray =[NSMutableArray array];
     self.navigationItem.title = @"热门";
    self.view.backgroundColor=[UIColor whiteColor];
    
    //CollectionView
    //用来布局
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    //水平方向滑动
    // UICollectionViewScrollDirectionHorizontal  //横向滑动
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //内部图片大小
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowlayout];
    // 每个单元格的大小
     flowlayout.itemSize = CGSizeMake((kScreenWidth-30)/2,kScreenHeight/5*2+30);
    
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //给其颜色
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //添加到view
    [self.view addSubview:self.collectionView];
    
    
    
    //注册
    [self.collectionView registerClass:[HotDealCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
     [self parsing:URL(self.gender, self.generation,self.offset)];
    
    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadDownData)];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDownData1)];
    
    
    
}
#pragma mark -----------上拉加载---------

-(void)loadDownData1
{
    [self.collectionView.mj_header beginRefreshing];
    if (_dataArray == nil)
    {
        [self parsing:URL(self.gender, self.generation,self.offset)];

        
    }
    [self.collectionView reloadData];
    [self.collectionView.mj_header endRefreshing];
    
}
#pragma mark ------------下拉加载 ----------

-(void)loadDownData
{
    
    _offset += 20;
    [self.collectionView.mj_footer beginRefreshing];
    [self parsing:URL(self.gender, self.generation,self.offset)];
    [self.collectionView reloadData];
    [self.collectionView.mj_footer endRefreshing];
    
    
}

//解析
-(void)parsing:(NSString *)urlString{
    //路径
    NSURL *url =[NSURL URLWithString:urlString];
    //创建session
    NSURLSession *session =[NSURLSession sharedSession];
    //Task
    NSURLSessionDataTask *dataTask =[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //解析
        NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        
        NSDictionary *dic =[NSDictionary dictionary];
        
        dic = dict[@"data"];
        
        NSMutableArray *array =[NSMutableArray array];
        
        array = dic[@"items"];
        
        
        
        for (NSDictionary *di in array) {
            
            HotDeaModel *model =[[HotDeaModel alloc]init];
            
            NSDictionary *dicc = di[@"data"];
            
            [model setValuesForKeysWithDictionary:dicc];
            
            [self.dataArray addObject:model];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
           
            
            [self.collectionView reloadData];
            
        });
        
        
        
        
    }];
//启动
    [dataTask resume];


}
//collection的分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
//每一个分区有多少个Item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

//collection的上下左右
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
//collection的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HotDealCollectionViewCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
 
   
    HotDeaModel *model =self.dataArray[indexPath.row];
    cell.backgroundColor=[UIColor whiteColor];
    cell.model =model;
//    cell.favorites_counLabel.text =model.favorites_count;

   
    
    return cell;
}
//collection的单元格的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    MLIndexPathTableViewController *view =[[MLIndexPathTableViewController alloc]init];
    HotDeaModel *m = [HotDeaModel new];
    m = _dataArray[indexPath.row];
    view.model = m;
    //push到下一页
    [self.navigationController pushViewController:view animated:YES];
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
