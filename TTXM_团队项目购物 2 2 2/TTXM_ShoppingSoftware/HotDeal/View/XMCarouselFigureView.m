//
//  XMCarouselFigureView.m
//  CarouselFigureView封装轮播图
//
//  Created by 小明 on 15/12/12.
//  Copyright © 2015年 小明. All rights reserved.
//

#import "XMCarouselFigureView.h"

@interface XMCarouselFigureView ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIPageControl *pageControl;
//驱动轮播的Timer
@property (nonatomic,strong)NSTimer *timer;


@end


@implementation XMCarouselFigureView

-(instancetype)initWithFrame:(CGRect)frame{

    if (self =[super initWithFrame:frame]) {
        
   
        _duration = 2;
        _timer =[NSTimer new];
        
    }

    return self;

}
-(void)setDuration:(NSTimeInterval)duration{
    [self.timer invalidate];
    self.timer=nil;
    
    _duration =duration;
    self.timer=[NSTimer scheduledTimerWithTimeInterval:_duration target:self selector:@selector(carouselAction:) userInfo:self repeats:YES];



}
//images的setter,当对图片数组赋值时触发
//  @param images 图片数组


-(void)setImages:(NSArray *)images{
//让timer停止并为空
    [self.timer invalidate];
    self.timer =nil;
    
    if (_images != images) {
        _images =nil;
        _images =images;
    }
    
//    在外界对图片数组进行赋值的时候,开始绘图
     [self drawView];

    //在外界图片数组进行赋值的时候启动Timer
    self.timer=[NSTimer scheduledTimerWithTimeInterval:self.duration target:self selector:@selector(carouselAction:) userInfo:self repeats:YES];             //旋转
    
    
   
    
    
    

}
//绘制视图方法
-(void)drawView{


    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];

}
//当前视图宽度
#define kWidth self.bounds.size.width
//当前视图高度
#define kHeight self.bounds.size.height
//当前图片个数
#define kCount  self.images.count
//懒加载ScrollView
-(UIScrollView *)scrollView{

    
    
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]initWithFrame:self.bounds];
        [_scrollView setBounces:NO];
        [_scrollView setPagingEnabled:YES];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setContentSize:CGSizeMake(kWidth*kCount, kHeight)];
        [_scrollView setDelegate:self];
        //添加图片
        for (int i =0; i<kCount; i++) {
            
            
            UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(i*kWidth, 0, kWidth, kHeight)];
            imgView.image =self.images[i];
            imgView.userInteractionEnabled =YES;
            imgView.tag=1000+i;
            UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handlTapActionInImageView:)];
            
            [imgView addGestureRecognizer:tap];
            
            
            [_scrollView addSubview:imgView];
        }
        
    }

    return _scrollView;
 
}
//懒加载PageControl
#define kGap 10
#define kPageControlHeight 29
-(UIPageControl *)pageControl{

    if (!_pageControl ) {
        
        
        _pageControl =[[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, kWidth, 29)];
        [_pageControl setCenter:CGPointMake(kWidth/2, kHeight-kPageControlHeight/2-kGap)];
        [_pageControl setBackgroundColor:[UIColor clearColor]];
        [_pageControl setPageIndicatorTintColor:[UIColor redColor]];
        [_pageControl setCurrentPageIndicatorTintColor:[UIColor greenColor]];
        [_pageControl setNumberOfPages:kCount];
        
        
                                
    }

    return _pageControl;
    
}
#pragma mark  ---- Timer驱动轮播机制 -----

-(void)carouselAction:(id)sendr{
//每次方法执行的时候,"当前页"+1
    self.currenIndx ++;
    
    //越界判断
    if (self.currenIndx == kCount) {
        self.currenIndx = 0;
    }
    
    
//根据当前页 这一个属性设置PageControl当前页
    self.pageControl.currentPage =self.currenIndx;
//根据"当前页"这一个属性来设置ScrollView的偏移量
    self.scrollView.contentOffset = CGPointMake(kWidth*self.currenIndx, 0);
    

}

#pragma mark -- UIScrollViewDelegate------
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

//开始拖曳时,timer驱动机制停止
    [self.timer invalidate];
    self.timer = nil;



}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    //根据视图偏移矫正当前下坐标
    self.currenIndx =(NSUInteger)scrollView.contentOffset.x/kWidth;
    //根据新的下标矫正pageControl的currentPage
    self.pageControl.currentPage=self.currenIndx;
    

//停止减速后启动
    self.timer=[NSTimer scheduledTimerWithTimeInterval:self.duration target:self selector:@selector(carouselAction:) userInfo:self repeats:YES];

}

#pragma mark ------  Tap手势   -----
-(void)handlTapActionInImageView:(UITapGestureRecognizer *)tap{
//    //获取所点击的视图
//    UIImageView *imgView =(UIImageView *)tap.view;
//    //获取对应下标
//    NSUInteger index = [self.images indexOfObject:imgView.image];
    
    //    //获取所点击的视图
        UIImageView *imgView =(UIImageView *)tap.view;
    //获取下标
    NSUInteger index = imgView.tag-1000;
    
    if (_delegate && [_delegate respondsToSelector:@selector(carouselFigureViewDidCarousel:withIndex:)]) {
        [_delegate carouselFigureViewDidCarousel:self withIndex:index];
    }
    
    
    
    //当手势触发时,代理对象执行代理方法
    //将当前视图和当前下标携带给外界
 


}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
