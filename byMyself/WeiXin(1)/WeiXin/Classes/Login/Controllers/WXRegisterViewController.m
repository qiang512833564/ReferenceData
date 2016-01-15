//
//  WXRegisterViewController.m
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-19.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import "WXRegisterViewController.h"
#import "CategoryWF.h"
#import "WXUserInfo.h"
#import "AppDelegate.h"

@interface WXRegisterViewController()

@property (weak, nonatomic) IBOutlet UITextField *phoneField;

@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;
@end

@implementation WXRegisterViewController


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
    
    self.registerBtn.enabled = enable;
}


-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (IBAction)userRegister {
    [self.view endEditing:YES];
    
    
    NSString *username = self.phoneField.text;
    NSString *pwd = self.pwdField.text;
    
    WXUserInfo *userInfo = [WXUserInfo sharedWXUserInfo];
    userInfo.registerUserName = username;
    userInfo.registerPwd = pwd;
    
    //AppDelegate *app = [UIApplication sharedApplication].delegate;
    [WXXMPPTools sharedWXXMPPTools].userRegister = YES;
    
    [MBProgressHUD showMessage:@"正在注册" toView:self.view];
     __weak typeof(self) selfVc = self;
    [[WXXMPPTools sharedWXXMPPTools] userRegisterWithResultBlock:^(XMPPResultType type) {
        [selfVc handleResultType:type];
    }];
    
}

// 处理请求结果
-(void)handleResultType:(XMPPResultType)type{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view ];
        int myType = type;
        switch (myType) {
            case XMPPResultTypeRegisterSuccess:
                if ([self.delegate respondsToSelector:@selector(registerViewControllerDidfinishedRegister)]) {
                    [self.delegate registerViewControllerDidfinishedRegister];
                }
                break;
                
            case XMPPResultTypeRegisterFailure:
                [MBProgressHUD showError:@"用户名已存在" toView:self.view];
                break;
        }
        
        WXLog(@"%d",type);
    });
}

-(void)dealloc{
    WXLog(@"xx");
}


@end
