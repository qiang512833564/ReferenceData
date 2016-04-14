//
//  RunMode.m
//  Runtimer伪代码
//
//  Created by lizhongqiang on 16/4/10.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "RunMode.h"
#import <objc/runtime.h>
@implementation RunMode
NSThread *A;
- (instancetype)init{
    if (self = [super init]) {
        A = [[NSThread alloc]initWithTarget:self selector:@selector(runA) object:nil];
        [A start];
        [self start];
//        [NSThread detachNewThreadSelector:@selector(runB) toTarget:self withObject:nil];//创建一个新线程B
//        
//        NSMethodSignature *signature = [self methodSignatureForSelector:@selector(timerTick)];
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
//        invocation.target = self;
//        invocation.selector = @selector(timerTick);
//
//        //[invocation invoke];
//        //[[NSRunLoop currentRunLoop]run];
//        BOOL shouldKeepRunning = YES;        // global
        NSRunLoop *theRL = [NSRunLoop currentRunLoop];
//        NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerTick) userInfo:nil repeats:YES];
//        //        [invocation setArgument:(void *)timer atIndex:0];
//        //
//        //        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//        //while (1) {
//        [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
        
#pragma mark --- runMode:beforeDate: 与 run 方法的区别在于：第一个可以设置超时时间，超过超时时间，就会退出 runloop，而 run 缺一致处于 runloop 循环中 (CFRunLoopRunInMode 就是对 CFRunLoopRunInMode 方法的封装)(runMode:beforeDate:  官方说明文档：Runs the loop once, blocking for input in the specified mode until a given date.字面意思：一旦运行了这个 runloop ,就会调用这个方法去阻塞线程等待有 input source 在指定的 runModel 上发生，这种状态一直持续到 given date 限定的超时时间---------个人理解：为什么要指定 runMode 是因为 runloop 同一时间点只能运行一种 mode,想要切换 mode,只能先退出 runloop 再从新进入 runloop, 才能正常运行 mode)
        // runMode:beforeDate:
        // 1. 没有任何 input source 输入源的时候，线程会执行到 runMode:beforeDate: 这行代码的时候，处于监听是否有输入源的状态，直到有输入源输入或者超过超时时间（超过超时时间，则会退出 runloop 循环---这里的退出循环，只是退出监听输入的状态，当重新调用 runMode 方法的时候，又会继续监听，并不是正真意义上的 runloop 退出销毁）
        // 2. 当 input source 在处理的过程中和到达超时时间的时候，会返回 YES
        // 3. runloop 未 start 会返回 NO
        
        while ([theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]) {
            NSLog(@"YES if the run loop ran and processed an input source or if the specified timeout value was reached; otherwise, NO if the run loop could not be started.");
        }
        NSLog(@"exit");
        //while (shouldKeepRunning && );
        //[[NSRunLoop currentRunLoop] addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        //NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerTick) userInfo:nil repeats:YES];
        
       
        //}
    }
    return self;
}
- (void)start
{
    /*
     CFRunLoopSource 是 RunLoop 的数据源抽象类（protocol） RunLoop定义了两个Version的Source:
     Source0：处理App内部事件、App自己负责管理（触发），如UIEvent、CFSocket
     Source1：由RunLoop和内核管理，Mach port驱动，如CFMachPort、CFMessagePort
     */
#pragma mark ---   有这种情况，runloop 会被回收 app退出；线程关闭；设置最大时间到期；modeItem为空；
    
    //NSRunLoop *theRL = [NSRunLoop currentRunLoop];
#pragma mark --- [[NSRunloop mainRunloop]run]这是在主线程上，官方说 If no input sources or timers are attached to the run loop, this method exits immediately ，虽然在这里并没有 手动添加 input source ,但是系统可能默认会自动添加一些 input source(经过创建子线程测试，没有手动添加 input source 的时候，就会直接退出 exit runloop --- 个人理解：创建的子线程，并没有被系统自动添加一些 input source)
    //[theRL run];
    //  这里主要是监听某个 port，目的是让这个 Thread 不会回收(就是给 runloop 添加 modeItem (source1)---注意：addPort：添加的是 source1 ---个人理解：source0 与 source1 的区别是：source1 是对 port 进行监听，并有 port 进行触发事件 ---- 这里的监听，并不像 runloop 的 runMode:方法停留在这里，等到事件唤醒，个人理解只是加入到监听队列，程序继续往下执行，因此后面的代码需要注意：想要保持线程一直处于 runloop 循环中，则一般需要添加 while ([theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:5]]);来保证)
    //
    //[[NSRunLoop currentRunLoop]addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];

#pragma mark ---- GCD 的计时器，使用的避免了 NSTimer 的缺点：1.必须保证有一个活跃的runloop。2.NSTimer的创建与撤销必须在同一个线程操作、performSelector的创建与撤销必须在同一个线程操作。3.内存管理有潜在泄露的风险
/*
 当一个timer被schedule的时候，timer会持有target对象，NSRunLoop对象会持有timer。当invalidate被调用时，NSRunLoop对象会释放对timer的持有，timer会释放对target的持有。除此之外，我们没有途径可以释放timer对target的持有。所以解决内存泄露就必须撤销timer，若不撤销，target对象将永远无法释放。
 原文链接：http://www.jianshu.com/p/0c050af6c5ee
 */
//    __block int32_t timeOutCount=10;
//    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
//    
//    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC, 0);
//    dispatch_source_set_event_handler(timer, ^{
//        OSAtomicDecrement32(&timeOutCount);
//        if (timeOutCount == 0) {
//            NSLog(@"timersource cancel");
//            dispatch_source_cancel(timer);
//        }
//    });
//    
//    dispatch_source_set_cancel_handler(timer, ^{
//        NSLog(@"timersource cancel handle block");
//    });
//    
//    dispatch_resume(timer);
}
- (void)timerTick{
    
    NSLog(@"%s",__func__);
    
    sleep(1);
    
    NSLog(@"");
}
- (void)CFRunLoopRunInMode{
    
    NSLog(@"thread=%@------%s",[NSThread currentThread],__func__);
}
const CFStringRef CustomRunLoopMode;
- (void)runA{
    [self performSelector:@selector(CFRunLoopRunInMode) withObject:nil afterDelay:1];
    /*
     - (BOOL)runMode:(NSString *)mode beforeDate:(NSDate *)limitDate;
     //等待消息处理，好比在PC终端窗口上等待键盘输入。一旦有合适事件（mode相当于定义了事件的类型）被处理了，则立刻返回；类同run方法，如果没有事件处理也立刻返回；有否事件处理由返回布尔值判断。同样limitDate为超时参数。
     */
     if ([[NSRunLoop currentRunLoop]runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]) {
       NSLog(@"线程B结束");
     }else{
         NSLog(@"NO if the run loop could not be started.");
     }
    //
    //CFRunLoopRun();
    
#pragma mark --  给子线程的 runloop 添加 source1 ,使其不会退出 exit runloop(一般通过挪用run才会实现 runloop 循环,需要注意的是 addPort 一般写在 run 前面，因为 run 方法一旦没有 source 或者 timer 的生活，就会直接 exit runloop )
    [[NSRunLoop currentRunLoop] addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    
    [[NSRunLoop currentRunLoop]run];
    //
//    CFRunLoopAddCommonMode(CFRunLoopGetCurrent(), CustomRunLoopMode);
    //CFRunLoopRunInMode(kCFRunLoopDefaultMode, 10, false);//经测试，线程 A 会停留在这，直到超时等（也就是有结果返回时CFRunLoopRunResult），才会继续往下执行
   // [NSThread detachNewThreadSelector:@selector(runC) toTarget:self withObject:nil];//创建一个新线程B
//    while (1) {

//    }
    NSLog(@"runA");
}
- (void)runB{
    //sleep(1);
   // [self performSelector:@selector(setData) onThread:A withObject:nil waitUntilDone:YES];
    //[self set];
    NSLog(@"%s",__func__);
}
- (void)runC{
    sleep(1);
   // [self performSelector:@selector(setData) onThread:A withObject:nil waitUntilDone:YES];
}
- (void)setData{
    NSLog(@"%s",__func__);
}
@end
