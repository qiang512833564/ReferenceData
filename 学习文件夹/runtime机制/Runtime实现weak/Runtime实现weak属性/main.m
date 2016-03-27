//
//  main.m
//  Runtime实现weak属性
//
//  Created by lizhongqiang on 16/3/27.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+CYLRunAtDealloc.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSObject *foo = [[NSObject alloc]init];
        foo.object = [[NSObject alloc]init];
        [foo cyl_runAtDealloc:^{
            NSLog(@"正在释放foo!");
        }];
    }
    return 0;
}
#pragma mark --- 总结：就是利用assign属性，对应的weak属性为objc_storeWeak(&a, b)，如果a是由 assign 修饰的，则： 在 b 非 nil 时，a 和 b 指向同一个内存地址，在 b 变 nil 时，a 还是指向该内存地址，变野指针。此时向 a 发送消息极易崩溃。但是会有风险，所以，我们得在assign修饰的对象释放之后，把其置为Nil,模拟weak的hash表操作
