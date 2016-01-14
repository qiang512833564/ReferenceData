//
//  HWOAuthViewController.m
//  黑马微博2期
//
//  Created by apple on 14-10-10.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HWOAuthViewController.h"
#import "HWAccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "HWHttpTool.h"

@interface HWOAuthViewController () <UIWebViewDelegate>

@end

@implementation HWOAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.创建一个webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // 2.用webView加载登录页面（新浪提供的）
    // 请求地址：https://api.weibo.com/oauth2/authorize
    /* 请求参数：
     client_id	true	string	申请应用时分配的AppKey。
     redirect_uri	true	string	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
    */
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", HWAppKey, HWRedirectURI];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

#pragma mark - webView代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载..."];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 1.获得url
    NSString *url = request.URL.absoluteString;
    
    // 2.判断是否为回调地址
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) { // 是回调地址
        // 截取code=后面的参数值
        NSUInteger fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        
        // 利用code换取一个accessToken
        [self accessTokenWithCode:code];
        
        // 禁止加载回调地址
        return NO;
    }
    
    return YES;
}

/**
 *  利用code（授权成功后的request token）换取一个accessToken
 *
 *  @param code 授权成功后的request token
 */
- (void)accessTokenWithCode:(NSString *)code
{
    // 1.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = HWAppKey;
    params[@"client_secret"] = HWAppSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = HWRedirectURI;
    params[@"code"] = code;
    
    // 2.发送请求
    [HWHttpTool post:@"https://api.weibo.com/oauth2/access_token" params:params success:^(id json) {
        [MBProgressHUD hideHUD];
        
        // 将返回的账号字典数据 --> 模型，存进沙盒
        HWAccount *account = [HWAccount accountWithDict:json];
        // 存储账号信息
        [HWAccountTool saveAccount:account];
        
        // 切换窗口的根控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        HWLog(@"请求失败-%@", error);
    }];
}
@end
