//
//  NSObject+Modal.m
//  _cmd
//
//  Created by lizhongqiang on 15/11/6.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "NSObject+Modal.h"
#import <objc/runtime.h>
@implementation NSObject (Modal)
- (NSString *)associatedObject_copy{
    NSLog(@"_cmd:%@",NSStringFromSelector(_cmd));//_cmd在Objective-C的方法中表示当前方法的selector，正如同self表示当前方法调用的对象实例。
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setAssociatedObject_copy:(NSString *)associatedObject_copy{
    objc_setAssociatedObject(self, @selector(associatedObject_copy), associatedObject_copy, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark -  Class Associated Objects

//+ (NSString *)associatedObject {
//    return objc_getAssociatedObject([self class], _cmd);
//}
//
//+ (void)setAssociatedObject:(NSString *)associatedObject {
//    objc_setAssociatedObject([self class], @selector(associatedObject), associatedObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
@end
