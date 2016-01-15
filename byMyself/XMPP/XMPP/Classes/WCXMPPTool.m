//
//  WCXMPPTool.m
//  XMPP
//
//  Created by lizhongqiang on 15/9/26.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "WCXMPPTool.h"

/*
 用户登录流程
 1.初始化XMPPStream
 
 2.连接服务器（传一个jid）
 
 3.连接成功，接着发送密码
 
 //默认登录成功是不在线的
 4.发送一个‘在线消息’给服务器-》可以通知其它用户该用户上线
 */
@interface WCXMPPTool ()<XMPPStreamDelegate>
{
    XMPPStream *_xmppStream;//与服务器交互的核心类
    
    XMPPResultBlock _resultBlock;
    
    
    XMPPvCardAvatarModule *_avator;//电子名片的头像模块
   
}
//初始化XMPPStream
- (void)setupStream;

//释放资源
- (void)teardownStream;

//连接到服务器（jid）
- (void)connectToHost;
//连接成功后，发送密码
- (void)sendPwdToHost;
//发送在线消息给服务器
- (void)sendOnline;
//发送离线消息
- (void)sendOffline;
//与服务器断开连接
- (void)disconnectFromHost;

@end

@implementation WCXMPPTool
singleton_m(WCXMPPTool)
#pragma mark - 私有方法
- (void)setupStream{
    //创建XMPPStream对象
    _xmppStream = [[XMPPStream alloc]init];
#pragma mark -- 所有的模块都必须激活
    //添加XMPP模块
    //1.添加电子名片模块
    _vCardStorage = [XMPPvCardCoreDataStorage sharedInstance];
    _vCard = [[XMPPvCardTempModule alloc]initWithvCardStorage:_vCardStorage];
    //激活
    [_vCard activate:_xmppStream];
    
    //电子名片模块还会配置“头像模块”一起使用
    //2.添加 头像模块
    _avator = [[XMPPvCardAvatarModule alloc]initWithvCardTempModule:_vCard];
    [_avator activate:_xmppStream];
    
    //3.添加花名册模块
    _rosterStorage = [[XMPPRosterCoreDataStorage alloc]init];
    
    _roster = [[XMPPRoster alloc]initWithRosterStorage:_rosterStorage];
    
    [_roster activate:_xmppStream];
    
    //设置代理
#warning     - 所有的代理方法都将在子线程被调用
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
}
- (void)connectToHost
{
    if(!_xmppStream){
        [self setupStream];
    }
    //1.设置jid
    //resource用于用户客户端设备登录的类型
    
    
    XMPPJID *myjid = nil;
    WCAccount *account = [WCAccount shareAccount];
    if(self.isRegisterOperation == NO)
    {
       NSString *username = [WCAccount shareAccount].loginUser;
       //登录jid
       myjid = [XMPPJID jidWithUser:username domain:account.domain resource:@"iphone"];
    }
    if(self.isRegisterOperation == YES)
    {
        NSString *registerUser = [WCAccount shareAccount].registerUser;
       //注册jid
        myjid = [XMPPJID jidWithUser:registerUser domain:account.domain resource:nil];
    }
     _xmppStream.myJID = myjid;
    //2.设置主机地址
    _xmppStream.hostName = account.host;
    //3.设置端口号(默认就是5222，可以不用设置)
    _xmppStream.hostPort = account.post;
    
    WCLog(@"发起连接");
    //4.发送连接
    NSError *error= nil;
    //缺少必要的参数，就会连接失败？没有jid
    [_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error];
    if(error)
    {
        WCLog(@"%@",error);
    }
    else{
        WCLog(@"链接成功");
    }
}
-(void)sendPwdToHost
{
    NSError *error;
    NSString *password = [WCAccount shareAccount].loginPwd;
    [_xmppStream authenticateWithPassword:password error:&error];
    if(error)
    {
        WCLog(@"%@",error);
    }
}
- (void)sendOnline
{
    XMPPPresence *presence = [XMPPPresence presence];
    WCLog(@"%@",presence);
    [_xmppStream sendElement:presence];
}
- (void)sendOffline
{
    XMPPPresence *offline = [XMPPPresence presenceWithType:@"unavailable"];
    [_xmppStream sendElement:offline];
}
- (void)disconnectFromHost
{
    [_xmppStream disconnect];
}
#pragma mark -XMPPStream的代理方法
//连接成功后调用
-(void)xmppStreamDidConnect:(XMPPStream *)sender
{
    WCLog(@"连接建立成功");
    if(self.isRegisterOperation){//注册
        
        NSError *error = nil;
        NSString *registerString = [WCAccount shareAccount].registerPwd;
        [_xmppStream registerWithPassword:registerString error:&error];
        if(error)
        {
            WCLog(@"%@",error);
        }
    }else
    {//登录
      [self sendPwdToHost];
    }
}
//与服务器断开连接
- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    WCLog(@"与服务器断开连接%@",error);
}
//登陆成功
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    WCLog(@"登陆成功");
    [self sendOnline];
    
    //回调resultBlock
    if(_resultBlock){
        _resultBlock(XMPPResultTypeLoginSucess);
        _resultBlock = nil;
    }
}
//登录失败
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    WCLog(@"登陆失败%@",error);
    if(_resultBlock)
    {
        _resultBlock(XMPPResultTypeLoginFailure);
        
        _resultBlock = nil;
    }
}
- (void)xmppStreamDidRegister:(XMPPStream *)sender
{
    WCLog(@"注册成功");
    if(_resultBlock){
        _resultBlock(XMPPResultTypeRegisterSucess);
    }
}
- (void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error
{
    WCLog(@"注册失败%@",error);
    if(_resultBlock){
        _resultBlock(XMPPResultTypeRegisterFailure);
    }
}
#pragma mark -公共方法
#pragma mark - 用户登录
- (void)xmppLogin:(XMPPResultBlock)resultBlock
{
    //不管什么情况，把以前的链接断开
    [_xmppStream disconnect];
    
    _resultBlock = resultBlock;
    //用户登录流程
    //1.初始化XMPPStream
    //2.链接服务器
    //3.连接成功，接着发送密码r
    [self connectToHost];
    
}
#pragma mark -- 用户注销
- (void)xmppLogout
{
    //1.发送离线消息给服务器
    [self sendOffline];
    
    //2.断开与服务器的连接
    [self disconnectFromHost];
}
#pragma mark -- 用户注册
- (void)xmppRegister:(XMPPResultBlock)resultBlock
{
    //注册步骤
    ////1.发送‘注册jid’给服务器，请求一个长连接
    ////2.连接成功，发送注册密码
    
    _resultBlock = resultBlock;
    
    //去除之前的连接
    [_xmppStream disconnect];

    [self connectToHost];
    
}
#pragma mark -- 程序退出的时候，释放资源
- (void)dealloc
{
    [self teardownStream];
}
- (void)teardownStream
{
    //移除代理
    [_xmppStream removeDelegate:self];
    //取消模块
    [_vCard deactivate];
    [_avator deactivate];
    [_roster deactivate];
    //断开连接
    [_xmppStream disconnect];
    //清空资源
    
    _xmppStream = nil;
    _vCard = nil;
    _vCardStorage = nil;
    _avator = nil;
    _roster = nil;
    _rosterStorage = nil;
}
@end
