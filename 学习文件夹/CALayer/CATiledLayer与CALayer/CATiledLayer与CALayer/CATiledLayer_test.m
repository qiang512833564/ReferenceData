//
//  CATiledLayer_test.m
//  CATiledLayer与CALayer
//
//  Created by lizhongqiang on 16/4/6.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "CATiledLayer_test.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation CATiledLayer_test
+ (Class)layerClass{
    return [CATiledLayer class];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    NSLog(@"%@ = %@",[self class],[NSThread currentThread]);//CATiledLayer_test = <NSThread: 0x7f921373c800>{number = 3, name = (null)}
}

@end
