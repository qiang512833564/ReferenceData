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
#pragma mark -NSMethodSignature是method的参数和返回值类型的描述，以便于后面生成NSInvocation对象，同时NSMethodSignature的信息也有利于NSInvocation去合理的分配参数和给返回值留适当的空间内存，（任何一个方法method被调用的时候，都会生成一个签名）
/*
 [super methodSignatureForSelector:aSelector]内部应该会实现对aSelector是否有IMP与之对应，做出判断
 当没有IMP与aSelector相对应的时候，也就没有method存在，此时系统会调用doesNotRecognizeSelector方法，产生crash
 
 其中Method的结构体如下：
 struct objc_method {
         SEL method_name                                          OBJC2_UNAVAILABLE;
         char *method_types                                       OBJC2_UNAVAILABLE;
         IMP method_imp                                           OBJC2_UNAVAILABLE;
 }
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    NSLog(@"%@",signature);
    return signature;
}
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    
    NSLog(@"%s",__func__);
    [super forwardInvocation:anInvocation];
}
@end
