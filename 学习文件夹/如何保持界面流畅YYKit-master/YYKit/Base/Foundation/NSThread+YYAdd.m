//
//  NSThread+YYAdd.h
//  YYKit <https://github.com/ibireme/YYKit>
//
//  Created by ibireme on 15/7/3.
//  Copyright (c) 2015 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "NSThread+YYAdd.h"
#import <CoreFoundation/CoreFoundation.h>

@interface NSThread_YYAdd : NSObject @end
@implementation NSThread_YYAdd @end

#if __has_feature(objc_arc)
#error This file must be compiled without ARC. Specify the -fno-objc-arc flag to this file.
#endif

static NSString *const YYNSThreadAutoleasePoolKey = @"YYNSThreadAutoleasePoolKey";
static NSString *const YYNSThreadAutoleasePoolStackKey = @"YYNSThreadAutoleasePoolStackKey";
/*
 栈：
 由操作系统自动分配释放，
 使用的是一级缓存，他们通常都是被调用时处于存储空间中，调用完毕立即释放
 是一种先进后出的数据结构
 */
static inline void YYAutoreleasePoolPush() {//创建一个自动释放池，并把它加到栈中
    NSMutableDictionary *dic =  [NSThread currentThread].threadDictionary;
    NSMutableArray *poolStack = dic[YYNSThreadAutoleasePoolStackKey];
    
    if (!poolStack) {
        CFArrayCallBacks callbacks = {0};
        poolStack = (id)CFArrayCreateMutable(CFAllocatorGetDefault(), 0, &callbacks);
        dic[YYNSThreadAutoleasePoolStackKey] = poolStack;
        CFRelease(poolStack);
    }
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init]; //< create
    [poolStack addObject:pool]; // push
}

static inline void YYAutoreleasePoolPop() {//从栈中，移除最后一个自动释放迟
    NSMutableDictionary *dic =  [NSThread currentThread].threadDictionary;
    NSMutableArray *poolStack = dic[YYNSThreadAutoleasePoolStackKey];
    NSAutoreleasePool *pool = [poolStack lastObject];
    [poolStack removeLastObject]; // pop
    [pool release]; //< release, may get warning in analyze...
}

static void YYRunLoopAutoreleasePoolObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    switch (activity) {
        case kCFRunLoopEntry: {
            YYAutoreleasePoolPush();
        } break;
        case kCFRunLoopBeforeWaiting: {
            YYAutoreleasePoolPop();
            YYAutoreleasePoolPush();
        } break;
        case kCFRunLoopExit: {
            YYAutoreleasePoolPop();
        } break;
        default: break;
    }
}

static void YYRunloopAutoreleasePoolSetup() {
    static dispatch_once_t onceToken;//线程加锁，确保，这里的代码，只能被执行一次，且同时只能存在一个线程
    dispatch_once(&onceToken, ^{
        CFRunLoopRef runloop = CFRunLoopGetCurrent();

        CFRunLoopObserverRef pushObserver;
        pushObserver = CFRunLoopObserverCreate(CFAllocatorGetDefault(),
                                               kCFRunLoopEntry,
                                               true,         // repeat
                                               -0x7FFFFFFF,  // before other observers
                                               YYRunLoopAutoreleasePoolObserverCallBack, NULL);
        CFRunLoopAddObserver(runloop, pushObserver, kCFRunLoopCommonModes);
        CFRelease(pushObserver);

        CFRunLoopObserverRef popObserver;
        popObserver = CFRunLoopObserverCreate(CFAllocatorGetDefault(),
                                              kCFRunLoopBeforeWaiting | kCFRunLoopExit,
                                              true,        // repeat
                                              0x7FFFFFFF,  // after other observers
                                              YYRunLoopAutoreleasePoolObserverCallBack, NULL);
        CFRunLoopAddObserver(runloop, popObserver, kCFRunLoopCommonModes);
        CFRelease(popObserver);
    });
}

@implementation NSThread (YYAdd)

+ (void)addAutoreleasePoolToCurrentRunloop {
    if ([NSThread isMainThread]) return; // The main thread already has autorelease pool.
    NSThread *thread = [self currentThread];
    if (!thread) return;
    if (thread.threadDictionary[YYNSThreadAutoleasePoolKey]) return; // already added
    YYRunloopAutoreleasePoolSetup();
    thread.threadDictionary[YYNSThreadAutoleasePoolKey] = YYNSThreadAutoleasePoolKey; // mark the state
}

@end
