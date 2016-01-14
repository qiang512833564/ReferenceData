//
//  Custom.m
//  Test
//
//  Created by lizhongqiang on 15/12/18.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "Custom.h"

@implementation Custom
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)drawRect:(CGRect)rect{
#if 0
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0.5, 0.5, 0.5, 0.5);//线条颜色
    CGContextMoveToPoint(context, 20, 20);
    CGContextAddLineToPoint(context, 200,20);
    CGContextStrokePath(context);
#endif
#if 1
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, 0, 10);
    CGContextAddLineToPoint(ctx, 320, 10);
    CGContextSetLineWidth(ctx, 0.5);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokePath(ctx);//CGContextStrokePath(ctx);//CGContextFillPath不能够用于画线的线条绘制，而是仅仅是针对于一定的线条围城的区域
#endif
#if 0
    CGContextRef con = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(con, [UIColor blueColor].CGColor);
    
    CGContextFillRect(con, rect);
    
    CGContextClearRect(con, CGRectMake(0,0,30,30));
#endif
}
@end
