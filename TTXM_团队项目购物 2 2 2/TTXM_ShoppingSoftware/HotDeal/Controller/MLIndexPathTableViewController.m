//
//  MLIndexPathTableViewController.m
//  TTXM_ShoppingSoftware
//
//  Created by 小明 on 16/1/19.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "MLIndexPathTableViewController.h"

@interface MLIndexPathTableViewController ()<MLHotDealSectionDelegate,UMSocialUIDelegate,UIWebViewDelegate>

//浮窗View
@property (nonatomic,strong) UIView *navigationView;
//浮窗收藏button
@property (nonatomic,strong) UIButton *collectionButton;
//浮窗淘宝链接button
@property (nonatomic,strong) UIButton *taobaoButton;

//轮播view
@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) NSMutableArray *dataArray;
//淘宝链接
@property (nonatomic,strong) UIWebView * webView;


/** 选择tableView的view */
@property (nonatomic, strong) MLHotDealSectionView  *selectView;

@property (nonatomic, strong) NSMutableArray *dataArray1;



@end

@implementation MLIndexPathTableViewController
//当点击进入该页的时候隐藏底部导航栏
-(instancetype)initWithStyle:(UITableViewStyle)style{

    if (self = [super initWithStyle:style]) {
        self.hidesBottomBarWhenPushed=YES;

    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc ]initWithImage:[UIImage imageNamed:@"分享"] style:(UIBarButtonItemStylePlain) target:self action:@selector(rightAction:)];
    
    
    [self.tableView registerClass:[MLIndexPathTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    //浮窗
    [self Floating];
    //轮播tabelView头部
    [self makeHeader];
}
//浮窗
-(void)Floating {

    
    self.view.backgroundColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.9] ;
    //浮窗headView
    self.navigationView =[[UIView alloc]initWithFrame:CGRectMake(0,kScreenHeight - 44, kScreenWidth, 44)];
    self.navigationView.backgroundColor = [UIColor whiteColor];
    
    [[UIApplication sharedApplication].delegate.window addSubview:self.navigationView];
    //收藏button
    self.collectionButton =[UIButton buttonWithType:(UIButtonTypeSystem)];
    //大小
    self.collectionButton.frame=CGRectMake(20, kScreenHeight-34, kScreenWidth/3-20, 24);
    //添加字体
    [self.collectionButton setTitle:@"❤️ 喜欢" forState:UIControlStateNormal];
    //button颜色
    self.collectionButton.backgroundColor = [UIColor whiteColor];
    //边框大小
    self.collectionButton.layer.borderWidth = 1;
    //边框颜色
    self.collectionButton.layer.borderColor = [UIColor redColor].CGColor;
    //切圆角
    self.collectionButton.layer.cornerRadius = 12;
    self.collectionButton.layer.masksToBounds = YES;
    //字体颜色
    [self.collectionButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //事件
    [self.collectionButton addTarget:self action:@selector(collectionAction:) forControlEvents:UIControlEventTouchUpInside];
    //添加到App
    [[UIApplication sharedApplication].delegate.window addSubview:self.collectionButton];
    
    //淘宝链接button
    self.taobaoButton =[UIButton buttonWithType:(UIButtonTypeSystem)];
    self.taobaoButton.frame=CGRectMake(CGRectGetMaxX(self.collectionButton.frame)+20, kScreenHeight-34, kScreenWidth/3*2-40, 24);
    [self.taobaoButton setTitle:@"去淘宝购买" forState:UIControlStateNormal];
    self.taobaoButton.backgroundColor = [UIColor redColor];
    self.taobaoButton.layer.borderWidth = 1;
    self.taobaoButton.layer.borderColor = [UIColor redColor].CGColor;
    self.taobaoButton.layer.cornerRadius = 12;
    self.taobaoButton.layer.masksToBounds = YES;
    [self.taobaoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.taobaoButton addTarget:self action:@selector(taobaoAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [[UIApplication sharedApplication].delegate.window addSubview:self.taobaoButton];
}
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication].delegate.window bringSubviewToFront:self.navigationView];
    [[UIApplication sharedApplication].delegate.window bringSubviewToFront:self.collectionButton];
    [[UIApplication sharedApplication].delegate.window bringSubviewToFront:self.taobaoButton];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication].delegate.window sendSubviewToBack:self.navigationView];
    [[UIApplication sharedApplication].delegate.window sendSubviewToBack:self.collectionButton];
    [[UIApplication sharedApplication].delegate.window sendSubviewToBack:self.taobaoButton];
}
//收藏事件
-(void)collectionAction:(UIButton *)collection{
    
    
}
//淘宝链接
-(void)taobaoAction:(UIButton *)taobao{
    
    
    MLTaoBaoViewController * TaoBaoVC = [MLTaoBaoViewController new];
    
    // self.webView =[[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.webView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    // 设置自适应屏幕大小
    self.webView.scalesPageToFit =YES;
    self.webView.scrollView.bounces = NO;
    //设置用户交互
    self.webView.userInteractionEnabled=YES;
    //设置代理
    //self.webView.delegate=self;
    //添加视图
    [TaoBaoVC.view addSubview:self.webView];
    
    //将浮窗放到最后面
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.model.purchase_url]];
    [self.webView loadRequest:request];
    [[UIApplication sharedApplication].delegate.window sendSubviewToBack:self.navigationView];
    [[UIApplication sharedApplication].delegate.window sendSubviewToBack:self.collectionButton];
    [[UIApplication sharedApplication].delegate.window sendSubviewToBack:self.taobaoButton];
    
    
    [self.navigationController pushViewController:TaoBaoVC animated:YES];
    
    
    
    
}
#pragma makr-----------------tabelView头部轮播 -------------
//轮播图.3
- (void)makeHeader{
    
    //tablevie自带一个最上面的区头
    //添加view
    self.tableView.tableHeaderView =({
        
        //自定义自带区头view大小
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/4*3+10)];
        
        UIView *hedView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/4*3)];
        hedView.backgroundColor =[UIColor whiteColor];
        [view addSubview:hedView];
        
        
        
        //添加轮播
        //轮播图
        self.dataArray = [NSMutableArray array];
        //NSMutableArray *arr = self.model.image_urls;
        self.dataArray=self.model.image_urls;
        
        NSMutableArray *array =[NSMutableArray array];
        for (int i =0; i<self.dataArray.count; i++) {
            //网络解析轮播图调用方法
            
            UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.dataArray[i]]]];
            [array addObject:img];
            
        }
        //添加轮播图到view
        XMCarouselFigureView *ca =[[XMCarouselFigureView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/2)];
        ca.duration=3;
        ca.images=array;
        [hedView addSubview:ca];
        
        
        //商品名
        self.nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(10,kScreenHeight/2+10, kScreenWidth-20,20)];
        self.nameLabel.text = self.model.name;
        [hedView addSubview:self.nameLabel];
        
        //钱
        self.money =[[UIImageView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.nameLabel.frame)+10, 20, 20)];
        
        self.money.image=[UIImage imageNamed:@"钱"];
        
        [hedView addSubview:self.money];
        
        //价格
        self.picLabel =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.money.frame)+10, CGRectGetMaxY(self.nameLabel.frame)+10, 80, 20)];
        self.picLabel.text =self.model.price;
        self.picLabel.font =[UIFont systemFontOfSize:20];
        [hedView addSubview:self.picLabel];
        
        //购物Button
        self.shoping =[UIButton buttonWithType:(UIButtonTypeSystem)];
        self.shoping.frame=CGRectMake(CGRectGetMaxX(self.picLabel.frame)+130, CGRectGetMaxY(self.nameLabel.frame)+10, 50, 20);
        self.shoping.layer.cornerRadius = 10;
        self.shoping.layer.masksToBounds = YES;
        self.shoping.backgroundColor=[UIColor colorWithRed:244/256.0 green:83/256.0 blue:90/256.0 alpha:1];
        [self.shoping setTitle:@"购物" forState:UIControlStateNormal];
        [self.shoping addTarget:self action:@selector(shopingAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.shoping setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];//高亮状态
        [hedView addSubview:self.shoping];
        
        
        
        //描述
        self.descriptionLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.money.frame)+5, kScreenWidth-20, 80)];
        self.descriptionLabel.text =self.model.t_description;
        self.descriptionLabel.font =[UIFont systemFontOfSize:12];
        self.descriptionLabel.numberOfLines=0;
        [hedView addSubview:self.descriptionLabel];

        
        

        view;
    });
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source
//设置区头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 400)];
    header.backgroundColor =[UIColor whiteColor];
    
    //添加WNXSelectView在View,根据scrollViewY轴的偏移量算出selectView的位置
    _selectView = [MLHotDealSectionView selectView];
    _selectView.delegate = self;
    _selectView.frame = CGRectMake(0, 0, kScreenWidth, 40);
    
    [header addSubview:_selectView];
    
    
    
    return header;
    
}
//block图集与评论
- (void)selectView:(MLHotDealSectionView *)selectView didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to {
    MLIndexPathTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (to == 0) {
        [cell.backgroundScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if (to == 1) {
        [cell.backgroundScrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
    }
}
- (void)selectView:(MLHotDealSectionView *)selectView didChangeSelectedView:(NSInteger)to{
    
    
}
//设置区头高度
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    
    
    
    return 40 ;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kScreenHeight;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MLIndexPathTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    UIWebView  *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    //自动适应屏幕大小
    webView.scalesPageToFit = YES;
    //设置用户交互
    webView.userInteractionEnabled = YES;
    //设置代理
    webView.delegate = self;
    webView.scrollView.bounces = NO;
    
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.model.url]]];
    //加载
    [webView loadRequest:request];
    
    [cell.backgroundScrollView addSubview:webView];

    
    return cell;
}

-(void)rightAction:(UIButton *)senter{

        
        [[UIApplication sharedApplication].delegate.window sendSubviewToBack:self.navigationView];
        [[UIApplication sharedApplication].delegate.window sendSubviewToBack:self.collectionButton];
        [[UIApplication sharedApplication].delegate.window sendSubviewToBack:self.taobaoButton];
        
        
        //微博
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:nil
                                          shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social"
                                         shareImage:[UIImage imageNamed:@"icon"]
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatTimeline,UMShareToWechatSession,UMShareToWechatFavorite,UMShareToQQ,nil]
                                           delegate:self];
        
        
        
    




}
-(void)didCloseUIViewController:(UMSViewControllerType)fromViewControllerType
{
    
    [[UIApplication sharedApplication].delegate.window bringSubviewToFront:self.navigationView];
    [[UIApplication sharedApplication].delegate.window bringSubviewToFront:self.collectionButton];
    [[UIApplication sharedApplication].delegate.window bringSubviewToFront:self.taobaoButton];
    
}

//购物点击事件
-(void)shopingAction:(UIButton *)button{
    
    
    
    
    
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
