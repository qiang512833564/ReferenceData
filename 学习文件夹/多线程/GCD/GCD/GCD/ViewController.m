//
//  ViewController.m
//  GCD
//
//  Created by lizhongqiang on 16/4/5.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
/*
                   同步执行	          异步执行
 串行队列	     当前线程，一个一个执行	    其他线程，一个一个执行
 并行队列	     当前线程，一个一个执行	    开很多线程，一起执行
 
 但是经测试，因为dispatch_get_main_queue()主队列（是串行队列），对应一个主线程，而对于该主线程，已经存在了一个主线程，所以再对dispatch_get_main_queue调用dispatch_async，并不会再创一个线程！
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    
    dispatch_queue_t serial = dispatch_queue_create("tk.bourne.testQueue", DISPATCH_QUEUE_SERIAL);
    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
