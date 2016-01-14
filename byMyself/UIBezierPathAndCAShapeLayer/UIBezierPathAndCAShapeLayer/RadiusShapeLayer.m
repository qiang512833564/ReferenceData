//
//  RadiusShapeLayer.m
//  UIBezierPathAndCAShapeLayer
//
//  Created by lizhongqiang on 15/7/24.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "RadiusShapeLayer.h"

@implementation RadiusShapeLayer

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        CAShapeLayer *layer = [CAShapeLayer layer];
        //layer.frame = CGRectMake(0, 0, 80, 80);
        layer.backgroundColor = [UIColor purpleColor].CGColor;
        layer.fillColor = [UIColor redColor].CGColor;
        layer.path = [self bezierPath];
        [self.layer addSublayer:layer];
        //self.layer.mask = layer;//是剪掉layer以外的内容
        //self.backgroundColor = [UIColor purpleColor];
    }
    return self;
}
- (CGPathRef)bezierPath
{
     CGMutablePathRef path = CGPathCreateMutable();
    /*
     //根据矩形框的内切圆画曲线
     + (UIBezierPath *)bezierPathWithOvalInRect:(CGRect)rect
     
     //在矩形中，可以针对四角中的某个角加圆角
     + (UIBezierPath *)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii
     
     //以某个中心点画弧线
     
     + (UIBezierPath *)bezierPathWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;
     参数：
     center:弧线中心点的坐标
     radius:弧线所在圆的半径
     startAngle:弧线开始的角度值
     endAngle:弧线结束的角度值
     clockwise:是否顺时针画弧线
     */
#if 0
    UIBezierPath *cornerPath1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, self.bounds.size.height) radius:40 startAngle:-M_PI_2 endAngle:0 clockwise:YES];
    UIBezierPath *cornerPath2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width, self.bounds.size.height) radius:40 startAngle:-M_PI_2  endAngle:0 clockwise:YES];
    [path appendPath:cornerPath1];
    [path appendPath:cornerPath2];
#endif
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, 0, self.bounds.size.height - 20);
    CGPathAddArc(path, NULL, 0, self.bounds.size.height, 20,  -M_PI_2, 0, NO);
    //CGPathMoveToPoint(path, NULL, 10, self.bounds.size.height);
    CGPathAddLineToPoint(path, NULL, self.bounds.size.width-20, self.bounds.size.height);
    CGPathAddArc(path, NULL, self.bounds.size.width, self.bounds.size.height, 20,  -M_PI, -M_PI_2, NO);
    CGPathAddLineToPoint(path, NULL, self.bounds.size.width, 0);
    CGPathAddLineToPoint(path, NULL, 0, 0);
    //CGPathCloseSubpath(path);
//   [path addLineToPoint:CGPointMake(0, self.bounds.size.height - 40)];
//  // [path addArcWithCenter:CGPointZero radius:40 startAngle:0 endAngle:-M_PI_2 clockwise:NO];
//    [path addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
//    [path addLineToPoint:CGPointMake(self.bounds.size.width, 0)];
//    //path addl
//   [path closePath];
    
    return path;
}
/*
 UIBezierPath贝塞尔弧线常用方法记 (2012-09-19 21:34:56)转载▼
 分类： IOS相关
 //根据一个矩形画曲线
 + (UIBezierPath *)bezierPathWithRect:(CGRect)rect
 
 //根据矩形框的内切圆画曲线
 + (UIBezierPath *)bezierPathWithOvalInRect:(CGRect)rect
 
 //根据矩形画带圆角的曲线
 + (UIBezierPath *)bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius

 

 
 //画二元曲线，一般和moveToPoint配合使用
 - (void)addQuadCurveToPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint
 参数：
 endPoint:曲线的终点
 controlPoint:画曲线的基准点
 
 //以三个点画一段曲线，一般和moveToPoint配合使用
 - (void)addCurveToPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2
 参数：
 endPoint:曲线的终点
 controlPoint1:画曲线的第一个基准点
 controlPoint2:画曲线的第二个基准点

 */
//+ (Class)layerClass
//{
//    return [CAShapeLayer class];
//}

@end
