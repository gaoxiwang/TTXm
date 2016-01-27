//
//  SearchViewController.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/21.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong,nonatomic)UITextField *textfield;
@property (strong,nonatomic)UIButton *button;
@property (strong,nonatomic)UIView *titleView;
@property (strong,nonatomic)UISegmentedControl *segmentedControl;
@property (strong,nonatomic)UIScrollView *scrollView;
@property (assign,nonatomic)NSInteger count1;
@property (assign,nonatomic)NSInteger count2;
@property (assign,nonatomic)BOOL isRefreshing1;
@property (assign,nonatomic)BOOL isRefreshing2;
@property (strong,nonatomic)UITableView *rightTableView;
@property (strong,nonatomic)NSMutableArray *leftDataArray;
@property (strong,nonatomic)NSMutableArray *rightDataArray;
@property (strong,nonatomic)UIView *alertView;
@property (strong,nonatomic)SearchCollection *searchCollection;
@property (strong,nonatomic)NSMutableArray *searchDataArray;
@property (strong,nonatomic)UICollectionView *collectionView;
@property (strong,nonatomic)NSMutableArray *hotSearchDataArray;

@end

static NSString * const systemCell = @"systemCell";

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kGap kWidth/20

@implementation SearchViewController

- (NSMutableArray *)leftDataArray
{
    if (!_leftDataArray) {
        _leftDataArray = [NSMutableArray array];
    }
    return _leftDataArray;

}

- (NSMutableArray *)rightDataArray
{

    if (!_rightDataArray) {
        _rightDataArray = [NSMutableArray array];
    }
    return _rightDataArray;
}

- (NSMutableArray *)hotSearchDataArray
{
    if (!_hotSearchDataArray) {
        _hotSearchDataArray = [NSMutableArray array];
    }
    return _hotSearchDataArray;

}

#pragma mark - 未能找到相关礼物的提示视图，view里面是一个Label和一个ImageView
- (UIView *)alertView
{
    if (!_alertView) {
        _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight/2 - 3*kGap, kWidth, kHeight/2)];
        
        UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(4*kGap, kHeight/2 *2/5 + kGap, 12*kGap, kGap)];
        alertLabel.text = @"未搜索到相关礼物";
        alertLabel.textAlignment = NSTextAlignmentCenter;
        alertLabel.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(8*kGap, kHeight/2 *1/5, 4*kGap, 4*kGap)];
        imgView.image = [UIImage imageNamed:@"789"];
        self.view.backgroundColor = [UIColor whiteColor];
        [_alertView addSubview:alertLabel];
        [_alertView addSubview:imgView];
    }
    return _alertView;

}

#pragma mark - 隐藏tabBar
- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;

}

- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-fanhui"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.count1 = 0;
    self.count2 = 0;
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
     self.navigationController.navigationBar.translucent = NO;
    
    [self setTitleView];
    
    
}


- (void)backAction
{

    [self.navigationController popViewControllerAnimated:YES];

}
#pragma mark - 搜索的视图，包含一个输入框和搜索按钮
- (void)setTitleView
{

    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(kGap *4, 0, kWidth - kGap *4, 44)];
    self.textfield = [[UITextField alloc] initWithFrame:CGRectMake(0, kGap *1/4, self.titleView.bounds.size.width - 3*kGap, 34)];
    self.textfield.borderStyle = UITextBorderStyleRoundedRect;
    self.textfield.backgroundColor = [UIColor whiteColor];
    self.textfield.delegate = self;
    self.textfield.clearsOnBeginEditing = YES;
    self.textfield.placeholder = @"搜索礼物、攻略";
    self.textfield.clearButtonMode = UITextFieldViewModeAlways;
    UIImageView *searchImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kGap *3/2, kGap *3/2)];
    self.textfield.leftView = searchImgView;
    self.textfield.leftViewMode = UITextFieldViewModeAlways;
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.button setTitle:@"搜索" forState:UIControlStateNormal];
    self.button.frame = CGRectMake(self.titleView.bounds.size.width - kGap *4, kGap *1/4, 4*kGap, 34);
    [self.button addTarget:self action:@selector(makeViewAppear) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:self.button];
    [self.titleView addSubview:self.textfield];
    self.navigationItem.titleView = self.titleView;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(2*kGap, 0.8f*kGap, 7*kGap, 1.6f*kGap)];
    label.text = @"大家都在搜";
    label.font = [UIFont systemFontOfSize:15];
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
    
     UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
     flowLayout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame) + 1/2*kGap, kWidth, 8*kGap) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.tag = 201;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[SomeCollectionViewCell class] forCellWithReuseIdentifier:@"嘿嘿"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self dataAnalyisisWithSomeSearch];
    [self.view addSubview:self.collectionView];
   

    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(18*kGap, CGRectGetMaxY(self.collectionView.frame) + kGap, 2*kGap, 1.5f*kGap)];
    imgView1.image = [UIImage imageNamed:@"iconfont-jinru"];
    imgView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imgView1];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, CGRectGetMaxY(self.collectionView.frame) + kGap, 18*kGap, 1.5f*kGap);
    [button setTitle:@"使用选礼神奇快速挑选礼品" forState:UIControlStateNormal];
    [button setFont:[UIFont systemFontOfSize:16]];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(xuanli) forControlEvents:UIControlEventTouchUpInside];
    

}

- (void)xuanli
{

    ChooseGiftViewController *chooseVC = [[ChooseGiftViewController alloc] init];
    [self.navigationController pushViewController:chooseVC animated:YES];



}


-(void)dataAnalyisisWithSomeSearch
{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    __block typeof(self) weakSelf = self;
    
    NSString *url = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/search/hot_words"];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        weakSelf.hotSearchDataArray = [NSMutableArray array];
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.hotSearchDataArray = responseObject[@"data"][@"hot_words"];
            NSLog(@"_______)()()%@",weakSelf.hotSearchDataArray[0]);
            [self.collectionView reloadData];
        });
      
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
   

}


#pragma mark - 点击搜索是对搜索框进行编辑
- (void)endEditing
{

    [UIView animateWithDuration:0.5 animations:^{
        self.textfield.frame = CGRectMake(0, kGap *1/4, self.titleView.bounds.size.width, 34);
        self.button.hidden = YES;
    }];
    [self.titleView endEditing:YES];

}

#pragma mark - 编辑搜索框时还原操作
- (void)textFieldDidBeginEditing:(UITextField *)textField
{

    [self.alertView removeFromSuperview];
    [UIView animateWithDuration:0.5 animations:^{
        self.textfield.frame = CGRectMake(0, kGap *1/4, self.titleView.bounds.size.width - 3*kGap, 34);
        self.button.hidden = NO;
        
    }];

}

#pragma mark - 设置UISegmentedControl
- (void)setSegmentedControl
{
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"礼物",@"攻略"]];
    self.segmentedControl.frame = CGRectMake(0, 0, kWidth, 35);
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.backgroundColor = [UIColor colorWithRed:1.000 green:0.740 blue:0.762 alpha:1.000];
    self.segmentedControl.tintColor = [UIColor colorWithRed:0.92f green:0.35f blue:0.33f alpha:1.00f];
    [self.segmentedControl addTarget:self action:@selector(changeContentOffset:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentedControl];
}

#pragma mark - 最后一个cell出现的时候刷新表格
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        if (self.isRefreshing1 == NO) {
            return;
        }
        CGFloat offsetY = scrollView.contentOffset
        .y;
        CGFloat judgeOffsetY = scrollView.contentSize.height - scrollView.frame.size.height - 64;
        if (offsetY > judgeOffsetY) { // 最后一个cell完全进入视野范围内
            // 加载更多的数据
            [self loadRightData];
            NSLog(@"看看有没有执行到这里,为了明显点，把文字弄得很长!!!!!!!!!!!!!!!!");
            self.isRefreshing1 = NO;
        }
        
    }else if ([scrollView isKindOfClass:[UITableView class]]) {
        if (self.isRefreshing2 == NO) {
            return;
        }
        CGFloat offsetY = scrollView.contentOffset.y;
        // 当最后一个cell完全显示在眼前时，contentOffset的y值
        CGFloat judgeOffsetY = scrollView.contentSize.height - scrollView.frame.size.height - 64;
        if (offsetY > judgeOffsetY) { // 最后一个cell完全进入视野范围内
            // 加载更多数据
            [self loadAllData];
            NSLog(@"看这里!!!!!!!!!");
            self.isRefreshing2 = NO;
        }
    }


}

#pragma mark - 设置数据显示的视图
- (void)setScrollViewAndTableView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 35, kWidth, kHeight)];
    self.scrollView.contentSize = CGSizeMake(kWidth *2, kHeight - 64- 35);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.tag = 123;
    self.scrollView.directionalLockEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.scrollView];
    
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(kWidth, 0, kWidth, kHeight - 35 - 64) style:UITableViewStylePlain];
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    self.rightTableView.bounces = NO;
    self.rightTableView.tag = 234;
    self.rightTableView.separatorColor = [UIColor clearColor];
    [self.scrollView addSubview:self.rightTableView];

}

#pragma mark---搜索点击事件
- (void)makeViewAppear
{
    if (self.textfield.text.length == 0) {
        self.textfield.placeholder = @"关键字不能为空";
        return;
    }
    [self endEditing];
    [self.leftDataArray removeAllObjects];
    [self.rightDataArray removeAllObjects];
    [self.scrollView removeFromSuperview];
    [self.segmentedControl removeFromSuperview];
    [self.searchCollection removeFromSuperview];
    [self.rightTableView removeFromSuperview];
    [self setScrollViewAndTableView];
    [self setSegmentedControl];
    [self.textfield restorationIdentifier];
    
    self.count1 = 0;
    self.count2 = 0;
    self.searchCollection = [[SearchCollection alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight - 35)];
    self.searchCollection.collectionView.frame = CGRectMake(0, 0, kWidth, kHeight - 35 - 64);
    self.searchCollection.collectionView.tag = 300;
    SearchCollection *colllection = self.searchCollection;
    colllection.layout.headerReferenceSize = CGSizeMake(0, 0);
    [self loadAllData];
    [self loadRightData];
    [self.scrollView addSubview:self.searchCollection];
    

}
#pragma mark - 加载右侧UITableView的攻略数据
- (void)loadAllData
{
    [self.rightTableView registerNib:[UINib nibWithNibName:@"OtherTableViewCell" bundle:nil] forCellReuseIdentifier:@"heihei"];
    NSString *keyword = [self.textfield.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/search/post?keyword=%@&sort=&offset=%ld&limit=20", keyword, self.count2];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (NSDictionary *dict in responseObject[@"data"][@"posts"]) {
            GiftListModel *model = [[GiftListModel alloc] init];
            model.allTitle = responseObject[@"data"][@"title"];
            model.content_title = dict[@"title"];
            model.cover_image_url = dict[@"cover_image_url"];
            model.likes_count = dict[@"likes_count"];
            [self.rightDataArray addObject:model];
        }
        self.isRefreshing2 = YES;
        self.count2 += 20;
        [self.rightTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}
#pragma mark - 加载左侧礼物集合视图的数据
- (void)loadRightData
{
    self.searchCollection.collectionView.delegate = self;
    self.searchCollection.collectionView.dataSource = self;
    [self.searchCollection.collectionView registerNib:[UINib nibWithNibName:@"SearchCollectionCell" bundle:nil] forCellWithReuseIdentifier:systemCell];
    NSString *keyword = [self.textfield.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/search/item?keyword=%@&offset=%ld&limit=20", keyword, self.count1];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (NSDictionary *items in responseObject[@"data"][@"items"]) {
            SearchCollectionModel *model = [SearchCollectionModel new];
            model.cover_image_url = items[@"cover_image_url"];
            model.name = items[@"name"];
            model.price = items[@"price"];
            model.like_count = items[@"likes_count"];
            model._id = items[@"id"];
            
            [self.leftDataArray addObject:model];
        }
        self.isRefreshing1 = YES;
        self.count1 += 20;
        if (self.leftDataArray.count == 0) {
            [self.view addSubview:self.alertView];
        }
        [self.searchCollection.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        return ;
    }];
    
}

#pragma mark -- collectionView 代理方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView.tag == 300) {
        return 1;
    }
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag == 300) {
        return self.leftDataArray.count;
    }
    return self.hotSearchDataArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView.tag == 300) {
        SearchCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:systemCell forIndexPath:indexPath];
        
        SearchCollectionModel *model = self.leftDataArray[indexPath.row];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
        cell.titleLabel.text = model.name;
        cell.priceLabel.text = model.price;
        cell.like_countLabel.text = [NSString stringWithFormat:@"%lu",[model.like_count integerValue]];
        
        return cell;
    }
    SomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"嘿嘿" forIndexPath:indexPath];
    cell.searchNameLabel.text = self.hotSearchDataArray[indexPath.item];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 300) {
        
        SearchCollectionModel *model = self.leftDataArray[indexPath.item];
        __block typeof(self) weakSelf = self;
        [[AnalysisTool new] searchDataAnalysisWithID:model._id passValue:^(NSMutableArray *dataArray) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                weakSelf.searchDataArray = dataArray;
                
                HotDeaModel *model = [_searchDataArray firstObject];
                MLIndexPathTableViewController *view =[[MLIndexPathTableViewController alloc]init];
                view.model = model;
                //push到下一页
                [weakSelf.navigationController pushViewController:view animated:YES];
                [weakSelf.searchCollection.collectionView reloadData];
                
            });
        }];
        
    }
    self.textfield.text = self.hotSearchDataArray[indexPath.item];
    
    
    
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 300) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width /2 - 15, ([UIScreen mainScreen].bounds.size.width /2 - 15) * 1.5);
    }
    return CGSizeMake([self.hotSearchDataArray[indexPath.item] length]*17 + 1.2f*kGap, 1.5f*kGap);
    
}

#pragma mark -- tableView 代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    if (tableView.tag == 234) {
        
        return 1;
    }
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rightDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OtherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"heihei" forIndexPath:indexPath];
    GiftListModel *model = self.rightDataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.introduceLabel.text = model.content_title;
    [cell.backgroundImgview sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
    cell.collectLabel.text = [NSString stringWithFormat:@"%@",model.likes_count];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (void)changeContentOffset:(UISegmentedControl *)sender
{
    self.scrollView.contentOffset = CGPointMake(kWidth * sender.selectedSegmentIndex, 0);
}

#pragma mark - 控制UISegmentedControll的选中按钮
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == 123) {
        self.segmentedControl.selectedSegmentIndex = scrollView.contentOffset.x / kWidth;
    }
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
