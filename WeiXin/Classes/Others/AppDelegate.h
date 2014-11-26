//
//  AppDelegate.h
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-18.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPPFramework.h"

#define xmppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

//typedef enum {
//    XMPPResultTypeConnecting,//连接中....
//    XMPPResultTypeLoginSuccess,//登录成功
//    XMPPResultTypeLoginFailure,//登录失败
//    XMPPResultTypeNetError,//网络不给力
//    XMPPResultTypeRegisterSuccess,//注册成功
//    XMPPResultTypeRegisterFailure,//注册失败
//}XMPPResultType;
//
//typedef void (^ResultBlock)(XMPPResultType type);
//
//
////微信自动登录状态通知
//static NSString *WXAutoLoginStatusNotification = @"WXAutoLoginStatusNotification";


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

////是否要执行注册操作 YES 为注册 NO 为登录
//@property(nonatomic,assign,getter=isUserRegister)BOOL userRegister;
//
///**
// 用户登录 登录结果以block的方式返回
// */
//-(void)userLoginWithResultBlock:(ResultBlock)resultBlock;
//
//
///**
// 用户注册 注册结果以block的方式返回
// */
//-(void)userRegisterWithResultBlock:(ResultBlock)resultBlock;
//
//
///**
// 用户注销
// */
//-(void)userLogout;
//
//// 核心通讯类
//@property(nonatomic,strong,readonly)XMPPStream *xmppStream;
//
////模块
//// 自动连接模块
//@property(nonatomic,strong)XMPPReconnect *reconnect;
//
//// 电子名片模块
//@property(nonatomic,strong,readonly)XMPPvCardTempModule *vCardModule;
//
//
//// 电子名片数据存储
//@property(nonatomic,strong,readonly)XMPPvCardCoreDataStorage *vCardStorage;
//
//// 电子名片头像模块"['ævətɑː(r)]"
//@property(nonatomic,strong,readonly)XMPPvCardAvatarModule *vCardAvatarModule;
//
//// 花名山模块
//@property(nonatomic,strong,readonly)XMPPRoster *roster;
//// 花名册数据存储
//@property(nonatomic,strong,readonly)XMPPRosterCoreDataStorage *rosterStorage;
//
////消息模块
//@property(nonatomic,strong,readonly)XMPPMessageArchiving *msgArchiving;
//@property(nonatomic,strong,readonly)XMPPMessageArchivingCoreDataStorage *msgStorage;

@end

