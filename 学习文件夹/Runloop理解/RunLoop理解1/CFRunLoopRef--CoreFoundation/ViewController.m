//
//  ViewController.m
//  CFRunLoopRef--CoreFoundation
//
//  Created by lizhongqiang on 15/12/4.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSTimer *timer;
@end

@implementation ViewController
- (void)threadMain{// The application uses garbage collection, so no autorelease pool is needed.
    NSRunLoop* myRunLoop = [NSRunLoop currentRunLoop];
    // Create a run loop observer and attach it to the run loop.
    CFRunLoopObserverCallBack myRunLoopObserver;
    CFRunLoopObserverContext context = {0, (__bridge void *)(self), NULL, NULL, NULL};
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault,kCFRunLoopAllActivities, YES, 0, myRunLoopObserver, &context);
    if (observer){
        CFRunLoopRef cfLoop = [myRunLoop getCFRunLoop];CFRunLoopAddObserver(cfLoop, observer, kCFRunLoopDefaultMode);
    }// Create and schedule the timer.
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(doFireTimer:) userInfo:nil repeats:YES];NSInteger loopCount = 10;do{
        // Run the run loop 10 times to let the timer fire.
        [myRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];loopCount--;
    }while (loopCount);
}
void myRunLoopObserver(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    /*
     // 参考：アクティビティの値
     kCFRunLoopEntry = (1UL << 0),
     kCFRunLoopBeforeTimers = (1UL << 1),
     kCFRunLoopBeforeSources = (1UL << 2),
     kCFRunLoopBeforeWaiting = (1UL << 5),
     kCFRunLoopAfterWaiting = (1UL << 6),
     kCFRunLoopExit = (1UL << 7),
     kCFRunLoopAllActivities = 0x0FFFFFFFU
     */
    
    NSMutableArray *flags = [@[] mutableCopy];
    flags[0] = @((activity >> 0) & 1);
    flags[1] = @((activity >> 1) & 1);
    flags[2] = @((activity >> 2) & 1);
    flags[3] = @((activity >> 5) & 1);
    flags[4] = @((activity >> 6) & 1);
    flags[5] = @((activity >> 7) & 1);
    
    NSString *mode = (__bridge NSString *)(CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent()));
    
    RLSampleViewController *obj = (__bridge RLSampleViewController *)info;
    NSLog(@"[%@][%@]myRunLoopObserver activity:%@",[NSThread currentThread],mode ,[obj convertString:flags]);
}
- (void)doFireTimer:(NSTimer *)timer{
    NSLog(@"dadadada");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
    [self threadMain];
    NSTimer *timer = self.timer;
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:timer forMode:NSRunLoopCommonModes];//设置为NSDefaultRunLoopMode模式的时候，滚动tableView定时器就会被暂停，设置为NSRunLoopCommonModes模式，则滚动tableView定时器正常运行
    //[runloop run];
}
- (UITableView *)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSTimer *)timer{
    if(_timer == nil){
        //_timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(runTimer) userInfo:nil repeats:YES];
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runTimer) userInfo:nil repeats:YES];
    }
    return _timer;
}
- (void)runTimer{
    NSLog(@"定时器运行");
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"text";
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
