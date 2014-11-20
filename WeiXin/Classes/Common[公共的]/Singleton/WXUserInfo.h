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
@property(nonatomic,copy)NSString *loginUser;//登录账号
@property(nonatomic,copy)NSString *loginPwd;//登录密码

/**
 数据保存到沙盒，保存运行内存与沙盒的数据同步
 */
-(void)synchronizeToSandBox;

@end
