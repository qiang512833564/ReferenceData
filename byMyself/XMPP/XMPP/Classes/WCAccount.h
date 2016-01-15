//
//  WCAccount.h
//  XMPP
//
//  Created by lizhongqiang on 15/9/26.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCAccount : NSObject
/*
 用户登录的用户名
 */
@property (nonatomic,copy)NSString *loginUser;
/*
 用户登录的密码
 */
@property (nonatomic, copy)NSString *loginPwd;
//判断用户是否登陆
@property (nonatomic, assign,getter=isLogin)BOOL login;


/*
 用户注册的用户名
 */
@property (nonatomic,copy)NSString *registerUser;
/*
 用户注册的密码
 */
@property (nonatomic, copy)NSString *registerPwd;

+ (instancetype)shareAccount;
//保存最新的登录用户信息到沙盒里去
- (void)saveToSandBox;

@property (nonatomic, copy,readonly)NSString *domain;
@property (nonatomic, copy,readonly)NSString *host;
@property (nonatomic, assign)int post;
@end
