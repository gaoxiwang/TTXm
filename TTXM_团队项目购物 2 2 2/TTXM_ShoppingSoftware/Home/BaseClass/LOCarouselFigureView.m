//
//  LOCarouselFigureView.m
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/18.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import "LOCarouselFigureView.h"

@interface LOCarouselFigureView ()<UIScrollViewDelegate>

@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UIPageControl *pageControl;

//驱动轮播的Timer
@property (strong,nonatomic) NSTimer *timer;


@end

@implementation LOCarouselFigureView

-(instancetype)initWithFrame:(CGRect)frame
{
    //让Timer停止并且为空
    [self.timer invalidate];
    self.timer = nil;
    if (self = [super initWithFrame:frame]) {
        
        _duration = 2;
        _timer = [NSTimer new];
        
    }
    return self;
    
}

- (void)setDuration:(NSTimeInterval)duration
{
    
    [self.timer invalidate];
    self.timer = nil;
    _duration = duration;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:_duration target:self selector:@selector(carouslAction:) userInfo:self repeats:YES];
}

//重写set方法,当向图片数组赋值时触发
-(void)setImages:(NSArray *)images
{
    [self.timer invalidate];
    self.timer = nil;
    
    if (_images != images) {
        _images = nil;
        _images = images;
    }
    //在外界对图片数组赋值时,开始绘图
    [self drawView];
    //在外界对图片数组赋值时,启动Timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.duration target:self selector:@selector(carouslAction:) userInfo:self repeats:YES];
}

//绘制视图的方法
-(void)drawView
{
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    
}

//当前视图宽度
#define kWidth self.bounds.size.width
//当前视图高度
#define kHeight self.bounds.size.height
//当前图片个数
#define kCount self.images.count
//懒加载
-(UIScrollView *)scrollView
{
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [_scrollView setBounces:NO];
        [_scrollView setPagingEnabled:YES];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setContentSize:CGSizeMake(kWidth *kCount, kHeight)];
        
        [_scrollView setDelegate:self];
        
        //添加图片视图
        for (int i = 0; i < kCount; i++) {
            
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i *kWidth, 0, kWidth, kHeight)];
            imgView.image = self.images[i];
            //打开用户交替
            imgView.userInteractionEnabled = YES;
            
            imgView.tag = 1000 + i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlTapActionInImageView:)];
            [imgView addGestureRecognizer:tap];
            
            [_scrollView addSubview:imgView];
        }
        
    }
    return _scrollView;
    
}

//懒加载
#define kGap 10
#define kPageControlHeight 29
- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, kWidth, 29)];
        [_pageControl setCenter:CGPointMake(kWidth /2, kHeight - kPageControlHeight/2 - kGap)];
        [_pageControl setBackgroundColor:[UIColor clearColor]];
        [_pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
        [_pageControl setNumberOfPages:kCount];
    }
    return _pageControl;
}

#pragma mark--------Timer 驱动轮播机制----------

-(void)carouslAction:(id)sender
{
    
    //每次方法执行时,"当前页" +1
    self.currentIndex ++;
    
    //越界判断
    if (self.currentIndex == kCount) {
        self.currentIndex = 0;
    }
    
    //根据"当前页"这一个属性来设置pageControl的当前页
    self.pageControl.currentPage = self.currentIndex;
    //根据"当前页"这个属性来设置ScrollView的偏移量
    self.scrollView.contentOffset = CGPointMake(kWidth *self.currentIndex, 0);
    
}

#pragma mark------UIScrollViewDelegate-------

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //开始拖拽时,Timer驱动机制停止
    [self.timer invalidate];
    self.timer = nil;
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //根据视图偏移校正当前下标
    self.currentIndex = scrollView.contentOffset.x/kWidth;
    //根据新的下标校正pageControl的currentPage
    self.pageControl.currentPage = self.currentIndex;
    //停止减速时启动Timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.duration target:self selector:@selector(carouslAction:) userInfo:self repeats:YES];
}

#pragma mark------Tap 手势-------

-(void)handlTapActionInImageView:(UITapGestureRecognizer *)tap
{
    
    
    //获取所点击的视图
    UIImageView *imgView = (UIImageView *)tap.view;
   
    //和获取下标
    NSUInteger index = imgView.tag - 1000;
    WheelModel *model = self.dataArray[index];
    
    //    //当收拾出发时,代理对象执行代理方法
    //    //将当前视图和当前下标传递给外界
    
    if (_delegate && [_delegate respondsToSelector:@selector(carouselFigureViewDidCarousel:withIndex:)]) {
        [_delegate carouselFigureViewDidCarousel:self withIndex:model.target_id];
        
    }
}



@end
