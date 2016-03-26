//
//  TestObject.m
//  runtime--forwardInvocation
//
//  Created by lizhongqiang on 16/3/8.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//
/*
 我们先来看看正常情况一个消息（方法）执行的过程：
 
 　　　　1. 发送消息如：[self startwork]
 
 　　　　2. 系统会check是否能response这个消息
 
 　　　　3. 如果能response则调用相应方法，不能则抛出异常
 
 　　在第二步中，如果实例本身就有相应的response，那么就会响应之，如果没有,系统就会向实例对象发出methodSignatureForSelector消息，检测它这个消息是否有效？有效就会继续发出forwardInvocation消息，无效则返回nil。如果是nil就会crash。
 */
#import "TestObject.h"

@interface ForwardClass ()
-(void)doSomethingElse;
@end

@implementation ForwardClass

-(void)doSomethingElse
{
    NSLog(@"doSomething was called on %@", [self class]);
}
@end

@interface SomeClass()
{
    id forwardClass;
}

-(void)doSomething;

@end

@implementation SomeClass
+ (void)load{
    Method method = class_getClassMethod(self, @selector(objc_messageForward));
    BOOL addedAlias = class_addMethod(self, NSSelectorFromString(@"_objc_msgForward"), class_getMethodImplementation(self, @selector(objc_messageForward)), method_getTypeEncoding(method));
    if (addedAlias) {
        
    }else{
        class_replaceMethod(self, NSSelectorFromString(@"_objc_msgForward"), class_getMethodImplementation(self, @selector(objc_messageForward)), method_getTypeEncoding(method));
    }
}
- (void)objc_messageForward{
    NSLog(@"%s",__func__);
}
-(id)init
{
    if (self = [super init]) {
        forwardClass = [ForwardClass new];
        
       
    }
    return self;
}
/*
 首先说一下向一个实例发送一个消息后，系统是处理的流程：
 1. 发送消息如：[self startwork]
 2. 系统会check是否能response这个消息
 3. 如果能response则调用相应方法，不能则抛出异常
 在第二步中，系统是如何check实例是否能response消息呢？如果实例本身就有相应的response,那么就会相应之，如果没有系统就会发出methodSignatureForSelector消息，寻问它这个消息是否有效？有效就返回对应的方法地址之类的，无效则返回nil。如果是nil,Runtime则会发出-doesNotRecognizeSelector:消息，程序这时也就挂掉了. 如果不是nil接着发送forwardInvocation消息。
 所以我们在重写methodSignatureForSelector的时候就人工让其返回有效实例。
 */

-(void)doSomething
{
    
    NSLog(@"doSomething was called on %@", [self class]);
    //这段代码阻止子类的实例响应doSomething消息或阻止父类转发doSomething消息—虽然respondsToSelector:仍然报告接收者可以访问doSomething方法。
    [self doesNotRecognizeSelector:_cmd];
    //经测试：子类SubSomeClass会报错-[SubSomeClass doSomething]: unrecognized selector sent to instance 0x7fe452c9a3f0
}
/*
 消息转发有很多的用途，比如：
 创建一个对象负责把消息转发给一个由其它对象组成的响应链，代理对象会在这个有其它对象组成的集合里寻找能够处理该消息的对象；
 把一个对象包在一个logger对象里，用来拦截或者纪录一些有趣的消息调用；
 比如声明类的属性为dynamic，使用自定义的方法来截取和取代由系统自动生成的getter和setter方法。
 */
#pragma mark ----- 先调用
-(NSMethodSignature*)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    if (! signature) {
        //生成方法签名
        signature = [forwardClass methodSignatureForSelector:selector];
    }
    //如果这里返回的方法签名为nil,这会出现debug(unrecognized selector sent to instance)
    return signature;
}
#pragma mark ----- 后调用
/*
 如果你给一个对象发送它不认识的消息时，系统会抛出一个错误，但在错误抛出之前，运行时会给改对象发送forwardInvocation:消息，同时传递一个NSInvocation对象作为该消息的参数，NSInvocation对象包封装原始消息和对应的参数。你可以实现forwardInvocation:方法来对不能处理的消息做一些默认的处理，以避免程序崩溃，但正如该函数的名字一样，这个函数主要是用来将消息转发给其它对象
 forwardInvocation可以用于阻止一个方法被继承
 */
-(void)forwardInvocation:(NSInvocation *)invocation
{
    if (! forwardClass) {
        [self doesNotRecognizeSelector: [invocation selector]];
    }
    [invocation invokeWithTarget: forwardClass];
}
//任何doesNotRecognizeSelector:消息通常都是由运行时系统来发送的。不过，它们可以用于阻止一个方法被继承。
//当然，如果我们要重写doesNotRecognizeSelector:方法，必须调用super的实现，或者在实现的最后引发一个NSInvalidArgumentException异常。它代表对象不能响应消息，所以总是应该引发一个异常。
/*- (void)doesNotRecognizeSelector:(SEL)aSelector{
    
}
*/


@end
