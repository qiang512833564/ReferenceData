//
//  ViewController.m
//  OC--JS
//
//  Created by lizhongqiang on 16/2/2.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSObjectDelegate <JSExport>

- (void)callCamera;
- (void)share:(NSString *)shareString;

@end

@interface ViewController ()<UIWebViewDelegate,JSObjectDelegate>
@property (nonatomic, strong) JSContext *jsContext;
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation ViewController

- (UIWebView *)webView{
    if(_webView == nil){
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        _webView.delegate = self;
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"test" withExtension:@"html"];
    [self.webView loadRequest:[[NSURLRequest alloc]initWithURL:url]];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    /*
     我们是通过webView的valueForKeyPath获取的，其路径为documentView.webView.mainFrame.javaScriptContext。
     这样就可以获取到JS的context，然后为这个context注入我们的模型对象。
     */
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"Toyun"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue){
        context.exception = exceptionValue;
        NSLog(@"异常信息:%@",exceptionValue);
    };
}
- (void)callCamera{
    NSLog(@"callCamera");
    //
    JSValue *picCallback = self.jsContext[@"picCallback"];
    [picCallback callWithArguments:@[@"photos"]];
}
- (void)share:(NSString *)shareString{
    NSLog(@"share:%@",shareString);
    
    //这个，是获取JS方法
    JSValue *shareCallback = self.jsContext[@"shareCallback"];
    //这个是调用JS方法，并传入参数，
    [shareCallback callWithArguments:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
