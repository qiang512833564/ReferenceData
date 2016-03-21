//
//  HttpProxy.m
//  模块化的网络接口层设计
//
//  Created by lizhongqiang on 16/3/17.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "HttpProxy.h"
#import <objc/runtime.h>
@interface HttpProxy ()
@property (strong, nonatomic) NSMutableDictionary *selToHandlerMap;//这个字典，是为了存储，target与selector对应
@end

@implementation HttpProxy
static HttpProxy *instance;
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken ;
    
    dispatch_once(&onceToken, ^{
        instance = [HttpProxy alloc];
        instance.selToHandlerMap = [NSMutableDictionary dictionary];
    });
    return instance;
}
- (void)registerHttpProtocol:(Protocol *)httpProtocol handler:(id)handler{
    unsigned int numberOfMethods = 0;
    
    //获取Protocol的所有方法
    struct objc_method_description *methods = protocol_copyMethodDescriptionList(httpProtocol, YES, YES, &numberOfMethods);
    
    //为Protocol的每个方法注册真正的实现类对象handler
    for (unsigned int i=0; i<numberOfMethods; i++) {
        struct objc_method_description method = methods[i];
        [_selToHandlerMap setValue:handler forKey:NSStringFromSelector(method.name)];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    NSString *methodsName = NSStringFromSelector(sel);
    
    id handler = [_selToHandlerMap valueForKey:methodsName];
    
    if (handler != nil && [handler respondsToSelector:sel]) {
        return [handler methodSignatureForSelector:sel];
    }else{
        return [super methodSignatureForSelector:sel];
    }
}

- (void)forwardInvocation:(NSInvocation *)invocation{
    NSString *methodsName = NSStringFromSelector(invocation.selector);
    id handler = [_selToHandlerMap valueForKey:methodsName];
    
    if (handler != nil && [handler respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:handler];
    }else{
        [super forwardInvocation:invocation];
    }
}

@end
