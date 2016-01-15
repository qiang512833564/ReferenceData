//
//  WCAccount.m
//  XMPP
//
//  Created by lizhongqiang on 15/9/26.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "WCAccount.h"

#define kUserKey @"user"
#define kPwdKey @"pwd"
#define kLoginKey @"login"

static NSString *domain = @"liqiangqiang";
static NSString *host = @"127.0.0.1";
static int post = 5222;

@implementation WCAccount

+(instancetype)shareAccount
{
    return [[self alloc]init];
}
#pragma mark 分配内存创建对象
+ (instancetype)allocWithZone:(struct _NSZone *)zone{

    
    static WCAccount *account;//静态变量，从程序启动，到程序结束一直存在

    //为了线程安全
    //三个线程同时调用这个方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        {
            account = [super allocWithZone:zone];
            
            //从沙盒获取上次的用户登录信息
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            account.loginUser = [defaults objectForKey:kUserKey];
            account.loginPwd = [defaults objectForKey:kPwdKey];
            account.login = [defaults boolForKey:kLoginKey];
          
        }
    });
    return account;
}

- (void)saveToSandBox
{
    //保存user pwd login
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.loginUser forKey:kUserKey];
    [defaults setObject:self.loginPwd forKey:kPwdKey];
    [defaults setBool:self.isLogin forKey:kLoginKey];
    [defaults synchronize];//同步到磁盘上去
    
    //NSLog(@"%d----%@",[defaults boolForKey:kLoginKey],[defaults objectForKey:kUserKey]);
}
//服务器的域名
- (NSString *)domain
{
    return domain;
}
//服务器的主机
- (NSString *)host
{
    return host;
}
- (int)post
{
    return post;
}
@end
