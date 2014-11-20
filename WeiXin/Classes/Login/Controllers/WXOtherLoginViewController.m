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




- (IBAction)login {
    
    // 把数据保存单例对象
    NSString *user = self.phoneField.text;
    NSString *pwd = self.pwdField.text;
    
    WXUserInfo *userInfo = [WXUserInfo sharedWXUserInfo];
    userInfo.loginUser = user;
    userInfo.loginPwd = pwd;
    
    // 调用代理的登录方法
    [MBProgressHUD showMessage:@"正在登录.." toView:self.view];
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    __weak typeof(self) selfVc = self;
    [app userLoginWithResultBlock:^(XMPPResultType type) {
        [selfVc handleResultType:type];
    }];
    
}

// 处理请求结果
-(void)handleResultType:(XMPPResultType)type{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view ];
        int myType = type;
        switch (myType) {
            case XMPPResultTypeLoginSuccess:
                [MBProgressHUD showSuccess:@"登录成功" toView:self.view ];
                
                // 模态窗口消失
                [self dismissViewControllerAnimated:NO completion:nil];
                
                // 进到主界面
                [self enterMainStoryboard];
                
                // 保存登录信息到沙盒
                [[WXUserInfo sharedWXUserInfo] synchronizeToSandBox];
                break;
                
            case XMPPResultTypeLoginFailure:
                [MBProgressHUD showError:@"用户名或者密码不正确" toView:self.view];
                break;
        }
        
        WXLog(@"%d",type);
    });
}

-(void)enterMainStoryboard{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // 切换跟控制器
    id initalVc = [storyboard instantiateInitialViewController];
    self.view.window.rootViewController = initalVc;
}
-(void)dealloc{
    WXLog(@"xx");
}

@end
