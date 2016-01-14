//
//  CGContextEOClip.m
//  MyPrograme
//
//  Created by lizhongqiang on 16/1/5.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "CGContextEOClip.h"
/*
 CGContextEOClip    修改当前剪贴路径，使用奇偶规则
 奇偶规则：
 从两个区域共有部分的中心点向外射出一条指向无限远的射线，记录其射线与两区域边界的交点，若交点为奇数，则该点是在曲线上的点，若交点个数为偶数，则该点是在曲线外的点
 */
@implementation My_CGContextEOClip
- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextMoveToPoint(context, width/2.f, 0);
    CGContextAddLineToPoint(context, width, height/2.f);
    CGContextAddLineToPoint(context, width/2.f, height);
    CGContextAddLineToPoint(context, 0, height/2.f);
    CGContextClosePath(context);
    //
    //加入矩形边框并调用CGContextEOClip函数
    CGContextAddRect(context, CGContextGetClipBoundingBox(context));
    CGContextEOClip(context);
    
    CGContextAddRect(context, CGContextGetClipBoundingBox(context));
    CGContextFillPath(context);
}
@end
