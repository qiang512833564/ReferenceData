//
//  CalculateManager.m
//  ReactiveCocoa框架使用
//
//  Created by lizhongqiang on 16/1/23.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "CalculateManager.h"
@implementation CalculateManager

- (CalculateManager *(^)(int))add{
    /*
     这是不带返回值的block函数
     ^(int value){
     };
     */
    return ^CalculateManager *(int value){
        _result += value;
        return self;
    };
//    return ^(int value){
//        return self;
//    };
}

@end
