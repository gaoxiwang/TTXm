//
//  HotListCollectionViewController.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/22.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "HotListCollectionViewController.h"

@interface HotListCollectionViewController ()

@end

@implementation HotListCollectionViewController

static NSString * const reuseIdentifier = @"Cell";




-(id)init
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.itemSize = CGSizeMake((kWidth-40)/2, kHeight/3+60);
   
    flow.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
    
    [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
    return [super initWithCollectionViewLayout:flow];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    _dataArray = [NSMutableArray array];
    
    
    NSURL *url = [NSURL URLWithString:_urlString];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            NSMutableArray *arr = [dic[@"data"] objectForKey:@"items"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            
            for (NSDictionary *dic in arr) {
                HotList *model = [HotList new];
                [model setValuesForKeysWithDictionary:dic];
                [_dataArray addObject:model];
            }
            
            [self.collectionView registerClass:[HotListCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
            self.collectionView.delegate = self;
            self.collectionView.dataSource = self;
            [self.collectionView reloadData];
        });

      
        
    }];
    
    [task resume];
    

    


    
    
    // Do any additional setup after loading the view.
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return _dataArray.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HotListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    HotList *model = [HotList new];
    model = _dataArray[indexPath.row];

    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
    cell.nameLabel.text = model.name;
    cell.priceLabel.text = model.price;

    return cell;
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

#pragma mark <UICollectionViewDataSource>







#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
