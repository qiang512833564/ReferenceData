//
//  WXRegisterViewController.m
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-19.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import "WXOtherLoginViewController.h"
#import "CategoryWF.h"
#import "AppDelegate.h"
#import "WXUserInfo.h"

@interface WXOtherLoginViewController()

@property (weak, nonatomic) IBOutlet UITextField *phoneField;

@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;
@end

@implementation WXOtherLoginViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    // 添加取消按钮
    UIBarButtonItem *cancleItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    self.navigationItem.leftBarButtonItem = cancleItem;
    
    // 设置输入框背景图片
    self.phoneField.background = [UIImage stretchedImageWithName:@"operationbox_text"];
    self.pwdField.background = [UIImage stretchedImageWithName:@"operationbox_text"];
    
    // 判断当前设置是否为iphone
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        self.leftConstraint.constant = 20;
        self.rightConstraint.constant = 20;
    }
    
  
    [self textChange:nil];
}

- (IBAction)textChange:(id)sender {
    // 设置按钮是否可用
    BOOL enable = (self.phoneField.text.length != 0 &&  self.pwdField.text.length != 0);
    
    self.loginBtn.enabled = enable;
}


-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}




- (IBAction)loginBtnClick {
    
    // 把数据保存单例对象
    NSString *user = self.phoneField.text;
    NSString *pwd = self.pwdField.text;
    
    WXUserInfo *userInfo = [WXUserInfo sharedWXUserInfo];
    userInfo.loginUserName = user;
    userInfo.loginPwd = pwd;
    
    // 调用父类的登录方法
    [self login];
    
    
}


-(void)dealloc{
    WXLog(@"xx");
}

@end
