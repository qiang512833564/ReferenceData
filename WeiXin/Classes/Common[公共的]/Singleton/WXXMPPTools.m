//
//  WXXMPPTools.m
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-26.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import "WXXMPPTools.h"

@interface WXXMPPTools ()<XMPPRosterDelegate,XMPPStreamDelegate>
//登录或者注册结果的回调block
@property(nonatomic,copy)ResultBlock resultBlock;
@end

@implementation WXXMPPTools
singleton_implementation(WXXMPPTools)

//+ (instancetype)sharedWXXMPPTools {
//    static WXXMPPTools *instance;
//    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        instance = [[self alloc] init];
//    });
//    return instance;
//}

#pragma mark -私有方法
#pragma mark 1 初始化XmppStream核心类
-(void)setupXmppStream{
    // 1.创建xmppStream对象
    _xmppStream = [[XMPPStream alloc] init];
    // 设置代理【所有跟服务交互后，返回结果通过代理方式通知】
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
    // 2.允许socket后台运行
    _xmppStream.enableBackgroundingOnSocket = YES;
    
    // 3.添加自动连接模块
    _reconnect = [[XMPPReconnect alloc] init];
    
    // 4.添加电子名片模块
    _vCardStorage = [XMPPvCardCoreDataStorage sharedInstance];
    _vCardModule = [[XMPPvCardTempModule alloc] initWithvCardStorage:_vCardStorage];
    
    // 5.添加电子名片头像模块
    _vCardAvatarModule = [[XMPPvCardAvatarModule alloc] initWithvCardTempModule:_vCardModule];
    
    // 6.添加花名册模块
    _rosterStorage = [[XMPPRosterCoreDataStorage alloc] init];
    _roster = [[XMPPRoster alloc] initWithRosterStorage:_rosterStorage];
    //_roster.autoAcceptKnownPresenceSubscriptionRequests = NO;
    [_roster addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
    // 7.花名册模块
    _msgStorage = [[XMPPMessageArchivingCoreDataStorage alloc] init];
    _msgArchiving = [[XMPPMessageArchiving alloc] initWithMessageArchivingStorage:_msgStorage];
    
    // 激活模块
    [_reconnect             activate:_xmppStream];
    [_vCardModule           activate:_xmppStream];
    [_vCardAvatarModule     activate:_xmppStream];
    [_roster                activate:_xmppStream];
    [_msgArchiving          activate:_xmppStream];
    
    
}

-(void)teardownXmppStream{
    // 1.移除代理
    [_xmppStream removeDelegate:self];
    
    // 2.停止模块 并 清空模块
    [_reconnect         deactivate];//自动连接
    [_vCardModule       deactivate];//电子名片
    [_vCardAvatarModule deactivate];//电子名片头像模块
    [_roster            deactivate];
    [_msgArchiving      deactivate];
    // 3.断开连接
    [_xmppStream disconnect];
    
    _reconnect = nil;
    _vCardStorage = nil;
    _vCardModule = nil;
    _vCardAvatarModule = nil;
    _rosterStorage = nil;
    _roster = nil;
    _msgArchiving = nil;
    _msgStorage = nil;
    _xmppStream = nil;
}

#pragma mark 2 连接到服务器【连接服务器已经传送了账号】
-(void)connectToServer{
    WXLog(@"连接服务器");
    // 如果xmppStream没有值，创建对象
    if (!_xmppStream) {
        [self setupXmppStream];
    }
    
    // 获取用户信息单例对象
    WXUserInfo *userInfo = [WXUserInfo sharedWXUserInfo];
    
    // 提交服务器前
    // 1.设置xmppStream要交互的主机地址与端口
    //    self.xmppStream.hostName = userInfo.xmppDomain;
    _xmppStream.hostName = userInfo.xmppHostIP;
    // 默认是5222 可以不用设置
    _xmppStream.hostPort = 5222;
    
    
    // 2.设置登录的账号
    XMPPJID *myJid = nil;
    if (!self.isUserRegister) {
        myJid = [XMPPJID jidWithUser:userInfo.loginUserName domain:userInfo.xmppDomain resource:nil];
    }else{
        // 设置注册账号
        myJid = [XMPPJID jidWithUser:userInfo.registerUserName domain:userInfo.xmppDomain resource:nil];
    }
    
    _xmppStream.myJID = myJid;
    
    /**
     Error Domain=XMPPStreamErrorDomain Code=1 "Attempting to connect while already connected or connecting." UserInfo=0x7be9ac40 {NSLocalizedDescription=Attempting to connect while already connected or connecting.
     */
    // 如果之前的连接过，断开连接，否则用新的用户名连接时，会报连接已存在的错误
    if (_xmppStream.isConnected) {
        [_xmppStream disconnect];
    }
    
    // 3.执行请求连接服务器
    NSError *error = nil;
    [_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error];
    WXLog(@"%@",error);
    
    // 通知正在连接中
    [self postNotificationWithResultType:XMPPResultTypeConnecting];
}

#pragma mark 3 发送登录密码到服务器【代理返回连接成功才执行此步骤】
-(void)sendLoginPwdToServer{
    WXLog(@"发送登录密码到服务器");
    WXUserInfo *userInfo = [WXUserInfo sharedWXUserInfo];
    NSError *error = nil;
    [_xmppStream authenticateWithPassword:userInfo.loginPwd error:&error];
    
    WXLog(@"%@",error);
    
    
}
#pragma mark 4 通知用户上线
-(void)notifyUserOnline{
    WXLog(@"通知用户上线");
    XMPPPresence *presence = [XMPPPresence presence];
    [_xmppStream sendElement:presence];
}

#pragma mark  5 通知用户下线
-(void)notifyUserOffline{
    WXLog(@"通知用户下线");
    XMPPPresence *offline = [XMPPPresence presenceWithType:@"unavailable"];
    [_xmppStream sendElement:offline];
}

#pragma mark 发送注册密码到服务器
-(void)sendRegisterPwdToServer{
    WXUserInfo *userInfo = [WXUserInfo sharedWXUserInfo];
    NSError *error = nil;
    [_xmppStream registerWithPassword:userInfo.registerPwd error:&error];
    
    WXLog(@"发送注册密码到服务器 %@",error);
}

#pragma mark  发送登录状态的通知
-(void)postNotificationWithResultType:(XMPPResultType)type{
    NSDictionary *userInfo = @{@"type":@(type)};
    [[NSNotificationCenter defaultCenter] postNotificationName:WXAutoLoginStatusNotification object:nil userInfo:userInfo];
}

#pragma mark -公共方法
#pragma mark 用户登录
-(void)userLoginWithResultBlock:(ResultBlock)resultBlock{
    
    // 赋值给成员属性
    self.resultBlock = resultBlock;
    
    // 连接到服务器，成功后，发送密码授权
    [self connectToServer];
}

#pragma mark 用户注册
-(void)userRegisterWithResultBlock:(ResultBlock)resultBlock{
    // 赋值给成员属性
    self.resultBlock = resultBlock;
    
    // 连接到服务器，成功后，发送密码授权
    [self connectToServer];
}

#pragma mark 用户注销
-(void)userLogout{
    WXLog(@"用户注销");
    // 0.通知用户下线
    [self notifyUserOffline];
    
    // 1.断开连接
    [_xmppStream disconnect];
    
    // 2.回到登录界面
    [UIStoryboard showInitialVCWithName:@"Login"];
    
    // 3.取消登录状态
    [WXUserInfo sharedWXUserInfo].login = NO;
    [[WXUserInfo sharedWXUserInfo] synchronizeToSandBox];
}

#pragma mark -XMPPStream代理

#pragma mark 客户端与连接主机成功
-(void)xmppStreamDidConnect:(XMPPStream *)sender{
    WXLog(@"与服务器连接成功");
    if (!self.isUserRegister) {
        // 连接成功后 发送密码到服务器，进行授权验证
        [self sendLoginPwdToServer];
    }else{
        // 连接成功后 发送注册密码到服务器
        [self sendRegisterPwdToServer];
    }
    
}

#pragma mark 客户端断开与主机的连接
-(void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error{
    WXLog(@"与服务器断开连接");
    if (error) {
        // 通知连接失败
        [self postNotificationWithResultType:XMPPResultTypeNetError];
    }
}

#pragma mark 授权失败
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    WXLog(@"授权失败%@",error);
    if (self.resultBlock) {
        _resultBlock(XMPPResultTypeLoginFailure);
    }
    
    // 通知登录成功
    [self postNotificationWithResultType:XMPPResultTypeLoginFailure];
}

#pragma mark 授权成功
-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    WXLog(@"授权成功【即成功登录】");
    
    [self notifyUserOnline];
    
    if (self.resultBlock) {
        _resultBlock(XMPPResultTypeLoginSuccess);
    }
    
    // 通知登录成功
    [self postNotificationWithResultType:XMPPResultTypeLoginSuccess];
    
}
#pragma mark 注册成功
-(void)xmppStreamDidRegister:(XMPPStream *)sender{
    WXLog(@"注册成功");
    if (self.resultBlock) {
        _resultBlock(XMPPResultTypeRegisterSuccess);
    }
}


#pragma mark 注册失败
-(void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error{
    WXLog(@"注册失败 %@",error);
    if (self.resultBlock) {
        _resultBlock(XMPPResultTypeRegisterFailure);
    }
}

-(void)xmppStream:(XMPPStream *)sender didSendMessage:(XMPPMessage *)message{
    WXLog(@"%@",message);
}

-(void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message{
    
    // 正常显示信息
    if([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive){
        
        NSLog(@"%@",message);
    }else{
        // 本地通知
        UILocalNotification *localNot = [[UILocalNotification alloc] init];
        localNot.fireDate = [NSDate date];
        localNot.alertBody = [NSString stringWithFormat:@"%@\n%@",message.from.bare,message.body];
        localNot.soundName = @"default";
        [[UIApplication sharedApplication] scheduleLocalNotification:localNot];
    }
    
}

//
//-(void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence{
//    WXLog(@"%@",presence.type);
//    // 接收好友请求
//    if ([presence.type isEqualToString:@"subscribe"]) {
//        [_roster acceptPresenceSubscriptionRequestFrom:presence.from andAddToRoster:YES];
//    }
//    
//}


#pragma mark xmppRoster代理
//-(void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence{
//    WXLog(@"%@",presence);
//    if ([presence.type isEqualToString:@"subscribe"]) {
//        [_roster acceptPresenceSubscriptionRequestFrom:presence.from andAddToRoster:YES];
//    }
//
//}

-(void)dealloc{
    [self teardownXmppStream];
}

@end
