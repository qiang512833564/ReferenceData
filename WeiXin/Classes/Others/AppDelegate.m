//
//  AppDelegate.m
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-18.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import "AppDelegate.h"
#import "WXUserInfo.h"@interface AppDelegate ()




@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    self.window.backgroundColor = [UIColor whiteColor];
    // 配置xmpp的日志
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
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
