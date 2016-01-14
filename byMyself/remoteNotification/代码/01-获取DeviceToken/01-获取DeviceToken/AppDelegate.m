//
//  AppDelegate.m
//  01-获取DeviceToken
//
//  Created by apple on 14/11/10.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if ([UIDevice currentDevice].systemVersion.doubleValue <= 8.0) {
        // 不是iOS8
        UIRemoteNotificationType type = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert;
        // 当用户第一次启动程序时就获取deviceToke
        // 该方法在iOS8以及过期了
        // 只要调用该方法, 系统就会自动发送UDID和当前程序的Bunle ID到苹果的APNs服务器
        [application registerForRemoteNotificationTypes:type];
    }else
    {
        // iOS8
        UIUserNotificationType type = UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        // 注册通知类型
        [application registerUserNotificationSettings:settings];
        
        // 申请试用通知
        [application registerForRemoteNotifications];
    }
    
    // 1.取出数据
    NSDictionary *userInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if (userInfo) {
        static int count = 0;
        count++;
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 40, 200, 200);
        label.numberOfLines = 0;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:11];
        label.backgroundColor = [UIColor orangeColor];
        label.text = [NSString stringWithFormat:@" %@ \n %d", userInfo, count];
        [self.window.rootViewController.view addSubview:label];
    }
    

    return YES;
}

/**
 *  获取到用户对应当前应用程序的deviceToken时就会调用
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"%@", deviceToken);
    // <47e58207 31340f18 ed83ba54 f999641a 3d68bc7b f3e2db29 953188ec 7d0cecfb>
    // <286c3bde 0bd3b122 68be655f 25ed2702 38e31cec 9d54da9f 1c62325a 93be801e>
}

/*
 ios7以前苹果支持多任务, iOS7以前的多任务是假的多任务
 而iOS7开始苹果才真正的推出了多任务
 */
// 接收到远程服务器推送过来的内容就会调用
// 注意: 只有应用程序是打开状态(前台/后台), 才会调用该方法
/// 如果应用程序是关闭状态会调用didFinishLaunchingWithOptions
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    /*
     如果应用程序在后台 , 只有用户点击了通知之后才会调用
     如果应用程序在前台, 会直接调用该方法
     即便应用程序关闭也可以接收到远程通知
     */
    NSLog(@"%@", userInfo);
    
//    static int count = 0;
//    count++;
//    UILabel *label = [[UILabel alloc] init];
//    label.frame = CGRectMake(0, 250, 200, 200);
//    label.numberOfLines = 0;
//    label.textColor = [UIColor whiteColor];
//    label.text = [NSString stringWithFormat:@"%@ \n %d", userInfo, count];
//    label.font = [UIFont systemFontOfSize:11];
//    label.backgroundColor = [UIColor grayColor];
//    [self.window.rootViewController.view addSubview:label];
}

//接收到远程服务器推送过来的内容就会调用
// ios7以后用这个处理后台任务接收到得远程通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    /*
     UIBackgroundFetchResultNewData, 成功接收到数据
     UIBackgroundFetchResultNoData, 没有;接收到数据
     UIBackgroundFetchResultFailed 接收失败
     
     */
//    NSLog(@"%s",__func__);
//    NSLog(@"%@", userInfo);
    
    NSNumber *contentid =  userInfo[@"content-id"];
    if (contentid) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 250, 200, 200);
        label.numberOfLines = 0;
        label.textColor = [UIColor whiteColor];
        label.text = [NSString stringWithFormat:@"%@", contentid];
        label.font = [UIFont systemFontOfSize:30];
        label.backgroundColor = [UIColor grayColor];
        [self.window.rootViewController.view addSubview:label];
        //注意: 在此方法中一定要调用这个调用block, 告诉系统是否处理成功.
        // 以便于系统在后台更新UI等操作
        completionHandler(UIBackgroundFetchResultNewData);
    }else
    {
        completionHandler(UIBackgroundFetchResultFailed);
    }
    
}
@end
