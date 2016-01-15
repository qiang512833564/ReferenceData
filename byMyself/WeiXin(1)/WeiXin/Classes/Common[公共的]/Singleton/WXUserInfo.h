//
//  WXUserInfo.h
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-20.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface WXUserInfo : NSObject
singleton_interface(WXUserInfo);


@property(nonatomic,copy,readonly)NSString *xmppDomain;//xmpp服务器域名
@property(nonatomic,copy,readonly)NSString *xmppHostIP;//xmpp服务器IP
@property(nonatomic,copy)NSString *loginUserName;//登录账号
@property(nonatomic,copy)NSString *loginPwd;//登录密码
@property(nonatomic,assign,getter=isLogin)BOOL login;//登录是否成功
@property(nonatomic,copy,readonly)NSString *userJid;

@property(nonatomic,copy)NSString *registerUserName;//注册账号
@property(nonatomic,copy)NSString *registerPwd;//注册密码

/**
 数据保存到沙盒，保存运行内存与沙盒的数据同步
 */
-(void)synchronizeToSandBox;

/* 
 *程序一启动时从沙盒获取数据
 */
-(void)loadDataFromSandBox;

@end
