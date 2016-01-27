//
//  HQHomeViewController.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "HQHomeViewController.h"

@interface HQHomeViewController ()

//精选控制器
@property (nonatomic, strong)JingxuanTableViewController *jingXuanVC;

// 菜单栏的数据数组
@property (nonatomic, strong) NSMutableArray *menuListDataArray;
// 存储控制器的数组
@property (nonatomic, strong) NSMutableArray *controllerDataArray;
// 第三方 SCNavTabBarController 控制器
@property (nonatomic, strong) SCNavTabBarController *navTabBarController;


@end

int i = 1;
@implementation HQHomeViewController

#define kWidth ([UIScreen mainScreen].bounds.size.width)
#define kHeight ([UIScreen mainScreen].bounds.size.height)
#define kGap kWidth/20

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.navigationItem.title = @"有礼相送";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-sousuo"] style:UIBarButtonItemStylePlain target:self action:@selector(researchAction:)];
        
    }
    return self;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadMenuData];
}

-(void)viewWillAppear:(BOOL)animated
{
    
  [self setUpController];

}



-(void)loadMenuData
{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    __block typeof(self) weakSelf = self;
    
    self.gender = [[[NSUserDefaults standardUserDefaults] stringForKey:@"gender"] integerValue];
    self.generation = [[[NSUserDefaults standardUserDefaults] stringForKey:@"generation"] integerValue];
    NSString *url = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/channels/preset?gender=%lu&generation=%lu", self.gender, self.generation];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        dispatch_async(dispatch_get_main_queue(), ^{
            self.menuListDataArray = [NSMutableArray array];
            for (NSDictionary *dict in responseObject[@"data"][@"channels"]) {
                
                GiftClassifyModel *model = [[GiftClassifyModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [weakSelf.menuListDataArray addObject:model];
            }
            [weakSelf setUpController];
        });
        
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
     }];

}

-(void)setUpController
{
    
    self.gender = [[NSUserDefaults standardUserDefaults] integerForKey:@"gender"];
    self.generation = [[NSUserDefaults standardUserDefaults] integerForKey:@"generation"];
    self.controllerDataArray = [NSMutableArray array];
   
    for (int i = 0; i < self.menuListDataArray.count; i++) {
        
        if (i == 0) {
            GiftClassifyModel *model = self.menuListDataArray[0];
            JingxuanTableViewController *jingXuanVC = [[JingxuanTableViewController alloc] init];
            jingXuanVC._id = model._id;
            jingXuanVC.gender = self.gender;
            jingXuanVC.generation = self.generation;    jingXuanVC.title = model.name;
            [self.controllerDataArray addObject:jingXuanVC];
        }else
        {
            OtherTableViewController *otherVC = [[OtherTableViewController alloc] init];
            GiftClassifyModel *model = self.menuListDataArray[i];
            otherVC._id = model._id;
            otherVC.gender = self.gender;
            otherVC.generation = self.generation;
            otherVC.title = model.name;
            [self.controllerDataArray addObject:otherVC];
            
        }
    }
    self.navTabBarController = [[SCNavTabBarController alloc] init];
    self.navTabBarController.subViewControllers = self.controllerDataArray;
    
    self.navTabBarController.showArrowButton = YES;
    [self.navTabBarController addParentController:self];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)menuListDataArray
{
    if (!_menuListDataArray) {
        _menuListDataArray = [NSMutableArray array];
    }
    return _menuListDataArray;

}

-(void)researchAction:(UIBarButtonItem *)sender
{
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];


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
