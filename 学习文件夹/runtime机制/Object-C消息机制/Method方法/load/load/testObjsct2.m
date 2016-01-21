//
//  testObjsct2.m
//  load
//
//  Created by lizhongqiang on 15/11/6.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "testObjsct2.h"
#import <objc/runtime.h>
@interface testObjsct2(){
    NSString *_privateName;
}
@end
@implementation testObjsct2
+(void)load
{
    NSLog(@"testObjsct2--------%@",NSStringFromSelector(_cmd));
}
+ (void)initialize
{
    NSLog(@"testObjsct2---------%@",NSStringFromSelector(_cmd));
}
- (instancetype)init
{
    if(self = [super init]){
        _privateName = @"Steve";
    }
    return self;
}
@end
NSString *nameGetter(id self,SEL _cmd){
    Ivar ivar = class_getInstanceVariable([testObjsct2 class], "_privateName");
    return object_getIvar(self, ivar);
}

void nameSetter(id self, SEL _cmd, NSString *newName){
    Ivar ivar = class_getInstanceVariable([testObjsct2 class], "_privateName");
    id oldName = object_getIvar(self, ivar);
    if(oldName != newName) object_setIvar(self, ivar, [newName copy]);
}



