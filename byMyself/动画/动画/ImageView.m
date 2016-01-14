//
//  ImageView.m
//  动画
//
//  Created by lizhongqiang on 15/8/31.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ImageView.h"

@implementation ImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, CGRectGetWidth(rect)/2.f, CGRectGetHeight(rect)/2.f);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetLineWidth(ctx, 0.5);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blueColor].CGColor);
    CGContextDrawPath(ctx, kCGPathStroke);
    
}
@end
