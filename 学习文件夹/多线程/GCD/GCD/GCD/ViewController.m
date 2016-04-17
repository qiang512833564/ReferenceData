//
//  ViewController.m
//  GCD
//
//  Created by lizhongqiang on 16/4/5.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>
@interface ViewController ()

@end

@implementation ViewController
/*
                   同步执行	          异步执行
 串行队列	     当前线程，一个一个执行	    其他线程，一个一个执行
 并行队列	     当前线程，一个一个执行	    开很多线程，一起执行
 
 但是经测试，因为dispatch_get_main_queue()主队列（是串行队列），对应一个主线程，而对于该主线程，已经存在了一个主线程，所以再对dispatch_get_main_queue调用dispatch_async，并不会再创一个线程！
          一个 serial queue 至多有一个线程
          一个 concourrent queue 可以有任意多个线程
         
          sync 与 async 是相对于当前 currentThread 线程来说的
 */
- (void)viewDidLoad {
    [super viewDidLoad];
#if 0
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    
    dispatch_queue_t serial = dispatch_queue_create("tk.bourne.testQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(serial, ^{
        NSLog(@"serial asyn1=%@",[NSThread currentThread]);
    });
    dispatch_async(serial, ^{
        NSLog(@"serial asyn2=%@",[NSThread currentThread]);
    });
    dispatch_sync(serial, ^{
        NSLog(@"serial=%@",[NSThread currentThread]);
    });
    // Do any additional setup after loading the view, typically from a nib.
#endif
#pragma mark --- 测试 dispatch_sync 作用
    NSMutableArray *a = [[NSMutableArray alloc]init];
    dispatch_queue_t q = dispatch_queue_create("com.foo.samplequeue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(q, ^{
        sleep(5);
        NSLog(@"samplequeue");
        [a addObject:@"something"];
    });
    __block NSString *first = nil;
    //use dispatch_sync when you want to execute a block and wait for the results.
    //using a dispatch queue instead of locks for synchronization.
    /*
     dispatch_sync is semantically equivalent to a traditional mutex lock.
     */
    void (^block) (void) = ^{
        if ([a count] > 0) {
            NSLog(@"samplequeue_sync");
            first = [a objectAtIndex:0];
            [a removeObjectAtIndex:0];
        }
    };
//    pthread_mutex_t lock;
//    pthread_mutex_lock(&lock);
//    block();
//    pthread_mutex_unlock(&lock);
    dispatch_sync(q, ^{
        NSLog(@"第二个 block");
    });//这里 dispatch_sync 后的 block 执行，会等待前面创建的 com.foo.samplequeue 串行队列执行完之后，才会执行，而此时，这里的 currentThread (mainThread)会被暂停，一直等到 block 完全被结束(前提是在串行队列上)
    dispatch_barrier_sync(q, block);//dispatch_barrier_sync 在串行队列上，与 dispatch_sync 作用是一样的
    // 一般 dispatch_barrier_sync 是用于并行队列上，具有以下特点：
    // 1. the barrier block 在 concurrent queue 上是 synchronous execution 同步执行的
    // 2. dispatch_barrier_sync 方法所在的线程会被暂停， 直到 the barrier block 完成（当 the barrier block 被加在 concurrent queue 并行队列上的时候，并不会立刻被执行。而是，等到在 the barrier block 之前添加的 block 全部执行完成的时候，才会被执行）
    // 3. 任何在 the barrier block 后添加的 block 在 the barrier block 完成之前，都不会被执行
    
#pragma mark  --- 总结 dispatch_sync 与 dispatch_barrier_sync
    /*
     相同的：
     1、the block 在 queue 上是 synchronous execution 同步执行的
     2、sync 方法所在的线程会被暂停， 直到 the block 完成
     3. 任何在 the block 后添加的 block 在 the block 完成之前，都不会被执行
     4  因此 sync 都是同步被执行，因此都是线程安全的（类似于线程锁，但是效率比一般的 线程锁 高）
     5. 与 async 方法不同的是，在目标 queue 上，没有 no retain is performed 被执行，此外在 the block 里面也没有 Block_copy 操作
     
     不同点：
     1、dispatch_sync 是在 serial 上起作用的
     2、dispatch_barrier_sync 是在 concurrent queue 上起作用的，当 dispatch_barrier_sync 处于 serial queue 上时，其作用等同于 dispatch_sync
     
     */
    NSLog(@"主线程代码执行完成");
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
