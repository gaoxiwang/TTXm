//
//  JLMainViewController.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "JLMainViewController.h"
#import "UIBarButtonItem+ZBBarButton.h"
#import "JLMineHeaderTableView.h"
#import "ZBMineidentityTool.h"
#import "JLLIkeController.h"
#import "JLStrategyController.h"
#import "JLMineHeaderInSectionView.h"
//#import "ZBItemDetailsController.h"
//#import "ZBItemModel.h"
//#import "DetailWebViewController.h"
//#import "Subject.h"

//顶部scrollHeadView 的高度,先给写死
static const CGFloat ScrollHeadViewHeight = 200;
//选择View的高度
static const CGFloat SelectViewHeight = 45;

@interface JLMainViewController ()<UITableViewDelegate,UIScrollViewDelegate,JLMineHeaderInSectionViewDelegate>

//设置顶部的tableView
@property(strong,nonatomic) UIView *  headerTableView;
/** 喜欢的礼物tableview */
@property (weak, nonatomic) UITableView *  likeTableView;
/** 喜欢的攻略tableview */
@property (weak, nonatomic) UITableView *  strategyTableView;

/** 记录scrollView上次偏移的Y距离 */
@property (nonatomic, assign) CGFloat    scrollY;
/** 记录scrollView上次偏移X的距离 */
@property (nonatomic, assign) CGFloat      scrollX;
/** 最底部的scrollView，用来掌控所有控件的滚动 */
@property (nonatomic, strong) UIScrollView    *backgroundScrollView;
/** 用来装顶部的scrollView用的View */
@property (nonatomic, strong) UIView      *topView;
/** 顶部的图片scrollView */
@property (nonatomic, strong) UIImageView   *topImageView;
/** 设置按钮 */
@property (nonatomic, strong) UIButton     *setBtn;
/** 导航条的title */
@property (nonatomic, strong) UILabel      *titleLabel;
/** 导航条下边的副标题 */
@property (nonatomic, strong) UILabel      *subTitleLabel;

@property(nonatomic,strong) JLLIkeController *likeController;
@property(nonatomic,strong) JLStrategyController *strategyController;

@property(nonatomic,strong) JLMineHeaderInSectionView *selectView;
//导航条的背景view
@property(nonatomic,strong) UIView  *naviView;
@property(nonatomic,strong) UIView *naviView1;
/** 记录当前展示的tableView 计算顶部topView滑动的距离 */
@property (nonatomic, weak  ) UITableView   *showingTableView;


@end

@implementation JLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //初始化界面
    [self setUI];
    
    //初始化导航条上的内容
    [self setUpNavigtionBar];


    
}
- (void)setUI
{
    
    //将view的自动添加scroll的内容偏移关闭
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置背景色
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化最底部的scrollView,装tableView用
    self.backgroundScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.backgroundScrollView];
    self.view.backgroundColor=[UIColor redColor];
    
    self.backgroundScrollView.backgroundColor = [UIColor whiteColor];
    self.backgroundScrollView.pagingEnabled = YES;
    self.backgroundScrollView.bounces = NO;
    self.backgroundScrollView.showsHorizontalScrollIndicator = NO;
    self.backgroundScrollView.delegate = self;
    self.backgroundScrollView.contentSize = CGSizeMake(kScreenWidth * 2, 0);
    
    // 设置likeTableview
    self.likeController = [JLLIkeController likeControllerWithContoller:self];
    self.likeTableView = self.likeController.tableView;
    self.likeTableView.delegate = self;
    self.likeTableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    //UIEdgeInsetsMake 从这里开始显示:top,left,bottom,right
    self.likeTableView.contentInset = UIEdgeInsetsMake(ScrollHeadViewHeight + SelectViewHeight, 0, 0, 0);
    [self.backgroundScrollView addSubview:self.likeTableView];
    
    // 设置strategyTableView
    self.strategyController = [JLStrategyController strategyControllerWithContoller:self];
    self.strategyTableView = self.strategyController.tableView;
    self.strategyTableView.delegate = self;
    //给顶部的图片view和选择view留出距离
    self.strategyTableView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
    self.strategyTableView.contentInset = UIEdgeInsetsMake(ScrollHeadViewHeight + SelectViewHeight, 0, 0, 0);
    [self.backgroundScrollView addSubview:self.strategyTableView];
    
    //添加顶部的图片scrollView
    self.topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backImageOne"]];
    [self.topImageView setFrame:CGRectMake(0, 0, kScreenWidth, ScrollHeadViewHeight)];
    self.naviView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.topImageView.bounds.size.height)];
    self.naviView1.backgroundColor = ZBColor(223, 83, 82, 1);
    self.naviView1 .alpha = 0.0;
    [self.topImageView addSubview:self.naviView1];
    
    self.topView = [[UIView alloc] initWithFrame:self.topImageView.bounds];
    self.topView.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:self.topImageView];
    [self.view addSubview:self.topView];
    
    //添加WNXSelectView在View,根据scrollViewY轴的偏移量算出selectView的位置
    _selectView = [JLMineHeaderInSectionView selectView];
    _selectView.delegate = self;
    _selectView.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame), kScreenWidth, SelectViewHeight);
    [self.view addSubview:_selectView];
    
}
//初始化导航条上的内容
- (void)setUpNavigtionBar
{
    //初始化导航条
    self.naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    self.naviView.backgroundColor = ZBColor(223, 83, 82, 1);
    self.naviView.alpha = 0.0;
    [self.view addSubview:self.naviView];
    
    //设置按钮
    self.setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.setBtn.frame = CGRectMake(kScreenWidth - 36, 32, 25, 25);
    [self.setBtn setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [self.setBtn addTarget:self action:@selector(setBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.setBtn];
    
    //添加导航条上的大文字
    self.titleLabel = [[UILabel alloc] init];
    [self.titleLabel setFrame:CGRectMake(50, 32, kScreenWidth, 25)];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.text = @"我的纪念日";
    self.titleLabel.font = [UIFont boldSystemFontOfSize:19];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.titleLabel];
        
    //添加副标题
    self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(52, 60, kScreenWidth - 150, 20)];
    self.subTitleLabel.textAlignment = NSTextAlignmentLeft;
    self.subTitleLabel.textColor = [UIColor whiteColor];
    self.subTitleLabel.font = [UIFont systemFontOfSize:16];
    self.subTitleLabel.text = @"这里收藏着您喜欢的礼物和攻略";
    [self.view addSubview:self.subTitleLabel];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    if (scrollView == self.likeTableView || scrollView == self.strategyTableView) {//说明是tableView在滚动
        
        //记录当前展示的是那个tableView
        self.showingTableView = (UITableView *)scrollView;
        
        //记录出上一次滑动的距离，因为是在tableView的contentInset中偏移的ScrollHeadViewHeight
        CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat seleOffsetY = offsetY - self.scrollY;
        self.scrollY = offsetY;
        
        //修改顶部的scrollHeadView位置 并且通知scrollHeadView内的控件也修改位置
        CGRect headRect = self.topView.frame;
        headRect.origin.y -= seleOffsetY;
        self.topView.frame = headRect;
        
        
        //根据偏移量算出alpha的值,渐隐,当偏移量大于-180开始计算消失的值
        CGFloat startF = -180;
        //初始的偏移量Y值为 顶部俩个控件的高度
        CGFloat initY = SelectViewHeight + ScrollHeadViewHeight;
        //缺少的那一段渐变Y值
        CGFloat lackY = initY + startF;
        //自定义导航条高度
        CGFloat naviH = 64;
        
        //渐隐alpha值
        CGFloat alphaScaleHide = 1 - (offsetY + initY- lackY) / (initY- naviH - SelectViewHeight - lackY);
        //渐现alph值
        CGFloat alphaScaleShow = (offsetY + initY - lackY) /  (initY - naviH - SelectViewHeight - lackY) ;
        
        if (alphaScaleShow >= 0.98) {
            //显示导航条
            [UIView animateWithDuration:0.04 animations:^{
                self.naviView.alpha = 1;
            }];
        } else {
            self.naviView.alpha = 0;
        }
        
        //初始化自定义的导航view
        
        self.naviView1.alpha = alphaScaleShow;
        self.subTitleLabel.alpha = alphaScaleHide;
        //self.smallImageView.alpha = alphaScaleHide;
        
        
        if (offsetY >= -(naviH + SelectViewHeight)) {
            self.selectView.frame = CGRectMake(0, naviH, kScreenWidth, SelectViewHeight);
        } else {
            self.selectView.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame), kScreenWidth, SelectViewHeight);
        }
        
        CGFloat scaleTopView = 1 - (offsetY + SelectViewHeight + ScrollHeadViewHeight) / 100;
        scaleTopView = scaleTopView > 1 ? scaleTopView : 1;
        
        //算出头部的变形
        CGAffineTransform transform = CGAffineTransformMakeScale(scaleTopView, scaleTopView );
        CGFloat ty = (scaleTopView - 1) * ScrollHeadViewHeight;
        self.topView.transform = CGAffineTransformTranslate(transform, 0, -ty * 0.2);
        
        //记录selectViewY轴的偏移量,这个是用来计算每次切换tableView，让新出来的tableView总是在头部用的，
        CGFloat selectViewOffsetY = self.selectView.frame.origin.y - ScrollHeadViewHeight;
        
        if (selectViewOffsetY != -ScrollHeadViewHeight && selectViewOffsetY <= 0) {
            
            if (scrollView == self.likeTableView) {
                
                self.strategyTableView.contentOffset = CGPointMake(0, -245 - selectViewOffsetY);
                
                
            } else {
                
                self.likeTableView.contentOffset = CGPointMake(0, -245 - selectViewOffsetY);
                
            }
        }
        
    } else { //说明是backgroundScrollView在滚动
        
        CGFloat selectViewOffsetY = self.selectView.frame.origin.y - ScrollHeadViewHeight;
        //让新出来的tableView的contentOffset正好卡在selectView的头上,还是有bug
        if (selectViewOffsetY != -ScrollHeadViewHeight && selectViewOffsetY <= 0) {
            if (self.showingTableView == self.strategyTableView) {
                
                self.strategyTableView.contentOffset = CGPointMake(0, -245 - selectViewOffsetY);
            } else {
                
                self.likeTableView.contentOffset = CGPointMake(0, -245 - selectViewOffsetY);
            }
        }
        
        CGFloat offsetX = self.backgroundScrollView.contentOffset.x;
        NSInteger index = offsetX / kScreenWidth;
        
        CGFloat seleOffsetX = offsetX - self.scrollX;
        self.scrollX = offsetX;
        
        //根据scrollViewX偏移量算出顶部selectViewline的位置
        if (seleOffsetX > 0 && offsetX / kScreenWidth >= (0.5 + index)) {
            [self.selectView lineToIndex:index + 1];
        } else if (seleOffsetX < 0 && offsetX / kScreenWidth <= (0.5 + index)) {
            [self.selectView lineToIndex:index];
        }
    }
}
#pragma mark - 设置TabBar的图片
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //隐藏系统的导航条，由于需要自定义的动画，自定义一个view来代替导航条
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    ZBMineidentityTool *identityTool = [ZBMineidentityTool sharedZBMineidentityTool];
    if ([identityTool.gender isEqual:@2]) {
        NSLog(@"-----------------------------------女");
        self.tabBarItem.image = [UIImage imageNamed:@"Women"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"Women"];
        
    }else {
        self.tabBarItem.image = [UIImage imageNamed:@"Man"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"Man"];
        NSLog(@"-----------------------------------男");
        
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - WNXSelectViewDelegate选择条的代理方法
- (void)selectView:(JLMineHeaderInSectionView *)selectView didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to
{
    switch (to) {
        case 0:
            self.showingTableView = self.likeTableView;
            break;
        case 1:
            self.showingTableView = self.strategyTableView;
            break;
        default:
            break;
    }
    
    //根据点击的按钮计算出backgroundScrollView的内容偏移量
    CGFloat offsetX = to * kScreenWidth;
    CGPoint scrPoint = self.backgroundScrollView.contentOffset;
    scrPoint.x = offsetX;
    //默认滚动速度有点慢 加速了下
    [UIView animateWithDuration:0.3 animations:^{
        [self.backgroundScrollView setContentOffset:scrPoint];
    }];
    
}

//当滑动scrollView切换tableView时通知
- (void)selectView:(JLMineHeaderInSectionView *)selectView didChangeSelectedView:(NSInteger)to
{
    if (to == 0) {
        self.showingTableView = self.likeTableView;
    } else if (to == 1) {
        self.showingTableView = self.strategyTableView;
    }
}
#pragma mark - tabView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.likeTableView) {
        //ZBItemDetailsController *detailsVC = [ZBItemDetailsController new];
        //ZBItemModel *model = self.likeController.dataArray[indexPath.row];
        //detailsVC.detail_url = model.url;
        //[self.navigationController pushViewController:detailsVC animated:YES];
    }else {
        //DetailWebViewController *detailVC = [DetailWebViewController new];
       // SubjectList *sub = self.strategyController.dataArray[indexPath.row];
//        detailVC.subjectList = sub;
//        detailVC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(bianji)];
//        detailVC.title = sub.title;
//        detailVC.view.backgroundColor = [UIColor whiteColor];
//        // 设置导航属性
//        detailVC.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(backClick) Image:@"myback" selectedImage:@"myback"];
//        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

#pragma mark - 返回按钮
- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)bianji {
    NSLog(@"bianjibianji");
}

- (void)setBtnClick
{
    JLMineHeaderTableView *headerTVC = [JLMineHeaderTableView new];
    [self.navigationController pushViewController:headerTVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    


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
