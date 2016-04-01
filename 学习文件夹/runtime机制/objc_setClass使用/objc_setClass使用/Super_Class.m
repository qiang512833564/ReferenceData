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
static void *RACSubclassAssociationKey = &RACSubclassAssociationKey;
- (void)initialize{
#pragma mark --- 下面是通过runtime，实现对Super_Class的事件buttonAction方法的IMP改变为_objc_msgForward，触发其事件转发链，然后调用forwardInvocation:方法，再自定义forwardInvocation:方法的IMP,来达到目的（需要注意的是：中间创建了一个类对象，这个类对象，就是充当媒介的作用，用于给其Super_Class添加相应Selector方法,另外主要注意object_setClass方法，其方法第一个参数是一个id obj实例对象，第二个参数是强制把第一个参数id obj转换成改类型class,这也是可以实现对Super_Class添加方法的最根本所在）
    Class subclass = objc_getAssociatedObject(self, RACSubclassAssociationKey);
    if(subclass != nil){
        return;
    }
    //objc_getClass这个方法，也是从runtime里面去取Class,是与objc_setClass相对应的
    subclass = objc_getClass("My_subclass");
    if (subclass == nil ) {
        
        subclass = objc_allocateClassPair([self class], "My_subclass", 0);
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
            //注意这里，如果需要用的另外一个实例对象，则需要通过runtime的objc_setAssociatedObject、objc_getAssociatedObject来实现！如果该实例对象不是self，所拥有，则需要每次都在if (subclass == nil ){}判断语句外，进程class_replaceMethod操作
            invocation.target = self;
            invocation.selector = newSelector;
            [invocation invoke];
            
        };
        
        class_replaceMethod(subclass, @selector(forwardInvocation:), imp_implementationWithBlock(newMethod), "v@:@");
        
        objc_registerClassPair(subclass);
    }
    
    
    object_setClass(self , subclass);
    objc_setAssociatedObject(self, RACSubclassAssociationKey, subclass, OBJC_ASSOCIATION_ASSIGN);
    
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
