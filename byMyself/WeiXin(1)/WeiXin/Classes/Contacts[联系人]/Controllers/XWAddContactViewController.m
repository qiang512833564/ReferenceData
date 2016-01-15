//
//  XWAddContactViewController.m
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-21.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import "XWAddContactViewController.h"
#import "AppDelegate.h"

@interface XWAddContactViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation XWAddContactViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.textField.delegate = self;
    [self.textField addLeftViewWithImage:@"add_friend_searchicon"];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self addContact];
    return YES;
}

-(void)addContact{
    NSString *username = self.textField.text;
    
    
    // 如果有@符号，提示不合法
    if(![self.textField isTelphoneNum]){
        [self showAlert:@"请输入合法的手机号"];
        return;
    }
    
    // 不能添加自己
    if([username isEqualToString:[WXUserInfo sharedWXUserInfo].loginUserName]){
        [self showAlert:@"不能添加自己"];
        return;
    }
    
    NSString *jid = [NSString stringWithFormat:@"%@@%@",username,[WXUserInfo sharedWXUserInfo].xmppDomain];
    
    
    XMPPJID *friendJid = [XMPPJID jidWithString:jid];
    
    
    // 好友存在
    if([[WXXMPPTools sharedWXXMPPTools].rosterStorage userExistsWithJID:friendJid xmppStream:[WXXMPPTools sharedWXXMPPTools].xmppStream]){
        [self showAlert:@"当前好友已经存在，无须添加"];
        return;
    }
    
    // 添加好友
    [[WXXMPPTools sharedWXXMPPTools].roster subscribePresenceToUser:friendJid];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showAlert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提醒" message:msg delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alert show];
}
@end
