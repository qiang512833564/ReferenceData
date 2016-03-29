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
 
 　　在第二步中，如果实例本身就有相应的response，那么就会响应之，如果没有,系统就会向实例对象发出resolveInstanceMethod/methodSignatureForSelector等消息，看有没有为方法通过runtime动态添加实现，检测它这个消息是否有效？有效就会继续发出forwardInvocation消息，无效则返回nil。如果是nil就会crash。
 */
#pragma mark --- 注意，+load/+resolveInstanceMethod默认只会调用一次
#import "TestObject.h"
#import <objc/message.h>
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
void _objc_msgForward(){
    
}
+ (void)load{
    IMP msgForwardIMP = _objc_msgForward;
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
//- (void)doSomethingElse{
//    
//}

void methodImpletion(id self, SEL _cmd){
    
}
#pragma mark --- 最先调用

//This method is called before the Objective-C forwarding mechanism is invoked
//转发机制forwardInvocation方法被调用前调用该方法(前提是：查找 method list，未查到,还有就是
/* IMP msgForwardIMP = _objc_msgForward;
  class_replaceMethod(self, NSSelectorFromString(@"forwardSelector"), msgForwardIMP, "v@:");
   方法本身，的实现不能被_objc_msgForward替换，否则，forwardInvocation方法也不会被调用
)*/
//作用是：在cache和method list中，没有找到方法的实现时，再给一次机会，去动态添加方法的实现
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    class_addMethod(self, sel, (IMP)methodImpletion, "v@:");
    //"v@:" 中， v 表示返回值为 void， @ 表示第一个参数是 id， ： 表示第二个参数类型是 SEL
    return NO;//YES if the method was found and added to the receiver, otherwise NO
    //返回  YES 表示不进行后续的消息转发（即：methodSignatureForSelector、forwardInvocation等方法），会再次查找cache和 method list查找实现部分，如果依然没有找到，则会进入后序的消息转发，
    //返回  NO  则表示要进行后续的消息转发。
    /*
     消息转发分两步。首先，运行时调用-methodSignatureForSelector与-forwardingTargetForSelector:，两个方法就相当于一个是返回方法的method，另一个则根据前者方法返回的method生成相应的NSInvocation,然后再确定target去调用。
     */

}
#pragma mark --- 继resolveInstanceMethod后调用，前提是resolveInstanceMethod返回的是NO
//返回能够相应aSelector的target目标对象
-(id)forwardingTargetForSelector:(SEL)aSelector{
    
    if (aSelector == @selector(doSomethingElse)) {
        return nil;//[ForwardClass new];
    }
    return [super forwardingTargetForSelector:aSelector];
}
/*
 消息转发有很多的用途，比如：
 创建一个对象负责把消息转发给一个由其它对象组成的响应链，代理对象会在这个有其它对象组成的集合里寻找能够处理该消息的对象；
 把一个对象包在一个logger对象里，用来拦截或者纪录一些有趣的消息调用；
 比如声明类的属性为dynamic，使用自定义的方法来截取和取代由系统自动生成的getter和setter方法。
 */
#pragma mark ----- 继forwardingTargetForSelector后调用，前提是forwardingTargetForSelector方法返回的结果，是nil
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

#pragma mark ----- 继methodSignatureForSelector后调用
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
-(void)doSomething
{
    
    NSLog(@"doSomething was called on %@", [self class]);
    //这段代码阻止子类的实例响应doSomething消息或阻止父类转发doSomething消息—虽然respondsToSelector:仍然报告接收者可以访问doSomething方法。
    [self doesNotRecognizeSelector:_cmd];
    //经测试：子类SubSomeClass会报错-[SubSomeClass doSomething]: unrecognized selector sent to instance 0x7fe452c9a3f0
}
@end
