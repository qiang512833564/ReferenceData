//
//  AppDelegate.m
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-18.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import "AppDelegate.h"
#import "WXUserInfo.h"

/*
 1 初始化XmppStream核心类
 2 连接到服务器【连接服务器已经传送了账号】
 3 发送登录密码到服务器【代理返回连接成功才执行此步骤】
 4 登录成功 通知用户上线
 5 登录成功 进入主界面
 6 登录失败提示用户名密码错误
 */

@interface AppDelegate ()<XMPPStreamDelegate>

/**
 1 初始化XmppStream核心类
 */

-(void)setupXmppStream;

/**
 2 连接到服务器【连接服务器已经传送了账号】
 */
-(void)connectToServer;

/**
 3 发送登录密码到服务器【代理返回连接成功才执行此步骤】
 */
-(void)sendLoginPwdToServer;

/**
  发送注册密码到服务器【代理返回连接成功才执行此步骤】
 */
-(void)sendRegisterPwdToServer;

/**
 4 登录成功 通知用户上线
 */
-(void)notifyUserOnline;

/**
 5 通知用户下线
 */
-(void)notifyUserOffline;

/**
 * 释放xmppStream相关资源
 */

-(void)teardownXmppStream;
#pragma mark 成员属性


//登录或者注册结果的回调block
@property(nonatomic,copy)ResultBlock resultBlock;





@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    self.window.backgroundColor = [UIColor whiteColor];
    // 配置xmpp的日志
    //[DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    // 程序启动时调用一次即可
    [[WXUserInfo sharedWXUserInfo] loadDataFromSandBox];
    
    if([WXUserInfo sharedWXUserInfo].isLogin){
        
#warning 强调使用[UIStoryboard showInitialVCWithName:]方法时，里面的application无值
        self.window.rootViewController = [UIStoryboard initialVCWithName:@"Main"];
        //[self connectToServer];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 自动登录服务器
            [[WXXMPPTools sharedWXXMPPTools] userLoginWithResultBlock:nil];
        });
        
    }
    
    // 注册通知
    if ([UIDevice currentDevice].systemVersion.doubleValue >= 8.0) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
    return YES;
}


@end
