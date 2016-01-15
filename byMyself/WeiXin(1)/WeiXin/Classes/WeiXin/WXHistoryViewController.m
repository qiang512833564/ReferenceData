//
//  WXHistoryViewController.m
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-20.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import "WXHistoryViewController.h"
#import "AppDelegate.h"


@interface WXHistoryViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;//网络指标器

@end

@implementation WXHistoryViewController


-(void)viewDidLoad{
    [super viewDidLoad];
 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(autoLoginStatus:) name:WXAutoLoginStatusNotification object:nil];
    
}
/*
 1.开始连接服务器
 2.连接失败
 3.登录成功
 4.登录失败
 */
-(void)autoLoginStatus:(NSNotification *)noti{

    dispatch_async(dispatch_get_main_queue(), ^{
        int  type = [noti.userInfo[@"type"] intValue];
        //self.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",type];
        switch (type) {
            case XMPPResultTypeConnecting:// 1.开始连接服务器
                [self.indicator startAnimating];
                break;
            case XMPPResultTypeNetError:// 2.连接失败
                [self.indicator stopAnimating];
                break;
                
            case XMPPResultTypeLoginSuccess:// 3.登录成功
                [self.indicator stopAnimating];
                break;
            case XMPPResultTypeLoginFailure:// 4.登录失败
                [self.indicator stopAnimating];
                break;
        }

    });
    
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
