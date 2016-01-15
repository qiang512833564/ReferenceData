//
//  WXBaseLoginViewController.m
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-20.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import "WXBaseLoginViewController.h"
#import "AppDelegate.h"
#import "WXOtherLoginViewController.h"

@interface WXBaseLoginViewController ()

@end

@implementation WXBaseLoginViewController

-(void)login{
    // 键盘消失
    [self.view endEditing:YES];
    
    // 调用代理的登录方法
    [MBProgressHUD showMessage:@"正在登录.." toView:self.view];
    //AppDelegate *app = [UIApplication sharedApplication].delegate;
    [WXXMPPTools sharedWXXMPPTools].userRegister = NO;
    __weak typeof(self) selfVc = self;
    [[WXXMPPTools sharedWXXMPPTools] userLoginWithResultBlock:^(XMPPResultType type) {
        [selfVc handleResultType:type];
    }];

}

// 处理请求结果
-(void)handleResultType:(XMPPResultType)type{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view ];
        int myType = type;
        switch (myType) {
            case XMPPResultTypeLoginSuccess:
                [MBProgressHUD showSuccess:@"登录成功" toView:self.view ];
                
                // 模态窗口消失
                if ([self isKindOfClass:[WXOtherLoginViewController class]]) {
                     [self dismissViewControllerAnimated:NO completion:nil];
                }
               
                // 进到主界面
                [UIStoryboard showInitialVCWithName:@"Main"];
                
                // 登录成功
                [WXUserInfo sharedWXUserInfo].login = YES;
                // 保存登录信息到沙盒
                [[WXUserInfo sharedWXUserInfo] synchronizeToSandBox];
                break;
                
            case XMPPResultTypeLoginFailure:
                [MBProgressHUD showError:@"用户名或者密码不正确" toView:self.view];
                break;
        }
        
        WXLog(@"%d",type);
    });
}


@end
