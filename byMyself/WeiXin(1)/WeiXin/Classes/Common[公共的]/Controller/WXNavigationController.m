//
//  WXNavigationController.m
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-18.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import "WXNavigationController.h"

@implementation WXNavigationController


+(void)initialize{
    [self setupTheme];
}

+(void)setupTheme{
    //设置导航条背景
    UINavigationBar *navBar = [UINavigationBar appearance];
    UIImage *image = [UIImage imageNamed:@"topbarbg_ios7"];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    // 设置全局状态栏样式
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    // 设置导航条标题字体样式
    NSMutableDictionary *titleAtt = [NSMutableDictionary dictionary];
    
    titleAtt[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    titleAtt[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [navBar setTitleTextAttributes:titleAtt];
    
    // 返回按钮的样式 白色
    [navBar setTintColor:[UIColor whiteColor]];
    
    // 设置导航条item的样式
    NSMutableDictionary *itemAtt = [NSMutableDictionary dictionary];
    
    itemAtt[NSFontAttributeName] = [UIFont boldSystemFontOfSize:15];
    itemAtt[NSForegroundColorAttributeName] = [UIColor whiteColor];
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    [barItem setTitleTextAttributes:itemAtt forState:UIControlStateNormal];
    
    

}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:YES];
}

@end
