//
//  main.m
//  objc_setClass使用
//
//  Created by lizhongqiang on 16/3/30.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Super_Class.h"
#import <objc/runtime.h>
#import <objc/message.h>
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Super_Class *class = [[Super_Class alloc]init];
        [class initialize];
        Method method = class_getInstanceMethod([class class], NSSelectorFromString(@"addMethod"));
        
        
        //id method_invoke(id receiver, Method m, ...)
        ((id(*)(id,Method))method_invoke)(class,method);
        //id objc_msgSend(id self, SEL op, ...)
        [class buttonAction];
//        ((id (*) (id, SEL)) objc_msgSend)( class, NSSelectorFromString(@"buttonAction"));
        
        
        class = [[Super_Class alloc]init];
        [class initialize];
        method = class_getInstanceMethod([class class], NSSelectorFromString(@"addMethod"));
        
        
        //id method_invoke(id receiver, Method m, ...)
        ((id(*)(id,Method))method_invoke)(class,method);
        //id objc_msgSend(id self, SEL op, ...)
        [class buttonAction];
    }
    return 0;
}
