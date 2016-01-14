//
//  ViewController.m
//  UIPageViewController
//
//  Created by lizhongqiang on 15/7/23.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"
#import "MoreViewController.h"

@interface ViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property (nonatomic, strong)UIPageViewController *pageViewController;
//UIPageViewController中有两个常用的属性：双面显示（doubleSided)和书脊位置（spineLocation）。
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)MoreViewController *moreVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createContentPages];
    // Do any additional setup after loading the view, typically from a nib.
    NSDictionary *options = @{UIPageViewControllerOptionInterPageSpacingKey:@(30),UIPageViewControllerOptionSpineLocationKey:@(UIPageViewControllerSpineLocationMin)};
    /*
         UIpageViewControllerSpineLocationMin 的书脊在左边。
         UIpageViewControllerSpineLocationMid 书脊被放置在两个视图控制器的中间,要求一页要有两个视图控制器。
         UIpageViewControllerSpineLocationMax 书脊在屏幕右端
     只有是这种模式UIPageViewControllerTransitionStylePageCurl时，UIPageViewControllerOptionSpineLocationKey设置才有效
     只有是这种模式UIPageViewControllerTransitionStyleScroll时，UIPageViewControllerOptionInterPageSpacingKey设置才有效,对应的值是两页之间的空隙，可以根据自己意愿设置
     */
    _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    _pageViewController.dataSource = self;
    _pageViewController.delegate = self;
    _pageViewController.view.backgroundColor = [UIColor purpleColor];
    
    
    MoreViewController *moreVC = [self viewControllerAtIndex:0];
    _moreVC = moreVC;
    NSArray *viewControllers = [NSArray arrayWithObject:moreVC];
    
    [_pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        /*
         navigationOrientation设定了翻页方向，UIPageViewControllerNavigationDirection枚举类型定义了以下两种翻页方式。
         
         UIPageViewControllerNavigationDirectionForward：从左往右（或从下往上）；
         
         UIPageViewControllerNavigationDirectionReverse：从右向左（或从上往下）
         */
    }];
    
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    
    [_pageViewController.view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if([obj isKindOfClass:[UIPageControl class]])
        {
            UIPageControl *pageCtrl = (UIPageControl *)obj;
            pageCtrl.pageIndicatorTintColor = [UIColor redColor];
            pageCtrl.currentPageIndicatorTintColor = [UIColor blueColor];
//            pageCtrl.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 200, [UIScreen mainScreen].bounds.size.width, 200);无效
        }
    }];
    
}

- (void)createContentPages
{
    _dataArray = [NSMutableArray array];
    for(int i=0; i<11; i++)
    {
        NSString *str = [NSString stringWithFormat:@"chapter:%d",i];
        [_dataArray addObject:str];
    }
}
// 得到相应的VC对象
- (MoreViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (([self.dataArray count] == 0) || (index >= [self.dataArray count])) {
        return nil;
    }
    // 创建一个新的控制器类，并且分配给相应的数据
    MoreViewController *dataViewController =[[MoreViewController alloc] init];
    dataViewController.view.backgroundColor = [UIColor whiteColor];
    dataViewController.dataObject =[self.dataArray objectAtIndex:index];
    return dataViewController;
}

// 根据数组元素值，得到下标值
- (NSUInteger)indexOfViewController:(MoreViewController *)viewController {
    return [self.dataArray indexOfObject:viewController.dataObject];
}
// 返回上一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    NSUInteger index = [self indexOfViewController:(MoreViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    // 返回的ViewController，将被添加到相应的UIPageViewController对象上。
    // UIPageViewController对象会根据UIPageViewControllerDataSource协议方法，自动来维护次序。
    // 不用我们去操心每个ViewController的顺序问题。
    return [self viewControllerAtIndex:index];
    
    
}

// 返回下一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSUInteger index = [self indexOfViewController:(MoreViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.dataArray count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
    
    
}
//UIPageViewControllerTransitionStyleScroll模式下，才会调用下面两个dataSource方法
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return _dataArray.count;
}
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    
}
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
