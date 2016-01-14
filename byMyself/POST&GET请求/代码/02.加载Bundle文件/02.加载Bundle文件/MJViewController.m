//
//  MJViewController.m
//  02.加载Bundle文件
//
//  Created by apple on 14-4-24.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJViewController.h"

@interface MJViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation MJViewController

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
    }
    return _webView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    
    // HTML是网页的设计语言
    // <>表示标记</>
    // 应用场景:截取网页中的某一部分显示
    // 例如:网页的完整内容中包含广告!加载完成页面之后,把广告部分的HTML删除,然后再加载
    // 被很多新闻类的应用程序使用
//    [self.webView loadHTMLString:@"<p>Hello</p>" baseURL:nil];
    
    [self loadFile];
}

#pragma mark - 加载文件
- (void)loadFile
{
    // 应用场景:加载从服务器上下载的文件,例如pdf,或者word,图片等等文件
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"关于.txt" withExtension:nil];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    
    [self.webView loadRequest:request];
}

#pragma 以二进制数据的形式加载文件
- (void)loadDataFile
{
    // 最最常见的一种情况
    // 打开IE,访问网站,提示你安装Flash插件
    // 如果没有这个应用程序,是无法用UIWebView打开对应的文件的
    
    // 应用场景:加载从服务器上下载的文件,例如pdf,或者word,图片等等文件
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"iOS 7 Programming Cookbook.pdf" withExtension:nil];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    // 服务器的响应对象,服务器接收到请求返回给客户端的
    NSURLResponse *respnose = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&respnose error:NULL];
    
    NSLog(@"%@", respnose.MIMEType);
    
    // 在iOS开发中,如果不是特殊要求,所有的文本编码都是用UTF8
    // 先用UTF8解释接收到的二进制数据流
    [self.webView loadData:data MIMEType:respnose.MIMEType textEncodingName:@"UTF8" baseURL:nil];
}

- (NSString *)mimeType:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 服务器的响应对象,服务器接收到请求返回给客户端的
    NSURLResponse *respnose = nil;
    
    // 发送请求给服务器:url(http://服务器地址/资源路径)
    [NSURLConnection sendSynchronousRequest:request returningResponse:&respnose error:NULL];
    
    NSLog(@"%@", respnose.MIMEType);
    
    return respnose.MIMEType;
}

@end
