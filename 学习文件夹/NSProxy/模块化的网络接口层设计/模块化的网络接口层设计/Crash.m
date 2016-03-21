//
//  Crash.m
//  模块化的网络接口层设计
//
//  Created by lizhongqiang on 16/3/17.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "Crash.h"

@implementation Crash
- (void)forwardInvocation:(NSInvocation *)invocation {
    void *null = NULL;
    [invocation setReturnValue:&null];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}
@end
