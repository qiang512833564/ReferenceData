//
//  ViewController.m
//  Runloop实现线程睡眠
//
//  Created by lizhongqiang on 15/12/7.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    BOOL end;
    NSTimer *_timer;
    BOOL pageStillLoading;
}
@property(nonatomic,assign)BOOL isCancelled;
@property (nonatomic, strong)UIButton *btn;
@end

@implementation ViewController
- (NSTimer *)timer{
    if(_timer == nil){
        _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    }
    return _timer;
}
- (UIButton*)btn{
    if(_btn == nil){
        _btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btn setTitle:@"按钮" forState:UIControlStateNormal];
        _btn.frame = CGRectMake(100, 100, 100, 30);
        _btn.backgroundColor = [UIColor blueColor];
        [_btn addTarget:self action:@selector(startAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}
- (void)timerRun{
    NSLog(@"%s",_cmd);
}
- (void)viewDidLoad {
   
    [super viewDidLoad];
#if 0
     [[NSRunLoop currentRunLoop]runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"start new thread ...");
    BOOL myend = NO;
    [NSThread detachNewThreadSelector:@selector(runOnNewThread) toTarget:self withObject:nil];
    //[[NSRunLoop currentRunLoop]addTimer:[self timer] forMode:NSDefaultRunLoopMode];
    while (!end) {
        NSLog(@"runloop...-----%@",[NSThread currentThread]);
        myend = [[NSRunLoop currentRunLoop]runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];//如果runMode是NSRunLoopCommonModes模式，则主线程，则会处于等待状态，知道NSRunLoopCommonModes的模式类型的事件发生，才会继续往下执行
        //[[NSRunLoop currentRunLoop]runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
        NSLog(@"runloop end. ----%d ",myend);
    }
    NSLog(@"runloop finished .....,%d",myend);
#endif
    [self.view addSubview:self.btn];
    //[self main];
}
- (void)runOnNewThread{
    NSLog(@"run for new thread ...");
    sleep(3);
    end = YES;
    //[self performSelectorOnMainThread:@selector(setEnd) withObject:nil waitUntilDone:NO];//这个，意思是在主线程执行方法
    NSLog(@"end .----%@",[NSThread currentThread]);
}
- (void)setEnd{
    end = YES;
    //NSLog(@"%s---%@",_cmd,[NSThread currentThread]);
}
- (void)startAction{
    [self main];
}
- (void)main
{
    //createCustomSource();
    @autoreleasepool {
        NSLog(@"starting thread.......");
        
        //[self performSelector:@selector(addTimer) withObject:nil afterDelay:0];
        [self addTimer];
        //
        NSLog(@"mode==%@",[NSRunLoop currentRunLoop].currentMode);
        while (! self.isCancelled) {
            [self doOtherTask];//当检测到有该模式的，事件源在运行时，会每1分钟，循环一次，其他时间runloop都处于休眠状态:@"MY-RUN-LOOP-COMMON"
            BOOL ret = [[NSRunLoop currentRunLoop] runMode:NSRunLoopCommonModes beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
            NSLog(@"after runloop counting.........: %d.......%@", ret,[NSRunLoop currentRunLoop].currentMode);
        }
        NSLog(@"finishing thread.........");
    }
}
- (void)addTimer{
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(doTimerTask) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    //[self performSelector:@selector(cancelTimer) withObject:nil afterDelay:3];
    _timer = timer;
}
- (void)cancelTimer{
    
    //[_timer invalidate];
    //_timer = nil;
}
- (void)doTimerTask
{
    NSLog(@"%@",[NSThread currentThread]);
    NSLog(@"do timer task");
    if ([[NSRunLoop currentRunLoop].currentMode isEqualToString:NSDefaultRunLoopMode]) {
        NSLog(@"stop runloop");
        //CFRunLoopStop(CFRunLoopGetCurrent());
    }
}
- (void)doOtherTask
{
    NSLog(@"do other task");
}
#pragma mark ---- 自定义事件源 ------
bool pageStillLoading = true;
void createCustomSource(){
    CFRunLoopSourceContext context = {0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL};
    CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
    while (pageStillLoading) {
        //NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        //CFRunLoopRun();
        char *S = "DADADADADAD";
        bool ret = CFRunLoopRunInMode(kCFRunLoopDefaultMode, 5, true);//留给kCFRunLoopDefaultMode模式下的事件源，每次处理时间为5秒
        NSLog(@"%s---%d",__func__,ret);
    }
    CFRunLoopRemoveSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
    CFRelease(source);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
