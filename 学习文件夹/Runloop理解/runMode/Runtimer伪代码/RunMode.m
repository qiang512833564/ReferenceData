//
//  RunMode.m
//  Runtimer伪代码
//
//  Created by lizhongqiang on 16/4/10.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "RunMode.h"

@implementation RunMode
NSThread *A;
- (instancetype)init{
    if (self = [super init]) {
        A = [[NSThread alloc]initWithTarget:self selector:@selector(runA) object:nil];
        [A start];
    }
    return self;
}

- (void)runA{
    [NSThread detachNewThreadSelector:@selector(runB) toTarget:self withObject:nil];//创建一个新线程B
    while (1) {
        /*
         - (BOOL)runMode:(NSString *)mode beforeDate:(NSDate *)limitDate;
         //等待消息处理，好比在PC终端窗口上等待键盘输入。一旦有合适事件（mode相当于定义了事件的类型）被处理了，则立刻返回；类同run方法，如果没有事件处理也立刻返回；有否事件处理由返回布尔值判断。同样limitDate为超时参数。
         */
        if ([[NSRunLoop currentRunLoop]runMode:@"CustomRunLoopMode" beforeDate:[NSDate distantFuture]]) {
            NSLog(@"线程B结束");
            break;
        }
    }
}
- (void)runB{
    sleep(1);
    [self performSelector:@selector(setData) onThread:A withObject:nil waitUntilDone:YES modes:@[@"CustomRunLoopMode"]];
}
- (void)setData{
    NSLog(@"%s",__func__);
}
@end
