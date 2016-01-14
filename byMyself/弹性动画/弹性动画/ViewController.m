//
//  ViewController.m
//  弹性动画
//
//  Created by lizhongqiang on 15/7/13.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"
#import "CAKeyframeAnimation+Animation.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 40, 40)];
    imageView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:imageView];
    
#if 0
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation createSpring:@"transform.translation.x" duration:1.f usingSpringWithDamping:1.f initialSpringVelocity:0.7f fromValue:@(100) toValue:@(200)];
    
    
    [imageView.layer addAnimation:anim forKey:@"position"];
#endif
#if 1
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    anim.autoreverses = YES;
    anim.duration = 0.5f;
    anim.repeatCount = CGFLOAT_MAX;
    anim.values = @[@(100),@(200)];
    anim.removedOnCompletion= NO;
    [imageView.layer addAnimation:anim forKey:@"positon"];
#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
