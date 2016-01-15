//
//  NSObject+MJMember.m
//  多层嵌套模型KVC
//
//  Created by lizhongqiang on 15/10/14.
//  Copyright (c) 2015年 lizhongqiang. All rights reserved.
//

#import "NSObject+MJMember.h"

@implementation NSObject (MJMember)

- (void)enumerateIvarsWithBlock:(MJIvarsBlock)block{
    [self enumerateClassesWithBlock:^(__unsafe_unretained Class c, BOOL *stop) {
        unsigned int outCount=0;
        Ivar *ivars=class_copyIvarList(c, &outCount);
        
        for(int i=0; i<outCount; i++)
        {
            MJIvar *ivar = [[MJIvar alloc]initMJIvar:ivars[i] scrObject:self];
            block(ivar,stop);
        }
        
        free(ivars);
    }];
}
- (void)enumerateClassesWithBlock:(MJClassesBlock)block
{
    if(block==nil)return;
    
    BOOL stop = NO;
    
    Class c= [self class];
    
    block(c,&stop);
    
    
}
@end
