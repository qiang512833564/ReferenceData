//
//  WXUserInfo.m
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-20.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import "WXUserInfo.h"
#define UserNameKey @"USER_NAME"
#define PwdKey @"PASSWORD"
#define LoginKey @"Login"
static NSString *xmppDomain = @"teacher.local";
//static NSString *xmppHostIP = @"192.168.95.103";
static NSString *xmppHostIP = @"127.0.0.1";
@implementation WXUserInfo
singleton_implementation(WXUserInfo);


-(NSString *)xmppDomain{
    return xmppDomain;
}

-(NSString *)xmppHostIP{
    return xmppHostIP;
}

-(NSString *)userJid{
    return [NSString stringWithFormat:@"%@@%@",self.loginUserName,xmppDomain];
}

-(void)synchronizeToSandBox{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.loginUserName forKey:UserNameKey];
    [defaults setObject:self.loginPwd forKey:PwdKey];
    [defaults setBool:self.login forKey:LoginKey];
    [defaults synchronize];
}

-(void)loadDataFromSandBox{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.loginUserName = [defaults objectForKey:UserNameKey];
    self.loginPwd = [defaults objectForKey:PwdKey];
    self.login = [defaults boolForKey:LoginKey];
}

@end
