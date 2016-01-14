//
//  MyView.m
//  MyPrograme
//
//  Created by lizhongqiang on 16/1/5.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "MyView.h"

@implementation MyView
- (void)drawRect:(CGRect)rect{
    CGContextRef con = UIGraphicsGetCurrentContext();
    
#if 0    // 在上下文裁剪区域挖一个三角形孔
    CGContextSetFillColorWithColor(con, [UIColor yellowColor].CGColor);
    //CGContextSetStrokeColorWithColor(con, [UIColor redColor].CGColor);
    CGContextSetLineWidth(con, 5);
    CGContextMoveToPoint(con, 90, 100);
    
    CGContextAddLineToPoint(con, 100, 90);
    
    CGContextAddLineToPoint(con, 110, 100);
    
    CGContextClosePath(con);
    //CGContextGetClipBoundingBox方法获取到了需要绘制的图形上下文的位置与大小
    //
    CGContextAddRect(con, CGContextGetClipBoundingBox(con));
    CGContextEOClip(con);//裁剪之后,CGContext的范围为上面CGContextMoveToPoint,CGContextAddRect等方法绘制的图形范围


    NSLog(@"%@",NSStringFromCGRect(CGContextGetClipBoundingBox(con)));

    
    CGContextMoveToPoint(con, 100, 100);
    CGContextAddLineToPoint(con, 100, 19);
    CGContextSetLineWidth(con, 20);
    CGContextReplacePathWithStrokedPath(con);
    CGContextClip(con);
    CGContextAddRect(con, CGContextGetClipBoundingBox(con));
    CGContextFillPath(con);
    // 绘制渐变
    //CGContextStrokePath(con);
#endif
#if 1
    
    CGContextSaveGState(con);
    // 在上下文裁剪区域挖一个三角形孔
    
    CGContextMoveToPoint(con, 90, 100);
    
    CGContextAddLineToPoint(con, 100, 90);
    
    CGContextAddLineToPoint(con, 110, 100);
    
    CGContextClosePath(con);
    
    CGContextAddRect(con, CGContextGetClipBoundingBox(con));
   
    // 使用奇偶规则，裁剪区域为矩形减去三角形区域
    CGContextEOClip(con);
    
    //绘制一个垂线，让它的轮廓形状成为裁剪区域
    
    CGContextMoveToPoint(con, 100, 100);
    
    CGContextAddLineToPoint(con, 100, 19);
    
    CGContextSetLineWidth(con, 20);
    
    // 使用路径的描边版本替换图形上下文的路径
    /*
     使用绘制当前路径时覆盖的区域作为当前CGContextRef
     中的新路径。举例来说，假如当前CGContextRef包含一
     个圆形路径且线宽为10，调用该方法后，当前CGContextRef
     将包含一个环宽为10的环形路径
     */
    
    CGContextReplacePathWithStrokedPath(con);
    
    // 对路径的描边版本实施裁剪
    
    CGContextClip(con);
    
    // 绘制渐变
    
    CGFloat locs[3] = { 0.0, 0.5, 1.0 };
    
    CGFloat colors[12] = {
        
        0.3,0.3,0.3,0.8, // 开始颜色，透明灰
        
        0.0,0.0,0.0,1.0, // 中间颜色，黑色
        
        0.3,0.3,0.3,0.8 // 末尾颜色，透明灰
        
    };
    
    CGColorSpaceRef sp = CGColorSpaceCreateDeviceGray();
    
    CGGradientRef grad = CGGradientCreateWithColorComponents (sp, colors, locs, 3);
    
    CGContextDrawLinearGradient(con, grad, CGPointMake(89,0), CGPointMake(111,0), 0);
    CGContextTranslateCTM(<#CGContextRef  _Nullable c#>, <#CGFloat tx#>, <#CGFloat ty#>)
    CGColorSpaceRelease(sp);
    
    CGGradientRelease(grad);
    
    CGContextRestoreGState(con); // 完成裁剪
    
    // 绘制红色箭头 
    
    CGContextSetFillColorWithColor(con, [[UIColor redColor] CGColor]); 
    
    CGContextMoveToPoint(con, 80, 25); 
    
    CGContextAddLineToPoint(con, 100, 0); 
    
    CGContextAddLineToPoint(con, 120, 25); 
    
    CGContextFillPath(con);
#endif
}
@end
