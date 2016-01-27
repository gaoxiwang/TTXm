//
//  ChooseGiftViewController.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/23.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "ChooseGiftViewController.h"

@interface ChooseGiftViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UPStackMenuDelegate>
{
    UIView *contentView;
    UPStackMenu *stack;
}
@property(strong,nonatomic)UISegmentedControl *segment;
@property(strong,nonatomic)UIView *view1;
@property(strong,nonatomic)UIView *view2;
@property(strong,nonatomic)UIView *view3;
@property(strong,nonatomic)UIView *view4;
@property(strong,nonatomic)NSMutableArray *filtersArray;
@property(strong,nonatomic)NSMutableArray *dataArray;
@property(strong,nonatomic)UICollectionView *collect;
@property(strong,nonatomic)UIButton * button1;
@property(strong,nonatomic)UIButton * button2;
@property(strong,nonatomic)UIButton * button3;
@property(strong,nonatomic)UIButton * button4;
@property(strong,nonatomic)NSString *urlString;
@property(strong,nonatomic)NSString *myprice;
@property(strong,nonatomic)NSString *tag1;
@property(strong,nonatomic)NSString *tag2;
@property(strong,nonatomic)NSString *tag3;
@property(strong,nonatomic)NSString *tag4;
@property(strong,nonatomic)NSMutableArray *datascoreArray;
@property(assign,nonatomic)NSInteger fresh;
@end

@implementation ChooseGiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _tag1 = @"";
    _tag2 = @"";
    _tag3 = @"";
    _tag4 = @"";
    _datascoreArray = [NSMutableArray array];
    _datascoreArray = [NSMutableArray arrayWithObjects:@"默认排序 √",@"按热度排序",@"价格由低到高",@"价格由高到低", nil];
    self.navigationItem.title = @"挑选礼物";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"排序" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightAction:)];
    
    _urlString = @"http://api.liwushuo.com/v2/search/item_by_type?target=&limit=20&scene=&price=&personality=&offset=0";
    _filtersArray = [NSMutableArray array];
    _dataArray = [NSMutableArray array];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
    layout.itemSize = CGSizeMake((kWidth-40)/2, kHeight/3+60);
    self.collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 30, kWidth, kHeight-30) collectionViewLayout:layout];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _collect.backgroundColor = [UIColor whiteColor];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [_collect addGestureRecognizer:tap];
    
    
    NSURL *url = [NSURL URLWithString:@"http://api.liwushuo.com/v2/search/item_filter"];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        NSMutableArray *array = [dic[@"data"] objectForKey:@"filters"];
        dispatch_async(dispatch_get_main_queue(), ^{
            for (NSDictionary *dic in array)
            {
                FiltersModel *model = [FiltersModel new];
                [model setValuesForKeysWithDictionary:dic];
                [_filtersArray addObject:model];
                
            }
            // !!!:注意刷新..........................................

            for (int i=0; i<_filtersArray.count; i++)
            {
                FiltersModel *model = [FiltersModel new];
                model = _filtersArray[i];
                UIView *view = [self.view viewWithTag:(300+i)];
                //自定义 添加button
                [self setbutton:model.channels addView:view];
            }
            
        });
        
        
    }];
    [task resume];
    
    
    NSURL *detailUrl = [NSURL URLWithString:@"http://api.liwushuo.com/v2/search/item_by_type?limit=20&offset=0"];
    
    [self json:detailUrl];
    _button1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _button1.frame = CGRectMake(0, 0, kWidth/4, 30);
    [_button1 setTitle:@"对象" forState:(UIControlStateNormal)];
    [_button1 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    _button1.tag = 401;
    [_button1 addTarget:self action:@selector(chooseAction1:) forControlEvents:(UIControlEventTouchUpInside)];
    
    _button2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _button2.frame = CGRectMake(kWidth/4, 0, kWidth/4, 30);
    [_button2 setTitle:@"场合" forState:(UIControlStateNormal)];
    [_button2 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    _button2.tag = 402;
    [_button2 addTarget:self action:@selector(chooseAction1:) forControlEvents:(UIControlEventTouchUpInside)];
    _button3 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _button3.frame = CGRectMake(kWidth/2, 0, kWidth/4, 30);
    [_button3 setTitle:@"个性" forState:(UIControlStateNormal)];
    [_button3 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    _button3.tag = 403;
    [_button3 addTarget:self action:@selector(chooseAction1:) forControlEvents:(UIControlEventTouchUpInside)];
    _button4 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _button4.frame = CGRectMake(kWidth/4*3, 0, kWidth/4, 30);
    [_button4 setTitle:@"价格" forState:(UIControlStateNormal)];
    [_button4 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    _button4.tag = 404;
    [_button4 addTarget:self action:@selector(chooseAction1:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
#pragma mark ---------------------------------do it--------------------
    [self.view addSubview:_button1];
    [self.view addSubview:_button2];
    [self.view addSubview:_button3];
    [self.view addSubview:_button4];
    
    _view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 30, kWidth, kHeight/4)];
    _view1.backgroundColor = [UIColor whiteColor];
    _view1.tag = 300;
    
    [self.view addSubview:_view1];
    _view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 30, kWidth, kHeight/4)];
    _view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_view2];
    _view2.tag = 301;
    _view3 = [[UIView alloc]initWithFrame:CGRectMake(0, 30, kWidth, kHeight/4)];
    _view3.backgroundColor = [UIColor whiteColor];
    _view3.tag = 302;
    [self.view addSubview:_view3];
    _view4 = [[UIView alloc]initWithFrame:CGRectMake(0, 30, kWidth, kHeight/4)];
    _view4.backgroundColor = [UIColor whiteColor];
    _view4.tag = 303;
    [self.view addSubview:_view4];



    [self.view addSubview:_collect];
    
        self.collect.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // Do any additional setup after loading the view.
}
//下拉加载 事件 明杰刷新
-(void)loadMoreData
{
    
    _fresh += 20;
    [self.collect.mj_footer beginRefreshing];

    NSString *temp = [_urlString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"&offset=%ld",_fresh-20] withString:[NSString stringWithFormat:@"&offset=%ld",_fresh]];
    _urlString = [NSString stringWithString:temp];
    NSURL *url = [NSURL URLWithString:_urlString];
    [self json:url];
    
    //[self.collect reloadData];
    
    [self.collect.mj_footer endRefreshing];
    
}
//右侧排序按钮 事件
-(void)rightAction:(UIBarButtonItem *)bar
{
    CGPoint point = CGPointMake(1, 0);

    [PopViewLikeQQView configCustomPopViewWithFrame:CGRectMake(kWidth/5*4, 0, kWidth/2, kHeight/5) imagesArr:@[@"saoyisao.png",@"jiahaoyou.png",@"taolun.png",@"diannao.png"] dataSourceArr:_datascoreArray anchorPoint:point seletedRowForIndex:^(NSInteger index) {
        
        if (index == 0)
        {
            _datascoreArray = [NSMutableArray arrayWithObjects:@"默认排序 √",@"按热度排序",@"价格由低到高",@"价格由高到低", nil];
            [_dataArray removeAllObjects];
            NSURL *url = [NSURL URLWithString:_urlString];
            [self json:url];
        }
        else if (index == 1)
        {
            _datascoreArray = [NSMutableArray arrayWithObjects:@"默认排序",@"按热度排序 √",@"价格由低到高",@"价格由高到低", nil];
            [_dataArray removeAllObjects];
            NSString *temp = [_urlString stringByReplacingOccurrencesOfString:@"&personality" withString:@"&sort=hot&personality"];
            _urlString = [NSString stringWithString:temp];
            NSURL *url = [NSURL URLWithString:_urlString];
            [self json:url];
            NSString *temp2 = [_urlString stringByReplacingOccurrencesOfString:@"&sort=hot&personality" withString:@"&personality"];
            _urlString = [NSString stringWithString:temp2];
            
        }
        else if (index == 2)
        {
            _datascoreArray = [NSMutableArray arrayWithObjects:@"默认排序",@"按热度排序",@"价格由低到高 √",@"价格由高到低", nil];
            [_dataArray removeAllObjects];
            NSString *temp = [_urlString stringByReplacingOccurrencesOfString:@"&personality" withString:@"&sort=price%3Aasc&personality"];
            _urlString = [NSString stringWithString:temp];
            NSLog(@"222222%@",_urlString);
            NSURL *url = [NSURL URLWithString:_urlString];
            [self json:url];
            NSString *temp2 = [_urlString stringByReplacingOccurrencesOfString:@"&sort=price%3Aasc&personality" withString:@"&personality"];
            _urlString = [NSString stringWithString:temp2];
            
        }
        else if (index == 3)
        {
            _datascoreArray = [NSMutableArray arrayWithObjects:@"默认排序",@"按热度排序",@"价格由低到高",@"价格由高到低 √", nil];
            [_dataArray removeAllObjects];
            NSString *temp = [_urlString stringByReplacingOccurrencesOfString:@"&personality" withString:@"&sort=price%3Adesc&personality"];
            _urlString = [NSString stringWithString:temp];
            
            NSURL *url = [NSURL URLWithString:_urlString];
            [self json:url];
            NSString *temp2 = [_urlString stringByReplacingOccurrencesOfString:@"&sort=price%3Adesc&personality" withString:@"&personality"];
            _urlString = [NSString stringWithString:temp2];
           
        }
        
        
        
        
    } animation:YES timeForCome:0.3 timeForGo:0.3];
}
// 主菜单按钮事件 对象 场合 个性 价格
-(void)chooseAction1:(UIButton *)button
{
    if (button.tag == 401)
    {
        
        [self.view bringSubviewToFront:_view1];
    }
    else if (button.tag == 402)
    {
        [self.view bringSubviewToFront:_view2];
    }
    else if (button.tag == 403)
    {
        [self.view bringSubviewToFront:_view3];
    }
    else if (button.tag == 404)
    {
        [self.view bringSubviewToFront:_view4];
    }
}

// 解析
-(void)json:(NSURL *)detailUrl
{
    NSURLSessionDataTask *task1 = [[NSURLSession sharedSession] dataTaskWithURL:detailUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            
            
            NSMutableArray *arr = [dic[@"data"] objectForKey:@"items"];
            for (NSDictionary *dicc in arr)
            {
                ChonseList *model = [ChonseList new];
                [model setValuesForKeysWithDictionary:dicc];
                [_dataArray addObject:model];
                
            }
            
            self.collect.delegate = self;
            self.collect.dataSource = self;
            [self.collect registerClass:[HotListCollectionViewCell class] forCellWithReuseIdentifier:@"list"];
            
            [self.collect reloadData];
        });
        
        
    }];
    [task1 resume];
}
// 添加button
-(void)setbutton:(NSMutableArray *)arr addView:(UIView *)myView
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in arr)
    {
        FilterDetailModel *model = [FilterDetailModel new];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
        
    }
    
    FilterDetailModel *model = [FilterDetailModel new];
    model.name = @"全部";
    model.key = 123456789;
    
    [array addObject:model];
    
    for (int i=0; i<=arr.count; i++)
    {

        FilterDetailModel *model = [FilterDetailModel new];
        model = array[i];
        
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.tag = model.key;//利用model 的id
        [button setBackgroundColor:[UIColor whiteColor]];
        
        
        [button addTarget:self action:@selector(conditionAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        button.layer.borderWidth = 1;
        button.layer.borderColor = [[UIColor grayColor] CGColor];
        NSString *titl = [NSString stringWithFormat:@"%@",model.name];
        if (i==arr.count)
        {
            titl = @"全部";
        }
        [button setTitle:titl forState:(UIControlStateNormal)];
        if (i<3)
        {
            button.frame = CGRectMake(10+(kWidth-40)/3*i+i*10, 10, (kWidth-40)/3, 30);
        }
        else if (i>=3&&i<6)
        {
            button.frame = CGRectMake(10+(kWidth-40)/3*(i-3)+(i-3)*10, 10+40, (kWidth-40)/3, 30);
        }
        else
        {
            button.frame = CGRectMake(10+(kWidth-40)/3*(i-6)+(i-6)*10, 10+80, (kWidth-40)/3, 30);
            
        }
        [myView addSubview:button];
    }
}
// 搜索条件点击 条件事件
-(void)conditionAction:(UIButton *)button
{
    
    UIView *view = button.superview;
    if (view.tag == 300)
    {
        
        _tag1 = [NSString stringWithFormat:@"%ld",button.tag];
        if ([_tag1 isEqualToString:@"123456789"])
        {
            _tag1 = @"";
        }
        [_button1 setTitle:button.currentTitle forState:(UIControlStateNormal)];
    }
   
    if (view.tag == 301)
    {
        _tag2 = [NSString stringWithFormat:@"%ld",button.tag];
        if ([_tag2 isEqualToString:@"123456789"])
        {
            _tag2 = @"";
        }
        [_button2 setTitle:button.currentTitle forState:(UIControlStateNormal)];

    }
    if (view.tag == 302)
    {
        _tag3 = [NSString stringWithFormat:@"%ld",button.tag];
        if ([_tag3 isEqualToString:@"123456789"])
        {
            _tag3 = @"";
        }
        [_button3 setTitle:button.currentTitle forState:(UIControlStateNormal)];
    }
    if (view.tag == 303)
    {
        
        if (button.tag == 0)
        {
            _myprice = nil;
            _myprice = @"0_50";
            
        }
        else if (button.tag == 50)
        {
            _myprice = nil;
            _myprice = @"50_200";
        }
        else if (button.tag == 200)
        {
            _myprice = nil;
            _myprice = @"200_500";
        }
        else if (button.tag == 500)
        {
            _myprice = nil;
            _myprice = @"500_1000";
        }
        else if (button.tag == 1000)
        {
            _myprice = nil;
            _myprice = @"1000_10000";
        }

        _tag4 = [NSString stringWithFormat:@"%@",_myprice];
        if ([_tag4 isEqualToString:@"123456789"])
        {
            _tag4 = @"";
        }
        [_button4 setTitle:button.currentTitle forState:(UIControlStateNormal)];
    }
    
    
    
    _urlString = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/search/item_by_type?target=%@&limit=20&scene=%@&price=%@&personality=%@&offset=0",_tag1,_tag2,_tag4,_tag3];
    if ([_tag1 isEqualToString:@"123456789"])
    {
        NSString *temp = [_urlString stringByReplacingOccurrencesOfString:@"target=" withString:@""];
        _urlString = [NSString stringWithString:temp];
    }
     if ([_tag2 isEqualToString:@"123456789"])
    {
        NSString *temp = [_urlString stringByReplacingOccurrencesOfString:@"&scene=" withString:@""];
        _urlString = [NSString stringWithString:temp];
    }
    if ([_tag3 isEqualToString:@"123456789"])
    {
        NSString *temp = [_urlString stringByReplacingOccurrencesOfString:@"&personality=" withString:@""];
        _urlString = [NSString stringWithString:temp];
        
    }
    if ([_tag4 isEqualToString:@"123456789"])
    {
        NSString *temp = [_urlString stringByReplacingOccurrencesOfString:@"&price=" withString:@""];
        _urlString = [NSString stringWithString:temp];
    }
    [_dataArray removeAllObjects];
    [button setBackgroundColor:[UIColor redColor]];
    //条件按钮的tag 是根据 解析出来的 key生成的
    NSURL *url = [NSURL URLWithString:_urlString];
    [self json:url];
    [self.view bringSubviewToFront:_collect];
    
}


// !!!:collectionView

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HotListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"list" forIndexPath:indexPath];
    
    ChonseList *model = [ChonseList new];
    model = _dataArray[indexPath.row];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
    cell.nameLabel.text = model.name;
    cell.priceLabel.text = model.price;
    [cell.likeButton setTitle:[NSString stringWithFormat:@"❤️%@",model.favorites_count] forState:(UIControlStateNormal)];
    
    
    
    return cell;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view bringSubviewToFront:_collect];
    
}
//通过添加手势 实现点击collectionView把其推到最上层显示
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    [self.view bringSubviewToFront:_collect];
    
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
