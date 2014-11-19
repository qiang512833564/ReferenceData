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
    //设置导航条背景
    UINavigationBar *navBar = [UINavigationBar appearance];
    UIImage *image = [UIImage imageNamed:@"topbarbg_ios7"];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
