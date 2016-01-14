//
//  MJViewController.m
//  01.UIWebView
//
//  Created by apple on 14-4-24.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJViewController.h"

@interface MJViewController () <UISearchBarDelegate, UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwarButton;

@end

@implementation MJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	[self loadString:@"http://m.baidu.com"];
}

// 让浏览器加载指定的字符串,使用m.baidu.com进行搜索
- (void)loadString:(NSString *)str
{
    // 1. URL 定位资源,需要资源的地址
    NSString *urlStr = str;
    if (![str hasPrefix:@"http://"]) {
        urlStr = [NSString stringWithFormat:@"http://m.baidu.com/s?word=%@", str];
    }
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. 发送请求给服务器
    [self.webView loadRequest:request];
}

#pragma mark - 搜索栏代理
// 开始搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"%@", searchBar.text);
    [self loadString:searchBar.text];
    
    [self.view endEditing:YES];
}

// 文本改变
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"searchText - %@", searchText);
}

#pragma mark - WebView代理方法
#pragma mark 完成加载,页面链表数据会更新
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 根据webView当前的状态,来判断按钮的状态
    self.backButton.enabled = webView.canGoBack;
    self.forwarButton.enabled = webView.canGoForward;
}

@end
