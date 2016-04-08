//
//  CALayer_drawsAsynchronously.m
//  CATiledLayer与CALayer
//
//  Created by lizhongqiang on 16/4/6.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "CALayer_drawsAsynchronously.h"
@interface CALayer_drawsAsynchronously ()
@property (nonatomic, strong) CALayer *drawsAsynchronously;
@end
@implementation CALayer_drawsAsynchronously

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    NSLog(@"CALayer_drawsAsynchronously = %@",[NSThread currentThread]);
}
- (void)drawRect:(CGRect)rect{
    NSLog(@"CALayer_drawsAsynchronously = %@",[NSThread currentThread]);
}

@end
