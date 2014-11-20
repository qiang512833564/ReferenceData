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
static NSString *xmppDomain = @"teacher.local";
@implementation WXUserInfo
singleton_implementation(WXUserInfo);


-(NSString *)xmppDomain{
    return xmppDomain;
}

-(void)synchronizeToSandBox{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.loginUser forKey:UserNameKey];
    [defaults setObject:self.loginPwd forKey:PwdKey];
    [defaults synchronize];
}

@end
