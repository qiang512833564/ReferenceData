//
//  Super_Class.m
//  objc_setClass使用
//
//  Created by lizhongqiang on 16/3/30.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "Super_Class.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation Super_Class

- (void)initialize{
#pragma mark --- 下面是通过runtime，实现对Super_Class的事件buttonAction方法的IMP改变为_objc_msgForward，触发其事件转发链，然后调用forwardInvocation:方法，再自定义forwardInvocation:方法的IMP,来达到目的（需要注意的是：中间创建了一个类对象，这个类对象，就是充当媒介的作用，用于给其Super_Class添加相应Selector方法,另外主要注意object_setClass方法，其方法第一个参数是一个id obj实例对象，第二个参数是强制把第一个参数id obj转换成改类型class,这也是可以实现对Super_Class添加方法的最根本所在）
    Class subclass = objc_allocateClassPair([self class], "My_subclass", 0);
    if (subclass == nil) {
        return ;
    }
    
    id addMethod = ^(id self){
        NSLog(@"新添加的方法");
    };
    
    class_addMethod(subclass, NSSelectorFromString(@"addMethod"), imp_implementationWithBlock(addMethod), "v@");
    //原Method
    Method targetMethod = class_getInstanceMethod(subclass, @selector(buttonAction));
    
    //新selector
    SEL newSelector = NSSelectorFromString(@"newSelector");
    class_addMethod(subclass, newSelector, method_getImplementation(targetMethod), method_getTypeEncoding(targetMethod));
    
    //新Method
    id newMethod = ^(id self,NSInvocation *invocation){
        NSLog(@"新方法");
        invocation.target = self;
        invocation.selector = newSelector;
        [invocation invoke];
        
    };
    
    
    class_replaceMethod(subclass, @selector(forwardInvocation:), imp_implementationWithBlock(newMethod), "v@:@");
    
    objc_registerClassPair(subclass);
    
    object_setClass(self , subclass);
    
    
    class_replaceMethod([subclass class], @selector(buttonAction), _objc_msgForward, "v@:@");
}

#pragma mark --- 注意当调用一个方法，没有实现IMP的时候，在这个方法，系统就会调用doesNotRecognizeSelector:方法，以使程序终止
#pragma mark --- 但是当调用的方法，其实在.m文件里有实现，可以动态使其IMP改为_objc_msgForward，以使方法进入事件转发链中，虽然会进入了事件转发链，但是在这里并不会像.m文件里没有IMP实现的方法一样在这里发出doesNotRecognizeSelector:信号
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    
}

- (void)buttonAction{
    NSLog(@"buttonAction");
}

@end
