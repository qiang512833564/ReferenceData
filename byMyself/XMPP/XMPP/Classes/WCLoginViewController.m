//
//  WCLoginViewController.m
//  XMPP
//
//  Created by lizhongqiang on 15/9/26.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "WCLoginViewController.h"
#import "AppDelegate.h"

@interface WCLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation WCLoginViewController
- (IBAction)loginBtnClick:(id)sender {
    if(self.username.text.length == 0 ||self.password.text.length == 0)
    {
        NSLog(@"请输入用户名和密码");
        return;
    }
   
   
    [MBProgressHUD showMessag:@"正在登陆。。。。。" toView:self.view];
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:self.username.text forKey:@"username"];
//    [defaults setObject:self.password.text forKey:@"password"];
//    [defaults synchronize];//同步到磁盘上去
    //把用户和密码先放在Account单例
    [WCAccount shareAccount].loginUser = self.username.text;
    [WCAccount shareAccount].loginPwd = self.password.text;
    
    
    __weak typeof (self)selfVC = self;

    [WCXMPPTool sharedWCXMPPTool].registerOperation = NO;
    //自己写的block,有强引用的时候，使用弱引用，系统的block，基本可以不理会
    [[WCXMPPTool sharedWCXMPPTool] xmppLogin:^(XMPPResultType resultType) {
        [selfVC handlXMPPResultType:resultType];
    }];
}
- (void)handlXMPPResultType:(XMPPResultType)resultType{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if(resultType == XMPPResultTypeLoginSucess)
        {
            [WCAccount shareAccount].login = YES;
            NSLog(@"%s 登陆成功",__func__);
            //[self changeToMain];//这里直接用self调用方法，将会导致self循环引用
            [UIStoryboard showInitialVCWithName:@"Main"];
            [[WCAccount shareAccount] saveToSandBox];
        }
        else
        {
            NSLog(@"%s 登录失败",__func__);
            [MBProgressHUD showError:@"用户名或者密码错误" toView:self.view];
        }
    });
}
- (void)dealloc
{
    NSLog(@"%s",__func__);
}

//- (void)changeToMain{
//    //回到主线程更新UI----如果不返回主线程，将会导致切换跟视图控制器在子线程中进行，使得延迟刷新UI界面
//    dispatch_async(dispatch_get_main_queue(), ^{
//        //1.获取Main.storyboard的第一个控制器
//        id vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateInitialViewController];//切换到进入箭头所指的根视图控制器
//        //2.切换window的根控制器
//        [UIApplication sharedApplication].keyWindow.rootViewController  = vc;
//    });
//   
//}
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

@end
