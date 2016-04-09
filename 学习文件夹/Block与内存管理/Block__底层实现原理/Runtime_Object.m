//
//  Runtime_Object.m
//  Block
//
//  Created by lizhongqiang on 16/3/26.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "Runtime_Object.h"
#import <objc/runtime.h>
typedef  void (^block) ();
@implementation Runtime_Object

- (instancetype)init{
    if (self = [super init]) {
        NSArray *array = getBlockArray();
        //NSLog(@"%@",array);
        block first = [[array firstObject]copy];
        first();
    }
    return self;
}
//一个例子就了然，返回的数组里面的 block 是不可用的，需要再手动拷贝一次才可以，这个较为简单，就不作过多解释。
//个人理解：这是因为@autoreleasepool自动释放池，释放的对象仅仅只是堆中的变量，而当NSArray里面存放的是_NSConcreteStackBlock类型的Block的时候（_NSConcreteStackBlock存放在栈中，其生命周期由编译器来控制），会出现野指针错误。
NSArray * getBlockArray(void){
    int val = 10;
    
    return [[NSArray alloc] initWithObjects:
            [^{NSLog(@"blk0:%d",val);} copy],
            [^{NSLog(@"blk1:%d", val);} copy], nil];
}
@end
