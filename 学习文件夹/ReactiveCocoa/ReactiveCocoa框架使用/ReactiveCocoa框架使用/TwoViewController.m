//
//  TwoViewController.m
//  ReactiveCocoa框架使用
//
//  Created by lizhongqiang on 16/1/23.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "TwoViewController.h"

@implementation TwoViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送消息" forState:UIControlStateNormal];
    btn.frame = CGRectMake(20, 100, 100, 30);
    btn.backgroundColor = [UIColor purpleColor];
    [btn sizeToFit];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(notice) forControlEvents:UIControlEventTouchUpInside];
    
    //通过objc_setAssociatedObject，class_getInstanceMethod---runtime去实现，方法的调用
    [[self.view rac_signalForSelector:@selector(notice)]subscribeNext:^(id x) {
        NSLog(@"红色按钮");
    }];
    
    // 2.KVO
    // 把监听redV的center属性改变转换成信号，只要值改变就会发送信号
    // observer:可以传入nil
    [[self.view rac_valuesAndChangesForKeyPath:@"center" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
        
    }];
}
- (void)notice{
    // 通知第一个控制器，告诉它，按钮被点了
    
    // 通知代理
    // 判断代理信号是否有值
    if (self.delegateSignal) {
        // 有值，才需要通知
        [self.delegateSignal sendNext:nil];
    }
    
    
}
- (void)btnckick{
    NSLog(@"%s----%@",__func__,[self class]);
}
@end
