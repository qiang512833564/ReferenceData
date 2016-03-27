//
//  NSObject+CYLRunAtDealloc.m
//  Runtime实现weak
//
//  Created by lizhongqiang on 16/3/27.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "NSObject+CYLRunAtDealloc.h"
#import <objc/runtime.h>
#import "CYLBlockExecutor.h"
@implementation NSObject (CYLRunAtDealloc)

- (void)cyl_runAtDealloc:(id)block{
    if (block) {
        CYLBlockExecutor *executor = [[CYLBlockExecutor alloc]initWithBlock:block];
        
        objc_setAssociatedObject(self, @"my_runAtDeallocBlockKey", executor, OBJC_ASSOCIATION_RETAIN);
       
        
    }
}
- (void)setObject:(NSObject *)object{
    objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_RETAIN);
    
    __weak NSObject *weak = self;
    
    [object cyl_runAtDealloc:^{
        NSLog(@"nil操作");
        weak.object = nil;
    }];
}

- (NSObject *)object{
    return objc_getAssociatedObject(self, @selector(setObject:));
}

@end
