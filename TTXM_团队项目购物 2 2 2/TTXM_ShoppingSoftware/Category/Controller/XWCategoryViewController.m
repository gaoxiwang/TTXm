//
//  XWCategoryViewController.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "XWCategoryViewController.h"
#import "CategoryCell.h"
@interface XWCategoryViewController ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)UISegmentedControl *segment;
@property(strong,nonatomic)UIView *backView;
@property(strong,nonatomic)UIScrollView *scroll;
@property(strong,nonatomic)UICollectionView *collectionView;
@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)UIScrollView *headerScroll;

@property(strong,nonatomic)NSMutableArray *specialArray;
@property(strong,nonatomic)UITableView *headTableView;
@property(strong,nonatomic)NSMutableArray *array1;
@property(strong,nonatomic)NSMutableArray *array2;
@property(strong,nonatomic)NSMutableArray *array3;
@property(strong,nonatomic)NSMutableArray *array4;
@property(strong,nonatomic)NSMutableDictionary *dataDic;
@property(strong,nonatomic)UIButton *artifact;
@property(strong,nonatomic)UITableView *listTableView;
@property(strong,nonatomic)UICollectionView *contentView;
@property(strong,nonatomic)NSMutableArray * hotArray;
@property(strong,nonatomic)NSMutableArray * hotDetaiArray;
@property(strong,nonatomic)NSMutableDictionary *hotDic;
@property(assign,nonatomic)BOOL flag;
@property(assign,nonatomic)NSInteger tableTemp;



@end

@implementation XWCategoryViewController


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //注意 写成函数中的scrollView会子列表上啦时 segment的值会发生变化
    if (_scroll.contentOffset.x == 0)
    {
        _segment.selectedSegmentIndex = 0;
        //_flag = NO;
        _contentView.tag = 201;
        [_contentView reloadData];
        
    }
    else
    {
        _segment.selectedSegmentIndex = 1;
        _contentView.tag = 200;
        //_flag = YES;
        [_contentView reloadData];
    }

    
}
-(void)segmentAction:(UISegmentedControl*)segment
{
    if (segment.selectedSegmentIndex == 0)
    {
        _scroll.contentOffset = CGPointMake(0, 0);
        //_flag = NO;
         _contentView.tag = 201;
        [_contentView reloadData];
        //NSLog(@"0");
    }else
    {
        _scroll.contentOffset = CGPointMake(kWidth, 0);
        _contentView.tag = 200;
        //_flag = YES;
        [_contentView reloadData];
        //NSLog(@"1");
    }
    [_contentView reloadData];
}

//搜索按钮
-(void)searchAction:(UIBarButtonItem *)bar
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"分类";
    _flag = NO;
    _array1 = [NSMutableArray array];
    _array2 = [NSMutableArray array];
    _array3 = [NSMutableArray array];
    _array4 = [NSMutableArray array];
    _dataDic = [NSMutableDictionary dictionary];
    _hotArray = [NSMutableArray array];
    _hotDetaiArray = [NSMutableArray array];
    _hotDic = [NSMutableDictionary dictionary];
    
    
    //解析
    [self hotjson];
    _specialArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor orangeColor];
    self.navigationController.navigationBar.translucent = NO;
    //bar颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:243/255.0 green:53/255.0 blue:62/255.0 alpha:1]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UINavigationBar appearance] setTranslucent:NO];
    
    //self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"mySearch"] style:(UIBarButtonItemStylePlain) target:self action:@selector(searchAction:)];
    self.segment = [[UISegmentedControl alloc]initWithItems:@[@"攻略",@"礼物"]];
    self.segment.frame = CGRectMake(kWidth/2-100, 48, 200, 30);
    self.segment.backgroundColor = [UIColor colorWithRed:243/255.0 green:53/255.0 blue:62/255.0 alpha:1];
    self.segment.tintColor = [UIColor whiteColor];
    self.segment.layer.cornerRadius = 5;
    self.segment.layer.masksToBounds = YES;
    [self.segment addTarget:self action:@selector(segmentAction:) forControlEvents:(UIControlEventValueChanged)];
    self.segment.selectedSegmentIndex = 0;
    self.navigationItem.titleView = _segment;
    
    self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-64)];
    //高度必须控制一下 否则会晃动
    _scroll.contentSize = CGSizeMake(2*kWidth, kHeight-120);//64
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self;
    
    _scroll.bounces = NO;
    _scroll.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scroll];
    _artifact = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _artifact.frame = CGRectMake(kWidth, 0, kWidth, 40);
    [_artifact setTitle:@"选礼神器" forState:(UIControlStateNormal)];
    [_artifact setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    _artifact.backgroundColor = [UIColor grayColor];
    [_artifact addTarget:self action:@selector(artifactAction:) forControlEvents:(UIControlEventTouchUpInside)];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //列距
    layout.minimumInteritemSpacing = 20;
    //行距
    layout.minimumLineSpacing = 40;
    //分区 内边距
    layout.sectionInset = UIEdgeInsetsMake(0, 20, 20, 20);
    layout.itemSize = CGSizeMake((kWidth-5*20)/4, (kWidth-5*20)/4+20);
    layout.headerReferenceSize = CGSizeMake(0, 100);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.itemSize = CGSizeMake((kWidth-5*20)/4, (kWidth-5*20)/4+70);
    flow.headerReferenceSize = CGSizeMake(0, 50);
    [_scroll addSubview:_artifact];
    // !!!:热门分类
    _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(kWidth, 40, kWidth/4, kHeight-150)];
    _listTableView.backgroundColor = [UIColor whiteColor];
    [_scroll addSubview:_listTableView];

    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-110) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.tag = 199;
    // !!!:collectionView增补视图
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"otherhead"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"otherhead1"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"otherhead2"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"otherhead3"];
    [self.scroll addSubview:_collectionView];
    [self.collectionView reloadInputViews];
   
    
    
    
    // !!!: contenVIew代理.....................
    _contentView = [[UICollectionView alloc]initWithFrame:CGRectMake(kWidth+kWidth/4, 40, kWidth/4*3, kHeight-150)collectionViewLayout:flow];
    _contentView.delegate = self;
    _contentView.dataSource = self;
    _contentView.tag = 200;
    [_contentView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"con"];
    
    [_contentView registerClass:[CategoryCell class] forCellWithReuseIdentifier:@"cell"];
    [_contentView reloadInputViews];
    [_contentView reloadData];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.scroll addSubview:_contentView];
    
    // !!!:解析数据
    [self alldata];
    // !!!: hot解析数据
    
    [self hotDetaiJson];
    [self.collectionView reloadData];
    
}
-(void)hotDetaiJson
{

    
}
-(void)hotjson
{
    NSURL *url = [NSURL URLWithString:@"http://api.liwushuo.com/v2/item_categories/tree"];
    NSURLSessionDataTask *taks = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            
            NSMutableArray *array = [dic[@"data"] objectForKey:@"categories"];
            
            for (NSDictionary *dicc in array) {
                HotModel *model = [HotModel new];
                [model setValuesForKeysWithDictionary:dicc];
                [_hotArray addObject:model];

            }

            // !!!: list解析
            _listTableView.delegate = self;
            _listTableView.dataSource = self;
            [_listTableView registerClass:[ListTableViewCell class] forCellReuseIdentifier:@"list"];
            [self.listTableView reloadData];
            
            

//            [_contentView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"con1"];
            
            for (int i=0; i<_hotArray.count; i++)
            {
                [_contentView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[NSString stringWithFormat:@"con%d",i]];
                
            }
            
            
            NSInteger ii = 0;
            for (HotModel *mod in _hotArray)
            {
                NSMutableArray *temp = [NSMutableArray array];
                for (NSDictionary *dic in mod.subcategories)
                {

                    HotDetailModel *model = [HotDetailModel new];
                    
                    [model setValuesForKeysWithDictionary:dic];
                    [temp addObject:model];
                   
                    
                }
               
                [_hotDic setValue:temp forKey:[NSString stringWithFormat:@"%ld",ii]];
                ii++;
                
            }
               [_contentView registerClass:[GiftCollectionViewCell class] forCellWithReuseIdentifier:@"gift"];
        });
        
    }];
    
    [taks resume];
}
-(void)alldata
{
    NSURL *url = [NSURL URLWithString:allURL];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
           
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            NSMutableArray *arr = [dic[@"data"] objectForKey:@"channel_groups"];
            
            for (NSDictionary *dic in arr)
            {
                NSMutableArray *dataArray = dic[@"channels"];
                for (NSDictionary *dicc in dataArray)
                {
                    Kind *model = [Kind new];
                    [model setValuesForKeysWithDictionary:dicc];
                    if ([dic[@"name"] isEqualToString:@"品类"])
                    {
                        [_array1 addObject:model];
                    }
                    else if ([dic[@"name"] isEqualToString:@"对象"])
                    {
                        [_array2 addObject:model];
                    }
                    else if ([dic[@"name"] isEqualToString:@"场合"])
                    {
                        [_array3 addObject:model];
                    }
                    else if ([dic[@"name"] isEqualToString:@"风格"])
                    {
                        [_array4 addObject:model];
                    }
                    
                }
                
            }
            
            // !!!:collectionView
            [_collectionView registerClass:[CategoryCell class] forCellWithReuseIdentifier:@"cell"];
            [_collectionView reloadData];
            
        });
        
        
        
    }];
    
    [task resume];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView.tag == 200)
    {
        return 16;
    }
    else
    {
        return 4;
    }
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag == 200)
    {
        NSString *st = [NSString stringWithFormat:@"%ld",section];
        NSArray *arr = _hotDic[st];
        return arr.count;
    }
    else
    {
        if (section == 0)
        {
            return _array1.count;
        }
        else if (section == 1)
        {
            return _array2.count;
        }
        else if (section == 2)
        {
            return _array3.count;
        }
        else
        {
            return _array4.count;
        }

    }
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView.tag == 200)
    {
        
        GiftCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"gift" forIndexPath:indexPath];
        
        HotDetailModel *model = [HotDetailModel new];
        model = _hotDic[[NSString stringWithFormat:@"%ld",indexPath.section]][indexPath.row];
        
        cell.nameLable.text = model.name;
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.icon_url]];
        
        
        
        

        return cell;
    }
    else
    {
        CategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        
        if (indexPath.section == 0)
        {
            _headerScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 2*kWidth, 100)];
            Kind *model = [Kind new];
            model = _array1[indexPath.row];
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.icon_url]];
            cell.titleLabel.text = model.name;
            
        }
        else if (indexPath.section == 1)
        {
            Kind *model = [Kind new];
            model = _array2[indexPath.row];
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.icon_url]];
            cell.titleLabel.text = model.name;
        }
        else if (indexPath.section == 2)
        {
            Kind *model = [Kind new];
            model = _array3[indexPath.row];
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.icon_url]];
            cell.titleLabel.text = model.name;
        }
        else if (indexPath.section == 3)
        {
            Kind *model = [Kind new];
            model = _array4[indexPath.row];
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.icon_url]];
            cell.titleLabel.text = model.name;
        }
        
        return cell;
        

    }
    
    
}


// !!!:增补视图事件
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 199)
    {
        if (indexPath.section == 0)
        {
            UICollectionReusableView *head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
            head.backgroundColor = [UIColor whiteColor];
            _headerScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, kWidth, 80)];
            _headerScroll.contentSize = CGSizeMake(kWidth/3*10+110, 35);
            _headerScroll.backgroundColor = [UIColor whiteColor];
            [head addSubview:_headerScroll];
            
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kWidth/4, 20)];
            
            nameLabel.text = @"专题";
            [head addSubview:nameLabel];
            UIButton *allButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [allButton setTitle:@"查看全部" forState:(UIControlStateNormal)];
            [allButton addTarget:self action:@selector(checkAction:) forControlEvents:(UIControlEventTouchUpInside)];
            
            allButton.frame = CGRectMake(kWidth-kWidth/4-10, 0, kWidth/4, 20);
            [allButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            allButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [head addSubview:allButton];
            
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 110, kWidth/2, 30)];
            title.text = @"品类";
            title.textAlignment = NSTextAlignmentLeft;
            [head addSubview:title];
            
            //解析网络数据
            //[self analysis];
            NSURL *url = [NSURL URLWithString:specialURl];
            NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
                    NSMutableArray *dataArray = [NSMutableArray array];
                    dataArray = [dic[@"data"] objectForKey:@"collections"];
                    for (NSDictionary *dicc in dataArray)
                    {
                        special *model = [special new];
                        [model setValuesForKeysWithDictionary:dicc];
                        [_specialArray addObject:model];
                        
                    }
                    for (int i=0; i<10; i++)
                    {
                        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i*10+10+i*kWidth/3, 0, kWidth/3, kHeight/8)];
                        imgView.tag = 100+i;
                        special *model = [special new];
                        model = _specialArray[i];
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
                        [imgView addGestureRecognizer:tap];
                        imgView.userInteractionEnabled = YES;
                        [imgView sd_setImageWithURL:[NSURL URLWithString:model.banner_image_url]];
                        [_headerScroll addSubview:imgView];
                        
                    }
                    
                });
                
            }];
            [task resume];
            return  head;
        }
        else if (indexPath.section == 1)
        {
            UICollectionReusableView *head1 = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"otherhead" forIndexPath:indexPath];
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, kWidth/2, 30)];
            title.textAlignment = NSTextAlignmentLeft;
            [head1 addSubview:title];
            title.text = @"对象";
            return head1;
        }
        else if (indexPath.section == 2)
        {
            UICollectionReusableView *head1 = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"otherhead1" forIndexPath:indexPath];
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, kWidth/2, 30)];
            title.textAlignment = NSTextAlignmentLeft;
            [head1 addSubview:title];
            
            title.text = @"场合";
            return head1;
        }
        else
        {
            
            UICollectionReusableView *head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"otherhead2" forIndexPath:indexPath];
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, kWidth/2, 30)];
            title.textAlignment = NSTextAlignmentLeft;
            [head addSubview:title];
            
            title.text = @"风格";
            return head;
        }
 
    }
    else
    {
        if (_hotArray.count > 0)
        {

            
            UICollectionReusableView *head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[NSString stringWithFormat:@"con%ld",indexPath.section] forIndexPath:indexPath];
            
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, kWidth/2, 30)];
            title.textAlignment = NSTextAlignmentLeft;
            [head addSubview:title];
            HotModel *model = [HotModel new];
            model = _hotArray[indexPath.section];
            title.text = model.name;
            
            
            return head;

        }else
        {
            
            UICollectionReusableView *head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"con" forIndexPath:indexPath];
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, kWidth/2, 30)];
            title.textAlignment = NSTextAlignmentLeft;
            [head addSubview:title];
            
            title.text = @"正在刷新";
            return head;
        }
        
        
                //}
        
    }
    
    
}


//查看全部事件
-(void)checkAction:(UIButton *)button
{
    CheakAllTableViewController *check = [CheakAllTableViewController new];
    [self.navigationController pushViewController:check animated:YES];
    
}
-(void)tapAction:(UIGestureRecognizer *)sender
{
   
    

    special *model = _specialArray[sender.view.tag-100];
    NSString *string = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/collections/%@/posts?limit=20&offset=0",model.s_id];
   
    HeadDetailTableViewController *detail = [HeadDetailTableViewController new];
    detail.myUrl = string;
    detail.my_id = model.s_id;
    
    [self.navigationController pushViewController:detail animated:YES];
    
    
    
    
}
-(void)analysis
{
    NSURL *url = [NSURL URLWithString:specialURl];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            NSMutableArray *dataArray = [NSMutableArray array];
            dataArray = [dic[@"data"] objectForKey:@"collections"];
            for (NSDictionary *dicc in dataArray)
            {
                special *model = [special new];
                [model setValuesForKeysWithDictionary:dicc];
                [_specialArray addObject:model];
                
                
            }
            
            
        });

        
        
        
    }];
    [task resume];
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
//    if (collectionView.tag == 199) {
        if (section == 0)
        {
            return CGSizeMake(0, 140);
        }
        else
        {
            return CGSizeMake(0, 100);
        }
   // }
//    else
//    {
//        return CGSizeMake(0, 100);
//    }

}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 199)
    {
        Kind *model = [Kind new];
        if (indexPath.section == 0) {
            model = _array1[indexPath.row];
        }
        else if (indexPath.section == 1)
        {
            model = _array2[indexPath.row];
        }
        else if (indexPath.section == 2)
        {
            model = _array3[indexPath.row];
        }
        else if (indexPath.section == 3)
        {
            model = _array4[indexPath.row];
        }
        
        NSString *urlString = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/channels/%@/items?limit=20&gender=1&offset=0&generation=2&order_by=now",model.s_id];
        KindTableViewController *detail = [KindTableViewController new];
        detail.urlString = urlString;
        [self.navigationController pushViewController:detail animated:YES];
    }
    else if (collectionView.tag == 200)
    {
        HotListCollectionViewController *hotlist = [HotListCollectionViewController new];

        HotList *model = [HotList new];
        
        model = _hotDic[[NSString stringWithFormat:@"%ld",indexPath.section]][indexPath.row];
        hotlist.urlString = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/item_subcategories/%@/items?limit=20&offset=0",model.s_id];
        
        [self.navigationController pushViewController:hotlist animated:YES];
        
    }
    
}



//在上一次显示结束下一次即将开始时 改变条件 结束同步
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 200)
    {
        _tableTemp = 0;
        
    }
}

-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 200)
    {
        NSArray *arr = [NSArray array];
        
        arr = [_contentView indexPathsForVisibleItems];
       // NSArray *arr2 =  [_listTableView indexPathsForVisibleRows];
        
        if (arr.count >0 )
        {
            //NSLog(@"%lu",arr.count);
            if (_tableTemp >0)
            {
                NSIndexPath *indexp = [NSIndexPath indexPathForRow:_tableTemp inSection:0];
                [_listTableView selectRowAtIndexPath:indexp animated:NO scrollPosition:(UITableViewScrollPositionNone)];

                
                return;
            }
            else
            {
                NSIndexPath *ind = arr[0];
                NSIndexPath *index = [NSIndexPath indexPathForRow:ind.section inSection:0];
                [_listTableView selectRowAtIndexPath:index animated:YES scrollPosition:(UITableViewScrollPositionNone)];
                
            }
            
            
        }
        
    }
    

}


//选礼神器 跳转函数
-(void)artifactAction:(UIButton *)button
{
    ChooseGiftViewController *choose = [ChooseGiftViewController new];
    [self.navigationController pushViewController:choose animated:YES];
    
}
// !!!: tableView方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _hotArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"list" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[ListTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"list"];
    }
    
    HotModel *model = [HotModel new];
    model = _hotArray[indexPath.row];
    //cell.textLabel.text = model.name;
    cell.nameLable.text = model.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _tableTemp = indexPath.row;
    
//    [_listTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:(UITableViewScrollPositionTop)];
    NSIndexPath *indx = [NSIndexPath indexPathForItem:1 inSection:indexPath.row];
    
    [self.contentView scrollToItemAtIndexPath:indx atScrollPosition:(UICollectionViewScrollPositionCenteredVertically) animated:NO];
    
    
    //    [self.listTableView scrollToRowAtIndexPath:indexPath atScrollPosition:(UITableViewScrollPositionBottom) animated:YES];
    
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
