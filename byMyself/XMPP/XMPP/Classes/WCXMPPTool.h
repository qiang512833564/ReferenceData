//
//  WCXMPPTool.h
//  XMPP
//
//  Created by lizhongqiang on 15/9/26.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"
typedef enum {
    XMPPResultTypeLoginSucess,
    XMPPResultTypeLoginFailure,
    XMPPResultTypeRegisterSucess,
    XMPPResultTypeRegisterFailure,
}XMPPResultType;

typedef void (^XMPPResultBlock)(XMPPResultType);
@interface WCXMPPTool : NSObject

singleton_h(WCXMPPTool)
/*
 标识  连接到服务器时到底是登录连接还是注册连接
 NO   代表登录操作
 YES  代表注册操作 */
@property (assign,nonatomic,getter=isRegisterOperation)BOOL registerOperation;

@property (nonatomic, strong, readonly)XMPPvCardTempModule *vCard;//电子名片模块
@property (nonatomic, strong, readonly)XMPPvCardCoreDataStorage *vCardStorage;//电子名片数据存储

@property (nonatomic, strong, readonly)XMPPRoster *roster;//花名册
@property (nonatomic, strong, readonly)XMPPRosterCoreDataStorage *rosterStorage;//花名册数据存储

- (void)xmppLogin:(XMPPResultBlock)resultBlock;

- (void)xmppRegister:(XMPPResultBlock)resultBlock;

- (void)xmppLogout;

@end
