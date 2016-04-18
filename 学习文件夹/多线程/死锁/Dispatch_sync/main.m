//
//  main.m
//  Dispatch_sync
//
//  Created by lizhongqiang on 16/4/16.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
void task2()
{
    NSLog(@"task2: %@", [NSThread currentThread]);
}

void task1(dispatch_queue_t q)
{
    NSLog(@"task1: %@", [NSThread currentThread]);
    
}
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        /*
         dispatch_sync(queue, block) 做了两件事情:
         将 block 添加到 queue 队列；
         阻塞调用线程，等待 block() 执行结束，回到调用线程
         
         main_thread 被阻塞，无法继续执行；
         同步派发 sync 导致 block() 需要在 main_thread 中执行结束才会返回；
         而此时 main_thread 被阻塞，两者互相等待，线程死锁；
         */
        NSLog(@"主线程开始");
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"等待主线程完成");
        });
        NSLog(@"主线程完成");
////        
//         NSLog(@"主线程开始");
//         dispatch_async(dispatch_get_main_queue(), ^{
//         NSLog(@"等待主线程完成");
//         });
//         sleep(5);
//         NSLog(@"主线程完成");
//        do{}while (1) ;
//         CFRunLoopRun();
        
//        dispatch_queue_t q = dispatch_queue_create("serical", DISPATCH_QUEUE_SERIAL);//dispatch_get_global_queue(0, 0);
//        dispatch_async(q, ^{
//            sleep(3);
//            task1(q);
//        });
//        dispatch_sync(q, ^{
//            task2();
//        });
//        dispatch_main();
    }
    return 0;
}
