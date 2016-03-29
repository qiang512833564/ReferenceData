//
//  NSObject+_objc_msgForward.m
//  _objc_msgForward
//
//  Created by lizhongqiang on 16/3/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "NSObject+_objc_msgForward.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation NSObject (_objc_msgForward)

void msgSendImpletion(id target){
    
    ((void(*)(id, SEL))objc_msgSend)(target, @selector(forwardSelector));
}
- (void)forwardSelector{
    NSLog(@"%s",__func__);
}

//_objc_msgForward就是会向forwardingTargetForSelector、methodSignatureForSelector、forwardInvocation这三个方法发送消息调用，因此，如果一个自定义方法的实现被替换成了_objc_msgForward，则会跳过resolveInstanceMethod方法，使得其无法被调用
+ (void)load{
    
    class_replaceMethod(self, @selector(sendMessage), (IMP)msgSendImpletion, "v@:");
    
    IMP msgForwardIMP = _objc_msgForward;
    
    class_replaceMethod(self, NSSelectorFromString(@"forwardSelector"), msgForwardIMP, "v@:");
}

- (void)sendMessage{
    NSLog(@"%s",__func__);
    
}

@end
