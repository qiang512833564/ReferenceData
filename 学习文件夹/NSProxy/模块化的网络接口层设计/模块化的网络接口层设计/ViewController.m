//
//  ViewController.m
//  模块化的网络接口层设计
//
//  Created by lizhongqiang on 16/3/17.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"
#import "HttpProxy.h"
#import "UserHttpHandlerImp.h"
#import "CommentHttpHandlerImp.h"
#import "WeakProxy.h"
#import "Crash.h"
#import <objc/runtime.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //初始化，注册Protocol对应的实现类对象
    [[HttpProxy sharedInstance]registerHttpProtocol:@protocol(UserHttpHandler) handler:[[UserHttpHandlerImp alloc]init]];
    [[HttpProxy sharedInstance]registerHttpProtocol:@protocol(CommentHttpHandler) handler:[[CommentHttpHandlerImp alloc]init]];
    //调用
    [[HttpProxy sharedInstance]getUserWithID:@100];
    [[HttpProxy sharedInstance]getCommentsWithDate:[NSDate date]];
    
}
- (void)forwardInvocation:(NSInvocation *)invocation {
    void *null = NULL;
    [invocation setReturnValue:&null];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
