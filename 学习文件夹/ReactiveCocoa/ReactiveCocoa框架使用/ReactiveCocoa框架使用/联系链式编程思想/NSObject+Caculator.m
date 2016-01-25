//
//  NSObject+Caculator.m
//  ReactiveCocoa框架使用
//
//  Created by lizhongqiang on 16/1/23.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "NSObject+Caculator.h"

@implementation NSObject (Caculator)

+ (int)makeCaculators:(void (^)(CalculateManager *))block{
    CalculateManager *mgr = [[CalculateManager alloc]init];
    block(mgr);
    return mgr.result;
}

@end
