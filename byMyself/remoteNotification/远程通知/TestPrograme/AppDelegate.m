//
//  AppDelegate.m
//  TestPrograme
//
//  Created by lizhongqiang on 15/10/13.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UIUserNotificationType type=UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound ;
    UIUserNotificationSettings * settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
    //注册通知类型
    [application registerUserNotificationSettings:settings];
    //申请试用通知
    [application registerForRemoteNotifications];
    return YES;
}
/*
 获取到用户对应当前应用程序的deviceToken时就会调用
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{//<9a468880 c088d787 b1ccd687 9abafd5f b217e246 ab6f292b 4f17ff2c 15b138ce>
    NSLog(@"%@",deviceToken);
}
//接收到远程服务器推送过来的内容，就会调用
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"%@",userInfo);
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
