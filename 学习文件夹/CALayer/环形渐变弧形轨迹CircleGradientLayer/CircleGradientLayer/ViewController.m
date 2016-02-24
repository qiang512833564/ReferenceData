//
//  ViewController.m
//  CircleGradientLayer
//
//  Created by Dinotech on 16/1/6.
//  Copyright © 2016年 Dinotech. All rights reserved.
//

#import "ViewController.h"
#import "PathView.h"
#import "RYGradientAnimation.h"

@interface ViewController ()
{
    CAShapeLayer * _trackLayer;
    
}
@property (weak, nonatomic) IBOutlet UIView *maredView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    NSLog(@"-xxxx-%f=====%@",self.maredView.bounds.size.height,self.maredView.constraints);
    CGSize size =    [self.maredView systemLayoutSizeFittingSize:UILayoutFittingExpandedSize];
    
    
    CAGradientLayer *colorLayer = [CAGradientLayer layer];
//    colorLayer.frame    = (CGRect){CGPointZero, CGSizeMake(200, 200)};
//    colorLayer.position = self.view.center;
//    [self.view.layer addSublayer:colorLayer];
//    
//    // 颜色分配
//    colorLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
//                          (__bridge id)[UIColor greenColor].CGColor
//                        ];
//    [CATransaction  setDisableActions:NO];
//    
//    // 颜色分割线
//    colorLayer.locations  = @[@(0.25)];
//    
//    // 起始点
//    colorLayer.startPoint = CGPointMake(0, 0);
//    
//    // 结束点
//    colorLayer.endPoint   = CGPointMake(0.3, 0.3);
    
    
    PathView * path = [[PathView alloc]initWithFrame:CGRectMake(50, 50, 200, 200)];
    path.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:path];

    //4 带有圆弧的矩形
//    [[UIColor redColor] setStroke];
//
//    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:(CGRect){5,50,100,60} cornerRadius:20.0f];
//    path.lineWidth = 2.0;
//    path.lineCapStyle = kCGLineCapRound;
//    path.lineJoinStyle = kCGLineCapRound;
//    [path stroke];
    
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
