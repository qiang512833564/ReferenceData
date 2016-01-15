//
//  WCRegisterViewController.m
//  XMPP
//
//  Created by lizhongqiang on 15/9/26.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "WCRegisterViewController.h"

@interface WCRegisterViewController ()
- (IBAction)cancelBtnClick:(id)sender;
- (IBAction)registerBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *userFiel;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;

@end

@implementation WCRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelBtnClick:(id)sender {
    
}

- (IBAction)registerBtnClick:(id)sender {
    //注册
    [WCXMPPTool sharedWCXMPPTool].registerOperation = YES;
    //保存注册的用户名和密码
    [WCAccount shareAccount].registerUser = self.userFiel.text;
    [WCAccount shareAccount].registerPwd = self.pwdField.text;
    
    [MBProgressHUD showMessag:@"正在注册中...."  toView:self.view];
    //调用注册方法
    
    __weak typeof(self) selfVC = self;
    //1.发送‘注册jid’给服务器，请求一个长连接
    [[WCXMPPTool sharedWCXMPPTool]xmppRegister:^(XMPPResultType result){
        [selfVC  handleXMPPResult:result];
    }];
    //2.连接成功，发送注册密码
}
//处理注册额结果
- (void)handleXMPPResult:(XMPPResultType) result{
    dispatch_async(dispatch_get_main_queue(), ^{
       //1.隐藏提示
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (result == XMPPResultTypeRegisterSucess) {
            [MBProgressHUD showSuccess:@"注册成功" toView:self.view];
        }else
        {
            [MBProgressHUD showError:@"注册失败" toView:self.view];
        }
    });
    
}
@end
