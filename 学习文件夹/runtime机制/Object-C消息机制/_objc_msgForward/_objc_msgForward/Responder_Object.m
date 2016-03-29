//
//  Responder_Object.m
//  _objc_msgForward
//
//  Created by lizhongqiang on 16/3/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "Responder_Object.h"

@implementation Responder_Object

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    NSLog(@"%s",__func__);
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
    id target = [super forwardingTargetForSelector:aSelector];
    return target;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    return [super methodSignatureForSelector:aSelector];
}
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    [super forwardInvocation:anInvocation];
}
@end
