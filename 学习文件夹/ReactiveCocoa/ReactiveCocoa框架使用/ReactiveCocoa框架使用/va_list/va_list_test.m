//
//  va_list_test.m
//  ReactiveCocoa框架使用
//
//  Created by lizhongqiang on 16/1/23.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "va_list_test.h"

@implementation va_list_test
/*
 在调用的时候要在参数结尾的时候加 nil，回想下 [NSMutableArray arrayWithObjects: 1, 2, 3, nil] 这个构造过程，最后一个 nil 能让 va_arg 取参数时碰到 nil 则断定为 NO，终止循环
 为何像 NSLog 调用不需要最后一个 nil？
 */
- (instancetype)setNameWithFormat:(NSString *)format, ... {
    //if (getenv("RAC_DEBUG_SIGNAL_NAMES") == NULL) return self;
    NSLog(@"%ld----%@",format.length,format);
    NSCParameterAssert(format != nil);
    
    va_list args;//定义一个指向个数可变的参数列表指针
    va_start(args, format);//使参数列表指针va_list指向参数列表中的第一个可选参数。
                           //函数参数列表中参数在内存中的顺序与函数申明使的顺序一致。
    
    NSString *str = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    self.name = str;
    
    NSString *eachArg;
    va_list argList;
    if(format){
        va_start(argList, format);//// 从 format 开始遍历参数，不包括 format 本身.
        
        while ((eachArg = va_arg(argList, NSString *))!=nil) {//
            //va_arg(argList,id)：返回参数列表中指针va_ist所指的参数，返回类型为type，并使指针va_list指向参数列表中下一个参数。
            // 从 args 中遍历出参数，NSString* 指明类型
            NSLog(@"%@",eachArg);// 打印出每一个参数.
        }
        va_end(argList);//清空参数列表，并置参数指针va_list无效
    }
    
    return self;
}
@end
