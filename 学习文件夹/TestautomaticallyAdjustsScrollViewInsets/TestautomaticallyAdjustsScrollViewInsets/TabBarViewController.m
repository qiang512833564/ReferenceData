//
//  TabBarViewController.m
//  TestautomaticallyAdjustsScrollViewInsets
//
//  Created by lizhongqiang on 16/3/14.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "TabBarViewController.h"
#import "ViewController.h"
#import "SecondViewController.h"
@interface TabBarViewController ()
@property (nonatomic, strong)ViewController *firstVC;
@property (nonatomic, strong)SecondViewController *secondVC;
@property (nonatomic, strong)ViewController *thirdVC;
@property (nonatomic, strong)ViewController *forthVC;
@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setBackgroundImage:[self backImage] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[self backImage]];
    
    self.viewControllers = @[self.firstVC,self.secondVC,self.thirdVC,self.forthVC];
    
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSLog(@"%ld--%ld",self.selectedIndex,item.tag);
    if (self.selectedIndex == 1) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }else if(self.selectedIndex == 0){
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
}
- (UIImage *)backImage{
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddRect(ctx, CGRectMake(0, 0, 1, 1));
    CGContextSetFillColorWithColor(ctx, [UIColor clearColor].CGColor);
    CGContextDrawPath(ctx, kCGPathFill);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (ViewController *)firstVC{
    if (_firstVC == nil) {
        _firstVC = [[ViewController alloc]init];
        _firstVC.title = @"第一个";
    }
    return _firstVC;
}
- (SecondViewController *)secondVC{
    if (_secondVC == nil) {
        _secondVC = [[SecondViewController alloc]init];
        _secondVC.title = @"第二个";
    }
    return _secondVC;
}
- (ViewController *)thirdVC{
    if (_thirdVC == nil) {
        _thirdVC = [[ViewController alloc]init];
        _thirdVC.title = @"第三个";
    }
    return _thirdVC;
}
- (ViewController *)forthVC{
    if (_forthVC == nil) {
        _forthVC = [[ViewController alloc]init];
        _forthVC.title = @"第一个";
    }
    return _forthVC;
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
