//
//  TankCycleScrollView.m
//  TankCarouselFigure
//
//  Created by yanwb on 15/12/23.
//  Copyright © 2015年 JINMARONG. All rights reserved.
//

#import "TankCycleScrollView.h"
#import "UIImageView+WebCache.h"

@interface TankCycleScrollView () <UIScrollViewDelegate>
//定时器
@property (nonatomic, strong) NSTimer *animationTimer;
//轮播视图
@property (nonatomic, weak) UIScrollView *cycleScrollView;
//定时器时间
@property (nonatomic, assign) NSTimeInterval animationDuration;
//当前显示页码
@property (nonatomic, assign) NSInteger currentPageIndex;
//总页码数
@property (nonatomic, assign) NSInteger totalPageCount;
//用于显示的图片控件数组
@property (nonatomic, strong) NSMutableArray *contentViews;
//总图片控件数组
@property (nonatomic, strong) NSMutableArray *subContentViews;
////点击页码
//@property (nonatomic, assign) NSInteger currentSelectIndex;
//实际滚动焦点图数组
@property (nonatomic, strong) NSMutableArray *cycleCarouselArray;
//当前请求失败次数
@property (nonatomic, assign) NSInteger currentNetWorkFaildCount;
//页码显示器
@property (nonatomic, strong) UIPageControl *pageControl;
//初始宽度
@property (nonatomic, assign) CGFloat orginWidth;
//初始高度
@property (nonatomic, assign) CGFloat orginHeight;
//拉伸显示图片
@property (nonatomic, weak) UIImageView *stretchImageView;

@end

@implementation TankCycleScrollView

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration
{
    
    self = [self initWithFrame:frame];
    self.frame = frame;
    self.orginWidth = frame.size.width;
    self.orginHeight = frame.size.height;
    self.cycleScrollPageControlAliment = TankCyclePageContolAlimentCenter;
    self.cycleCurrentPageIndicatorTintColor = [UIColor blueColor];
    self.cyclePageIndicatorTintColor = [UIColor whiteColor];
    self.showPageControl = YES;
    self.enbleStretch = NO;
    if (animationDuration > 0.0) {
        // 设置定时器
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration)
                                                               target:self
                                                             selector:@selector(animationTimerDidFired:)
                                                             userInfo:nil
                                                              repeats:YES];
        [self.animationTimer pauseTimer];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        self.networkFailedCount = 10;
        self.autoresizesSubviews = YES;
        UIScrollView *cycleScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        cycleScrollView.autoresizingMask = 0xFF;
        cycleScrollView.contentMode = UIViewContentModeCenter;
        cycleScrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(cycleScrollView.frame), 0);
        cycleScrollView.delegate = self;
        cycleScrollView.contentOffset = CGPointMake(CGRectGetWidth(cycleScrollView.frame), 0);
        cycleScrollView.pagingEnabled = YES;
        cycleScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:cycleScrollView];
        self.currentPageIndex = 0;
        self.cycleScrollView = cycleScrollView;
        
        
        UIImageView *stretchImageView = [[UIImageView alloc] initWithFrame:self.cycleScrollView.frame];
        self.stretchImageView = stretchImageView;
        stretchImageView.hidden = YES;
        [self addSubview:stretchImageView];

    }
    return self;
}

- (NSMutableArray *)subContentViews
{
    if (_subContentViews == nil) {
        _subContentViews = [NSMutableArray array];
    }
    return _subContentViews;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.currentPageIndicatorTintColor = self.cycleCurrentPageIndicatorTintColor;
    pageControl.pageIndicatorTintColor = self.cyclePageIndicatorTintColor;
    pageControl.numberOfPages = self.totalPageCount;
    self.pageControl = pageControl;
    if (self.cycleScrollPageControlAliment == TankCyclePageContolAlimentCenter) {
        pageControl.frame = CGRectMake((CGRectGetWidth(self.frame) - 100) * 0.5, CGRectGetHeight(self.frame) - 30, 100, 30);
    } else {
        pageControl.frame = CGRectMake(CGRectGetWidth(self.frame) - 120, CGRectGetHeight(self.frame) - 30, 100, 30);
    }
    [self addSubview:self.pageControl];
    
    if (self.showPageControl) {
        if (self.totalPageCount > 1) {
            pageControl.hidden = NO;
        } else {
            pageControl.hidden = YES;
        }
    } else {
        pageControl.hidden = YES;
    }
    self.pageControl.currentPage = self.currentPageIndex;
}

- (void)setModelArray:(NSArray *)modelArray
{
    _modelArray = modelArray;
}

- (void)setCycleImageArray:(NSArray *)cycleImageArray
{
    _cycleImageArray = cycleImageArray;


    if (cycleImageArray.count==0 || cycleImageArray==nil) {
        return;
    }
    
    self.cycleCarouselArray = [NSMutableArray arrayWithArray:cycleImageArray];
    
    [self setSubImageViewWithPicArray:cycleImageArray withURLType:NO];
    
    [self configContentViews];
}

- (void)setCycleImageUrlArray:(NSArray *)cycleImageUrlArray
{
    _cycleImageUrlArray = cycleImageUrlArray;
    
    if (cycleImageUrlArray.count==0 || cycleImageUrlArray==nil) {
        return;
    }

    
    self.cycleCarouselArray = [NSMutableArray arrayWithCapacity:cycleImageUrlArray.count];
    
    for (int i = 0; i < cycleImageUrlArray.count; i++) {
        UIImage *image = [[UIImage alloc] init];
        [self.cycleCarouselArray addObject:image];
    }
    
    [self setSubImageViewWithPicArray:self.cycleImageUrlArray withURLType:YES];
    
    [self configContentViews];
    
}

- (void)setNetworkFailedCount:(NSInteger)networkFailedCount
{
    _networkFailedCount = networkFailedCount;
}

#pragma mark - 根据传递类型加载图片
-(void)setSubImageViewWithPicArray:(NSArray *)picArray withURLType:(BOOL)url
{
    self.totalPageCount = picArray.count;
    NSMutableArray *viewsArray = [@[] mutableCopy];
    if (picArray.count > 2) {
        for (int i = 0; i < picArray.count; ++i) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.cycleScrollView.frame), CGRectGetHeight(self.cycleScrollView.frame))];
            if (url) {
                [self imageView:imageView loadImageWithURL:picArray[i] atIndex:i];
            } else {
                imageView.image = picArray[i];
            }
            [viewsArray addObject:imageView];
        }
    } else if (picArray.count == 2) {
        for (int i = 0; i < picArray.count * 2 ; ++i) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.cycleScrollView.frame), CGRectGetHeight(self.cycleScrollView.frame))];
            if (url) {
                [self imageView:imageView loadImageWithURL:picArray[i%2] atIndex:i];
            }else {
                imageView.image = picArray[i%2];
            }
            [viewsArray addObject:imageView];
        }
    } else {
        for (int i = 0; i < picArray.count * 4; ++i) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.cycleScrollView.frame), CGRectGetHeight(self.cycleScrollView.frame))];
            if (url) {
                [self imageView:imageView loadImageWithURL:picArray[0] atIndex:i];
            } else {
                imageView.image = picArray[0];
            }
            [viewsArray addObject:imageView];
        }
    }
    
    self.subContentViews = viewsArray;
    
    [self.animationTimer resumeTimer];
}




// 加载网络图片
- (void)imageView:(UIImageView *)imageView loadImageWithURL:(NSString *)urlStr atIndex:(NSInteger)index{
    
    NSURL *url = nil;
    
    
    if ([urlStr isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:urlStr];
    } else if ([urlStr isKindOfClass:[NSURL class]]) { // 兼容NSURL
        url = (NSURL *)urlStr;
    }
    
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlStr];
    if (image) {
        [self.cycleCarouselArray setObject:image atIndexedSubscript:index];
        imageView.image = image;
    } else {
        [imageView sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                [self.cycleCarouselArray setObject:image atIndexedSubscript:index];
            } else {
                if (self.currentNetWorkFaildCount > self.networkFailedCount) return;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self imageView:imageView loadImageWithURL:urlStr atIndex:index];
                });
                self.currentNetWorkFaildCount++;
                
            }
        }];
    }
}

#pragma mark - 私有函数

- (void)configContentViews
{
    [self.cycleScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setScrollViewContentDataSource];
    
    NSInteger counter = 0;
    for (UIView *contentView in self.contentViews) {
        contentView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [contentView addGestureRecognizer:tapGesture];
        CGRect rightRect = contentView.frame;
        rightRect.origin = CGPointMake(CGRectGetWidth(self.cycleScrollView.frame) * (counter ++), 0);
        contentView.frame = rightRect;
        [self.cycleScrollView addSubview:contentView];
    }
    [self.cycleScrollView setContentOffset:CGPointMake(_cycleScrollView.frame.size.width, 0)];
    
}


/**
 *  设置scrollView的content数据源，即contentViews
 */
- (void)setScrollViewContentDataSource
{
    NSInteger previousPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
    NSInteger rearPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
    if (self.contentViews == nil) {
        self.contentViews = [@[] mutableCopy];
    }
    [self.contentViews removeAllObjects];
    if ([self featchContentViewAtIndex:self.currentPageIndex]) {
        [self.contentViews addObject:[self featchContentViewAtIndex:previousPageIndex]];
        [self.contentViews addObject:[self featchContentViewAtIndex:self.currentPageIndex]];
        [self.contentViews addObject:[self featchContentViewAtIndex:rearPageIndex]];
    }
    if (self.totalPageCount > 1) {
        self.cycleScrollView.scrollEnabled = YES;
    } else {
        self.cycleScrollView.scrollEnabled = NO;
    }
}

-(UIView *)featchContentViewAtIndex:(NSInteger)index
{
    return self.subContentViews[index];
}


- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)currentPageIndex;
{
    
    if (self.totalPageCount > 2) {
        if(currentPageIndex == -1) {
            return self.totalPageCount - 1;
        } else if (currentPageIndex == self.totalPageCount) {
            return 0;
        } else {
            return currentPageIndex;
        }
    } else if (self.totalPageCount == 2){
        if(currentPageIndex == -1) {
            return (self.totalPageCount * 2 - 1);
        } else if (currentPageIndex == self.totalPageCount * 2) {
            return 0;
        } else {
            return currentPageIndex;
        }
    } else {
        if(currentPageIndex == -1) {
            return (self.totalPageCount * 4 - 1);
        } else if (currentPageIndex == self.totalPageCount * 4) {
            return 0;
        } else {
            return currentPageIndex;
        }
    }
}

#pragma mark -
#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.totalPageCount > 1) {
        [self.animationTimer pauseTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.totalPageCount > 1) {
        [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.cycleCarouselArray.count == 0 || self.cycleCarouselArray==nil) {
        return;
    }
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
        if (self.totalPageCount > 2) {
            self.pageControl.currentPage = self.currentPageIndex;
        } else if (self.totalPageCount == 2 ) {
            self.pageControl.currentPage = self.currentPageIndex % 2;
        } else {
            self.pageControl.currentPage = 0;
        }
        
        [self configContentViews];
    }
    if(contentOffsetX <= 0) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
        if (self.totalPageCount > 2) {
            self.pageControl.currentPage = self.currentPageIndex;
        } else if (self.totalPageCount == 2 ) {
            self.pageControl.currentPage = self.currentPageIndex % 2;
        } else {
            self.pageControl.currentPage = 0;
        }
        [self configContentViews];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
}

#pragma mark -
#pragma mark - 响应事件

- (void)animationTimerDidFired:(NSTimer *)timer
{
    CGPoint newOffset = CGPointMake(CGRectGetWidth(self.cycleScrollView.frame) + CGRectGetWidth(self.cycleScrollView.frame), self.cycleScrollView.contentOffset.y);
    [self.cycleScrollView setContentOffset:newOffset animated:YES];
    
}

- (void)contentViewTapAction:(UITapGestureRecognizer *)tap
{
    if (self.TapActionBlock) {
        NSInteger currentSelectIndex;
        if (self.modelArray.count > 2) {
            currentSelectIndex = self.currentPageIndex;
        } else if (self.modelArray.count == 2) {
            currentSelectIndex = self.currentPageIndex%2;
        } else {
            currentSelectIndex = 0;
        }
      id  model = self.modelArray[currentSelectIndex];
        self.TapActionBlock(currentSelectIndex,model);
    }
}

- (void)resumeTimer
{
    if (self.totalPageCount > 1) {
        [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
    }
}


- (void)pauseTimer
{
    [self.animationTimer pauseTimer];
    CGPoint newOffset = CGPointMake(CGRectGetWidth(self.cycleScrollView.frame), self.cycleScrollView.contentOffset.y);
    [self.cycleScrollView setContentOffset:newOffset animated:YES];
}


#pragma mark - 图片拉伸问题
- (void)cycleScrollViewStretchingWithOffset:(CGFloat)offset
{
    if (!self.enbleStretch) {
        return;
    }
    CGFloat whpercent = self.orginWidth/self.orginHeight;
    CGFloat height = self.orginHeight - offset;
    CGFloat width = self.orginWidth - offset * whpercent;
    if (offset < -1) {
        [self.animationTimer pauseTimer];
        self.cycleScrollView.hidden = YES;
        self.stretchImageView.hidden = NO;
        self.stretchImageView.image = self.cycleCarouselArray[self.currentPageIndex];
        self.stretchImageView.frame = CGRectMake(offset, offset, width, height);
    } else {
        [self.animationTimer resumeTimerAfterTimeInterval:2];
        self.cycleScrollView.hidden = NO;
        self.stretchImageView.hidden = YES;
        self.stretchImageView.frame = CGRectZero;
    }
}

@end
