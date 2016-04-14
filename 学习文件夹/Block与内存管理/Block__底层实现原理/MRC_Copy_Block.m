//
//  MRC_Copy_Block.m
//  Block
//
//  Created by lizhongqiang on 16/3/26.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "MRC_Copy_Block.h"
typedef void (^block) ();
@implementation MRC_Copy_Block
NSObject *global ;
- (instancetype)init{
    self = [super init];
    if (self) {
        global = [[NSObject alloc]init];
        [self copy_test];
    }
    return self;
}

#pragma mark --- 经测试，知道block copy操作的时候，会对使用到的对象retain一次，之后如果该block再进行copy操作，并不会重复对对象retain了（需要注意的是：对 对象进行类似浅拷贝 操作, 与block外面的对象，只是所指向的地址相同，但是却已经是两个不一样的对象了）
- (void)copy_test{
    NSObject *object = [[NSObject alloc]init];
    //1
    __block id middleValue = nil;
    block block = ^{
        NSLog(@"%@---count=%ld",object,[object retainCount]);
        middleValue = object;
    };
    object = [[NSObject alloc]init];
    NSLog(@"%@------%@---count=%ld",object,block,[object retainCount]);
    //2
    block = [block copy];
    block();
    NSLog(@"%@_------%@----count=%ld",object,block,[object retainCount]);
    //3.
    block = [block copy];
    block();
    NSLog(@"%@------%@----count=%ld",object,block,[object retainCount]);
    
    block();
}
@end
