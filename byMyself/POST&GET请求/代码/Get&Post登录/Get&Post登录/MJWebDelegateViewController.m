//
//  MJWebDelegateViewController.m
//  Get&Post登录
//
//  Created by apple on 14-4-24.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJWebDelegateViewController.h"
#import "NSString+Password.h"

@interface MJWebDelegateViewController () <NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPwd;

@property (weak, nonatomic) IBOutlet UILabel *logonResult;

// 从服务器接收到的数据,进行拼接工作
@property (nonatomic, strong) NSMutableData *data;

@property (nonatomic, strong) NSString *myPwd;

@end

@implementation MJWebDelegateViewController
/**
 1. 用户密码明文只能出现在用户登录窗口,不能再其他任何地方出现密码明文
 2. 其他位置,无论是服务器,还是本地,还是传输过程中,统一使用加密后的算法.
 */

- (NSString *)myPwd
{
    return [self.userPwd.text myMD5];
}

- (IBAction)userLogon
{
    [self getLogon];
}

- (void)getLogon
{
    // 1. URL
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost/text.php?username=%@&password=%@", self.userName.text, self.userPwd.text];//self.myPwd
    
    NSLog(@"%@", self.myPwd);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 2. Request
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. 连接,已经10多岁了
    // 是一个很古老的技术
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    // 开始工作,在很多多线程技术中,start run
    dispatch_async(dispatch_queue_create("demo", DISPATCH_QUEUE_CONCURRENT), ^{
        [connection start];
    });
}

#pragma mark - NSURLConnectionDataDelegate代理方法
#pragma mark 接受到响应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // 准备工作
    // 按钮点击就会有网络请求,为了避免重复开辟空间
    if (!self.data) {
        self.data = [NSMutableData data];
    } else {
        [self.data setData:nil];
    }
}

#pragma mark 接收到数据,如果数据量大,例如视频,会被多次调用
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // 拼接数据,二进制流的体现位置
    [self.data appendData:data];
}

#pragma mark 接收完成,做最终的处理工作
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // 最终处理
    NSString *str = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@ %@", str, [NSThread currentThread]);
}

#pragma mark 出错处理,网络的出错可能性非常高
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@", error.localizedDescription);
}

@end
