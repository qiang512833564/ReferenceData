//
//  MainThread.m
//  NSMessagePort
//
//  Created by lizhongqiang on 16/4/14.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "MainThread.h"

@interface MainThread () <NSPortDelegate>

@end

@implementation MainThread

MainThread *mainThread;
/*
 实例对象的初始化
 static void OBJC_CLASS_SETUP_$_MainThread(void ) {
	OBJC_METACLASS_$_MainThread.isa = &OBJC_METACLASS_$_NSObject;
	OBJC_METACLASS_$_MainThread.superclass = &OBJC_METACLASS_$_NSObject;
	OBJC_METACLASS_$_MainThread.cache = &_objc_empty_cache;
	OBJC_CLASS_$_MainThread.isa = &OBJC_METACLASS_$_MainThread;
	OBJC_CLASS_$_MainThread.superclass = &OBJC_CLASS_$_NSObject;
	OBJC_CLASS_$_MainThread.cache = &_objc_empty_cache;
 }
 分配内存空间
 #pragma section(".objc_inithooks$B", long, read, write)
 __declspec(allocate(".objc_inithooks$B")) static void *OBJC_CLASS_SETUP[] = {
	(void *)&OBJC_CLASS_SETUP_$_MainThread,
 };
 */
+ (void)startMainThread{
    mainThread = [[MainThread alloc]init];
    [mainThread config];
}

- (void)config{
    NSMessagePort *localPort = [[NSMessagePort alloc]init];
    
    [localPort setDelegate:self];
    
    BOOL isSetVaild = CFMessagePortSetName((CFMessagePortRef)localPort, CFSTR("name_one"));
    
    BOOL isValid = CFMessagePortIsValid((CFMessagePortRef)localPort);
    
    [[NSRunLoop currentRunLoop] addPort:localPort forMode:NSDefaultRunLoopMode];
    
    NSString *localPortName = [NSString stringWithFormat:@"MyPortName"];
    
    [[NSMessagePortNameServer sharedInstance]registerPort:localPort name:localPortName];
    
    [[NSRunLoop currentRunLoop]run];
}
- (void)handlePortMessage:(NSPortMessage *)message{
    
}
@end
