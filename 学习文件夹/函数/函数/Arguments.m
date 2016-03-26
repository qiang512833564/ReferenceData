//
//  Arguments.m
//  函数
//
//  Created by lizhongqiang on 16/3/26.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "Arguments.h"

@implementation Arguments

+(instancetype)tupleWithObjects:(id)object,... {
    Arguments *tuple = [[self alloc]init];
    
    va_list args;
    va_start(args, object);
    
    NSUInteger count = 0;
    for (id currentObject = object; currentObject != nil; currentObject = va_arg(args, id)) {
        NSLog(@"object=%@",currentObject);
        ++count;
    }
    
    va_end(args);
    
    return tuple;
}

@end
