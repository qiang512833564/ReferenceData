//
//  CGContextEOClip.m
//  MyPrograme
//
//  Created by lizhongqiang on 16/1/5.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "CGContextClip.h"
/*
 CGContextClip   修改当前剪贴路径，使用非零绕数规则
 CGContextFillPath 使用的也是非零绕数规则
 
 非绕数规则:
 每一个顺时针方向(曲线从左向右通过射线)上的交点减一，每一个逆时针方向(取消从右向左通过射线)上的交点加1，如果绕组总数为0，表示改点在曲线外；否则，该点在曲线内。
 */
@implementation My_CGContextClip
#pragma mark ---如果想通过CGContextClip裁剪路径的话，就不能在设置路径之后，再调用CGContextFillPath等方法去绘制路径，否则绘制完路径以后，之前设置的裁剪会被重置（会提示 <Error>: clip: empty path.），并且在CGContextClip设置裁剪路径前的CGContextFillPath等绘制路径操作会在界面上保留显示
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
     NSLog(@"%@",NSStringFromCGRect(CGContextGetClipBoundingBox(context)));
    
    CGContextSetLineWidth(context, 1.0);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextAddArc(context, 150, 150, 100, 0, 2 * M_PI, 1);
    CGContextFillPath(context);
#if 1
    // Use first circle as clipping path:
    CGContextAddArc(context, 150, 150, 50, 0, 2 * M_PI, 1);
    //CGContextFillPath(context);
    CGContextClip(context);
    
    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextAddRect(context, CGContextGetClipBoundingBox(context));
    CGContextFillPath(context);
#endif
//    
    NSLog(@"%@",NSStringFromCGRect(CGContextGetClipBoundingBox(context)));
//    // Draw second circle:
     CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextAddArc(context, 200, 150, 50, 0, 2 * M_PI, 1);
//    CGContextFillPath(context);
    CGContextSetFillColorWithColor(context, [UIColor brownColor].CGColor);
    CGContextClip(context);
    CGContextAddRect(context, CGContextGetClipBoundingBox(context));
    CGContextFillPath(context);
    NSLog(@"%@",NSStringFromCGRect(CGContextGetClipBoundingBox(context)));
    //CGContextStrokePath(context);
   
   
}
@end
