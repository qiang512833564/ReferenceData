//
//  NSObject+MyTestObjsct.m
//  load
//
//  Created by lizhongqiang on 15/11/6.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "NSObject+MyTestObjsct.h"
#import <objc/runtime.h>
@implementation NSObject (MyTestObjsct)
+ (void)load
{
    NSLog(@"Category------%@",NSStringFromSelector(_cmd));
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method reloadData = class_getInstanceMethod(self, @selector(reloadData));
        Method sd_reloadData = class_getInstanceMethod(self, @selector(sd_reloadData));
        method_exchangeImplementations(reloadData, sd_reloadData);
    });
}
/*
 136.关键字：_cmd与宏__func__的区别：
 __func__宏确实是该方法的名称
 而
 _cmd关键字则是方法实现对应的名称
 在Objective-C中调用一个方法，其实是向一个对象发送消息，查找消息的唯一依据是selector的名字。利用Objective-C的动态特性，可以实现在运行时偷换selector对应的方法实现，达到给方法挂钩的目的。
 每个类都有一个方法列表，存放着selector的名字和方法实现的映射关系。IMP有点类似函数指针，指向具体的Method实现。
 */
- (void)reloadData{
    NSLog(@"Category-------%@-------%s",NSStringFromSelector(_cmd),__func__);
}
- (void)sd_reloadData{
    NSLog(@"Category-------%@",NSStringFromSelector(_cmd));
}

@end
