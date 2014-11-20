//
//  AppDelegate.h
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-18.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    XMPPResultTypeLoginSuccess,//登录成功
    XMPPResultTypeLoginFailure,//登录失败
    XMPPResultTypeNetError//网络不给力
}XMPPResultType;

typedef void (^ResultBlock)(XMPPResultType type);

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


/**
 用户登录 登录结果以block的方式返回
 */
-(void)userLoginWithResultBlock:(ResultBlock)resultBlock;

@end

