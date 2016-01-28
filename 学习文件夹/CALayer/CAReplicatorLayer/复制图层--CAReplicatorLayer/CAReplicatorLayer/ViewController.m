//
//  ViewController.m
//  CAReplicatorLayer
//
//  Created by lizhongqiang on 15/7/23.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"
#import "AnimationLayer.h"
#define kXHAmazingLoadingDuration 4.0f
#define kXHAmazingLoadingDotNumber 200
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self addAnimationWithTintColor:[UIColor blueColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addAnimationWithTintColor:(UIColor *)tintColor
{
    CGFloat mainHeight = CGRectGetHeight([[UIScreen mainScreen] bounds]);
    CGFloat mainWdiht = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    CGRect frame = CGRectMake((mainWdiht - 20) / 2.0,
                              (mainHeight - 20) / 2.0,
                              20, 20);
    AnimationLayer *animationView = [[AnimationLayer alloc]init];
    animationView.frame = frame;
    CAReplicatorLayer *layer = (CAReplicatorLayer *)animationView.layer;
    
    /*
     CAReplicatorLayer，可以复制任何增加到层中的子层。这个复制的子层还可以被变换(在第5章讨论的层的变换)来产生一个耀眼的效果。
     */
   // animationView.backgroundColor = [UIColor redColor];
    layer.instanceCount = kXHAmazingLoadingDotNumber;
    layer.instanceDelay = kXHAmazingLoadingDuration / kXHAmazingLoadingDotNumber;
    layer.instanceColor = [UIColor blueColor].CGColor;//instanceCount、instanceCount、instanceCount这三个是关键
   // layer.instanceAlphaOffset = -0.1;
    layer.instanceTransform = CATransform3DMakeRotation(M_PI/2, 0, 0, 1);//CATransform3DMakeRotation(M_PI_2/3, 0, 0, 1);-----instanceTransform这个参数作用是：根据2π/弧度来算出需要copy多少份，同时把instanceCount平分到不同角度的复制layer层上
//    layer.instanceRedOffset = -0.1;
//    layer.instanceGreenOffset = -0.1;
//    layer.instanceBlueOffset = -0.1;//instanceRedOffset.instanceGreenOffset,instanceBlueOffset.instanceAlphaOffset分别使设置复制的对象每次复制时的RGB和alpha减少了多少
    [self.view addSubview:animationView];
    
    CALayer *dotLayer = [CALayer layer];
    dotLayer.bounds = CGRectMake(0, 0, 10, 10);
    dotLayer.backgroundColor = tintColor.CGColor;
    dotLayer.cornerRadius = CGRectGetMidX(dotLayer.bounds);
    dotLayer.shouldRasterize = YES;
    dotLayer.opacity = 0.0;
    dotLayer.rasterizationScale = [[UIScreen mainScreen] scale];
    [animationView.layer addSublayer:dotLayer];
    
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyframeAnimation.path = [self initializerStarBezierPath];
    keyframeAnimation.duration = 4.0;
    keyframeAnimation.repeatCount = CGFLOAT_MAX;
    
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.15, 0.15, 1.0)];
    scaleAnim.duration = 0.8;
    scaleAnim.delegate = self;
    scaleAnim.repeatCount = CGFLOAT_MAX;
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = 0.1;
    opacityAnimation.toValue = @(1.0);
    opacityAnimation.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup *animationGrop = [CAAnimationGroup animation];
    animationGrop.animations = @[keyframeAnimation, scaleAnim, opacityAnimation];
    animationGrop.duration = kXHAmazingLoadingDuration;
    animationGrop.repeatCount = CGFLOAT_MAX;
    
    [dotLayer addAnimation:animationGrop forKey:nil];
    //这里不能直接对layer进行添加动画，因为，系统会把CAReplicatorLayer的父层与其复制的结果，当成一个对象，进行，动画
    //所以，这里必须使子层
    //如果设置了layer.instanceTransform = CATransform3DMakeRotation(M_PI_2/3, 0, 0, 1);会把父层和子层复制旋转，但是子层的数量会被均匀的分不到父层上

    //动画组各个动画，设置的时间关系----
    /*
     动画组的时间尽量要与最长周期的动画周期保持一致，
     动画组中周期较短的动画，会重复执行动画，直至整个动画组动画结束
     动画如果不设置setBeginTime属性值，则默认是动画组中的动画同步执行
     */
}

- (CGPathRef)initializerStarBezierPath {
    UIBezierPath *starPath = UIBezierPath.bezierPath;
    [starPath moveToPoint: CGPointMake(98, 16)];
    [starPath addLineToPoint: CGPointMake(129.74, 62.31)];
    [starPath addLineToPoint: CGPointMake(183.6, 78.19)];
    [starPath addLineToPoint: CGPointMake(149.36, 122.69)];
    [starPath addLineToPoint: CGPointMake(150.9, 178.81)];
    [starPath addLineToPoint: CGPointMake(98, 160)];
    [starPath addLineToPoint: CGPointMake(45.1, 178.81)];
    [starPath addLineToPoint: CGPointMake(46.64, 122.69)];
    [starPath addLineToPoint: CGPointMake(12.4, 78.19)];
    [starPath addLineToPoint: CGPointMake(66.26, 62.31)];
    [starPath closePath];
    
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0, 1.0);
    CGPathRef path = CGPathCreateCopyByTransformingPath(starPath.CGPath, &transform);
    return CFBridgingRetain(CFBridgingRelease(path));
}
@end
