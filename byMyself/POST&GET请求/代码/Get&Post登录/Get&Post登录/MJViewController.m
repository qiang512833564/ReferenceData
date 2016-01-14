//
//  MJViewController.m
//  Get&Post登录
//
//  Created by apple on 14-4-24.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJViewController.h"

@interface MJViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPwd;

@property (weak, nonatomic) IBOutlet UILabel *logonResult;

@end

@implementation MJViewController
/**
 所有网络请求,统一使用异步请求!
 
 在今后的开发中,如果使用简单的get/head请求,可以用NSURLConnction异步方法
 GET查/POST增/PUT改/DELETE删/HEAD
 
 GET
 1> URL
 2> NSURLRequest
 3> NSURLConnction 异步
 
 POST
 1> URL
 2> NSMutableURLRequest
    .httpMethod = @"POST";
    str 从 firebug直接粘贴,或者自己写 
    变量名1=数值1&变量名2=数值2
 
    .httpData = [str dataUsingEncoding:NSUTF8StringEncoding];
 3> NSURLConnction 异步
 
 */
- (IBAction)userLogon
{
    //[self getLogon];
    [self postLogon];
}

#pragma mark - POST登录
- (void)postLogon
{
    // 1. URL
    NSURL *url = [NSURL URLWithString:@"http://localhost/text.php"];
    
    // 2. 请求(可以改的请求)
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // ? POST
    // 默认就是GET请求
    request.HTTPMethod = @"POST";
    // ? 数据体
    NSString *str = [NSString stringWithFormat:@"username=%@&password=%@", self.userName.text, self.userPwd.text];
    // 将字符串转换成数据
    request.HTTPBody = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    // 3. 连接,异步
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError == nil) {
            // 网络请求结束之后执行!
            // 将Data转换成字符串
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            // num = 2
            NSLog(@"%@ %@", str, [NSThread currentThread]);
            
            // 更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.logonResult.text = str;
            }];
        }
    }];
    
    // num = 1
    NSLog(@"come here %@", [NSThread currentThread]);
}

#pragma mark - GET登录
- (void)getLogon
{
    // 1. URL
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost/text.php?username=%@&password=%@", self.userName.text, self.userPwd.text];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 2. Request
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. Connection
    // 1> 登录完成之前,不能做后续工作!
    // 2> 登录进行中,可以允许用户干点别的会更好!
    // 3> 让登录操作在其他线程中进行,就不会阻塞主线程的工作
    // 4> 结论:登陆也是异步访问,中间需要阻塞住
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError == nil) {
            // 网络请求结束之后执行!
            // 将Data转换成字符串
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            // num = 2
            NSLog(@"%@ %@", str, [NSThread currentThread]);
            
            // 更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.logonResult.text = @"登录完成";
            }];
        }
    }];
    
    // num = 1
    NSLog(@"come here %@", [NSThread currentThread]);
    
    NSURLResponse *response = nil;
    // 1. &response真的理解了吗?
    // 2. error:为什么是NULL,而不是nil
    // NULL是C语言的 = 0
    // 在C语言中,如果将指针的地址指向0就不会有危险
    
    // nil是OC的,是一个空对象发送消息不会出问题
//    [response MIMEType];
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
}

@end
