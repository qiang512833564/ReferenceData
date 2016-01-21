//
//  NSObject+Swizzle.m
//  Method方法
//
//  Created by lizhongqiang on 15/11/6.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "NSArray+Swizzle.h"

@implementation NSArray (Swizzle)
- (id)myLastObject{
    id ret = [self myLastObject];
    NSLog(@"********** myLastObject **************");
    return ret;
}
@end
