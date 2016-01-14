//
//  RLSampleViewController.m
//  NSRunLoopSample
//
//  Created by 秋元　健太 on 2014/06/01.
//  Copyright (c) 2014年 kentaakimoto. All rights reserved.
//

#import "RLSampleViewController.h"

@interface RLSampleViewController ()

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,weak) NSTimer *timerB;
@property (nonatomic,assign) NSUInteger fireCount;

@end

@implementation RLSampleViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
/**
 * タイマー発火で呼ばれる
 */
- (void)timerFireMethod:(NSTimer *)timer{
    self.fireCount++;
    NSRunLoop *myRunLoop = [NSRunLoop currentRunLoop];
    
    NSLog(@"[%@][%@] timerFireMethod %lu",[NSThread currentThread], myRunLoop.currentMode, (unsigned long) _fireCount);
    
    // オレオレRunLoopを止める場合
    if ([myRunLoop.currentMode isEqualToString:NSDefaultRunLoopMode]) {
        NSLog(@"stop runloop");
        CFRunLoopStop(CFRunLoopGetCurrent());//目前，这里是子线程，是行的通的
        //CFRunLoopStop([[NSRunLoop mainRunLoop] getCFRunLoop]);//你在主线程的RunLoop中添加了新的源，但你并没有权限停止它
    }
}
- (NSTimer *)timer{
    if(_timer == nil){
        _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
        //_timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
        // _timer = [[NSTimer alloc]initWithFireDate:[NSDate distantFuture] interval:1 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    }
    return _timer;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.fireCount = 0;
    
    // 定时器初始化
    //_timerB = [NSTimer timerWithTimeInterval:0.5f target:self selector:@selector(timerFireMethodB:) userInfo:nil repeats:YES];
    dispatch_queue_t globalqueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
     dispatch_async(globalqueue, ^{
    [self addRunloop];
        });
}
- (void)addRunloop{
    NSRunLoop *myRunLoop = [NSRunLoop currentRunLoop];
     NSString *mode = (__bridge NSString *)(CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent()));
   // NSLog(@"%@---%@----%@",myRunLoop,mode,myRunLoop.currentMode);
    //CFRunLoopRun();
    // [myRunLoop run];//执行了这一句，
    // タイマーをどのモードでセットするか--设置定时器模式
#warning タイマーをどのモードでセットするか
    //[myRunLoop addTimer:_timer forMode:NSDefaultRunLoopMode];
    //   [myRunLoop addTimer:_timer forMode:NSRunLoopCommonModes];
    [myRunLoop addTimer:self.timer forMode:NSDefaultRunLoopMode];
    
    // [myRunLoop addTimer:_timer forMode:NSDefaultRunLoopMode];
    //    [myRunLoop addTimer:_timer forMode:UITrackingRunLoopMode];
    
    
    //    [myRunLoop addTimer:_timerB forMode:NSRunLoopCommonModes];
    
    
    // 実行ループオブザーバを作成して、実行ループに接続します。
    CFRunLoopObserverContext context = {0, CFBridgingRetain(self), NULL, NULL, NULL};
    //创建Run loop observer对象
    //第一个参数用于分配observer对象的内存
    //第二个参数用以设置observer所要关注的事件，详见回调函数myRunLoopObserver中注释
    //第三个参数用于标识该observer是在第一次进入run loop时执行还是每次进入run loop处理时均执行
    //第四个参数用于设置该observer的优先级，一般设置为0
    //第五个参数用于设置该observer的回调函数
    //第六个参数用于设置该observer的运行环境
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                                            kCFRunLoopAllActivities, YES, 0, &myRunLoopObserver, &context);
    if (observer)
    {
        CFRunLoopRef cfLoop = [myRunLoop getCFRunLoop];
        
#warning オブザーバをどのモードでセットするか ＝ どのモードを監視するか
        //        CFRunLoopAddObserver(cfLoop, observer, kCFRunLoopDefaultMode);
        CFRunLoopAddObserver(cfLoop, observer, kCFRunLoopCommonModes);
        
    }
    
#warning 自分でrunloopをまわす場合
    NSInteger loopCount = 5;
    BOOL done = false;
    do {
        NSLog(@"runUntilDate");
        
        //[myRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:10]];
        // 当run loop的运行时间到达时，会退出当前的run loop，observer同样会检测到run loop的退出行为，并调用其回调函数，第二个参数传递的行为是kCFRunLoopExit.
        
        /*
         - (BOOL)runMode:(NSString *)mode beforeDate:(NSDate *)limitDate; //等待消息处理，好比在PC终端窗口上等待键盘输入。一旦有合适事件（mode相当于定义了事件的类型）被处理了，则立刻返回；类同run方法，如果没有事件处理也立刻返回；有否事件处理由返回布尔值判断。同样limitDate为超时参数（超过了通常或规定的时间）。
         */
        //
        [myRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]; //--该方法可以理解为一个“过滤器”,我们可以只对自己关心的事件进行监视--// 主线程等待，但让出主线程时间片，有时间到达就返回，如果没有则超过设定的超时时间就返回
        /*
         启动run loop一次，在特定的run loop mode下等待输入。
         如果没有附加input source或是timer，或是过limitDate，run loop就会退出，并且方法返回NO。
         
         [[NSRunLoop mainRunLoop] run]; //主线程永远等待，但让出主线程时间片
         [[NSRunLoop mainRunLoop] runUntilDate:[NSDate distantFuture]]; //等同上面调用
         [[NSRunLoop mainRunLoop] runUntilDate:[NSDate date]]; //立即返回
         [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:10.0]]; //主线程等待，但让出主线程时间片，然后过10秒后返回
         */
        loopCount--;
    } while (loopCount);
    NSLog(@"while loop end------------------------------------");
    
}
/**
 * RunLoopのアクティビティ毎に呼ばれる
 */
void myRunLoopObserver(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
#pragma mark --- void *叫做无确切类型指针，这个指针指向一块内存，却没有告诉程序该用何种方式来解释这片内存，所以这种类型的指针不能直接进行取内容的操作，必须先转成别的类型的指针才能把内容解释出来
    /*
     // 参考：アクティビティの値
     kCFRunLoopEntry = (1UL << 0),即将进入Loop
     kCFRunLoopBeforeTimers = (1UL << 1),即将处理Timer
     kCFRunLoopBeforeSources = (1UL << 2),即将处理Source
     kCFRunLoopBeforeWaiting = (1UL << 5),即将进入休眠
     kCFRunLoopAfterWaiting = (1UL << 6),刚从休眠中唤醒
     kCFRunLoopExit = (1UL << 7),即将退出
     kCFRunLoopAllActivities = 0x0FFFFFFFU
     */
    
    NSMutableArray *flags = [@[] mutableCopy];//32
    flags[0] = @((activity >> 0) & 1);//00100000
    flags[1] = @((activity >> 1) & 1);//00010000
    flags[2] = @((activity >> 2) & 1);//00001000
    flags[3] = @((activity >> 5) & 1);//00000001
    flags[4] = @((activity >> 6) & 1);//00000000
    flags[5] = @((activity >> 7) & 1);//00000000
#pragma mark --- 单纯的&1是没有意义的，而且是非法的
#pragma mark --- 但是一个变量a&1是合法的，代表的意思是a和1做二进制的且运算，即看a的最后边那一位是不是1，是的话就返回1，否则返回0
    NSString *mode = (__bridge NSString *)(CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent()));
    
    RLSampleViewController *obj = (__bridge RLSampleViewController *)info;
    NSLog(@"[%@][%@]myRunLoopObserver activity:%lu---%@",[NSThread currentThread],mode,activity ,[obj convertString:flags]);
}

- (NSString *) convertString:(NSArray*) array{
    NSMutableString *results = [NSMutableString string];
    for (NSNumber *flag in array) {
        [results appendFormat:@"%d",[flag boolValue]];
    }
    return results;
}



/**
 * タイマー発火で呼ばれる(時間がかかる処理)
 */
- (void)timerFireMethodB:(NSTimer *)timer{
    NSRunLoop *myRunLoop = [NSRunLoop currentRunLoop];
    
    //    dispatch_queue_t queue = dispatch_queue_create("my.queue", DISPATCH_QUEUE_SERIAL);
    //    dispatch_async(queue, ^(){
    NSLog(@"[%@][%@] timerFireMethodB",[NSThread currentThread], myRunLoop.currentMode);
    [NSThread sleepForTimeInterval:2];
    //    });
}

@end

