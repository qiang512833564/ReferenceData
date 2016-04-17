//
//  MainThread.m
//  Mach Port
//
//  Created by lizhongqiang on 16/4/14.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "MainThread.h"
#import "SubThread.h"

#define kCheckinMessage 100

@interface MainThread ()<NSPortDelegate>

@end

@implementation MainThread

MainThread *mainThread;

+ (void)startMainThread{
    mainThread  = [[MainThread alloc]init];
    [mainThread launchThread];
}

- (void)launchThread {
    NSPort *myPort = [NSMachPort port];
    if (myPort) {
        [myPort setDelegate:self];
        
        [[NSRunLoop currentRunLoop] addPort:myPort forMode:NSDefaultRunLoopMode];
        
        [NSThread detachNewThreadSelector:@selector(LaunchThreadWithPort:) toTarget:[SubThread class] withObject:myPort];
        
        [[NSRunLoop currentRunLoop]run];//If no input sources or timers are attached to the run loop, this method exits immediately;
    }
    
}

- (void)handlePortMessage:(NSPortMessage *)portMessage{
    unsigned int message = [portMessage msgid];
    
    NSLog(@"收到的message = %u，component = %@",message,portMessage.components);
    
    NSPort *distantPort = nil;
    
    if (message == kCheckinMessage) {
        distantPort = [portMessage sendPort];
        
        // Retain and save the worker port for later use.
        // [self storeDistantPort:distantPort];

    }
}

@end
