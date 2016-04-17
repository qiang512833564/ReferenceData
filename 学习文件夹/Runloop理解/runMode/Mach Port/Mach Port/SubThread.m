//
//  SubThread.m
//  Mach Port
//
//  Created by lizhongqiang on 16/4/14.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "SubThread.h"

#define kCheckinMessage 100

@interface SubThread () <NSPortDelegate>

@property (nonatomic, assign) BOOL shouldExit;

@end

@implementation SubThread

SubThread *workerObj;

+(void)LaunchThreadWithPort:(id)inData {
    
    // Set up the connection between this thread and the main thread.
    NSPort* distantPort = (NSPort*)inData;
    
    workerObj = [[self alloc] init];
    [workerObj sendCheckinMessage:distantPort];
    
    // Let the run loop process things.
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate distantFuture]];
    }
    while (![workerObj shouldExit]);
    
}
// Worker thread check-in method
- (void)sendCheckinMessage:(NSPort*)outPort {
    // Retain and save the remote port for future use.
    // [self setRemotePort:outPort];
    
    // Create and configure the worker thread port.
    NSPort* myPort = [NSMachPort port];
    [myPort setDelegate:self];
    [[NSRunLoop currentRunLoop] addPort:myPort forMode:NSDefaultRunLoopMode];
    
    // Create the check-in message.
    NSPortMessage* messageObj = [[NSPortMessage alloc] initWithSendPort:outPort
                                                            receivePort:myPort components:@[@"信号一枚"]];
    
    if (messageObj) {
        // Finish configuring the message and send it immediately.
        [messageObj setMsgid:kCheckinMessage];
        //messageObj.components = @[@"我只是一个port信号"];
        [messageObj sendBeforeDate:[NSDate date]];
    }
}

@end
