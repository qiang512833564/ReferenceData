//
//  DynamicCellLine.m
//  rrmj个人主页
//
//  Created by lizhongqiang on 15/8/26.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "DynamicCellLine.h"

@implementation DynamicCellLine

- (void)awakeFromNib
{
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(ctx, 0, 0);
    
    CGContextAddLineToPoint(ctx, self.bounds.size.width, 0);
    
    CGContextSetLineWidth(ctx, 0.5);
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor lightGrayColor].CGColor);
    
    CGContextStrokePath(ctx);
    
    CGContextDrawPath(ctx, kCGPathStroke);
    
}


@end
