//
//  ViewController.m
//  UIBezierPath
//
//  Created by lizhongqiang on 16/1/8.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = myPath(CGPointMake(40, 100+160), CGPointMake(200, 100), 10).CGPath;
    layer.fillColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
}
UIBezierPath * myPath(CGPoint point1,CGPoint point2,CGFloat radius){
    UIBezierPath *path = [UIBezierPath bezierPath];
   // [path moveToPoint:point1];
    [path addArcWithCenter:point1 radius:radius startAngle:M_PI/4 endAngle:M_PI*3/2-M_PI/4 clockwise:YES];
    CGFloat offset = radius*sinf(M_PI/4);
    [path addLineToPoint:CGPointMake(point2.x-offset, point2.y-offset)];
    [path addArcWithCenter:point2 radius:radius startAngle:M_PI*3/2-M_PI/4 endAngle:M_PI/4 clockwise:YES];
    [path addLineToPoint:CGPointMake(point1.x+offset, point1.y+offset)];//
    return path;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
