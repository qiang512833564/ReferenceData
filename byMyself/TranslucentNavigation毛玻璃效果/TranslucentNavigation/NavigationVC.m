//
//  NavigationVC.m
//  TranslucentNavigation
//
//  Created by lizhongqiang on 15/7/9.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "NavigationVC.h"

@interface NavigationVC ()

@end

@implementation NavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.navigationBar.translucent = NO;
#if 1
    
    [self.navigationBar setBackgroundImage:[self createImageByColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];//[UIColor colorWithRed:179/2.f green:179/2.f blue:179/2.f alpha:0.3]]
    
   
   
   

    
    
    //[self.navigationBar setShadowImage:[self createImageByColor:[UIColor clearColor]]];//[UIColor colorWithWhite:1 alpha:0.38]//设置的是navigationBar下面的一条横线颜色图片
#endif
}
- (UIImage *)createImageByColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1.f, 1.f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    
    CGContextFillRect(ctx, rect);
    
    CGContextDrawPath(ctx, kCGPathFill);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
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
