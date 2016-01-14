//
//  ViewController.m
//  CAGradientLayer
//
//  Created by lizhongqiang on 15/7/13.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong)CADisplayLink *gameTimer;

@property (nonatomic, strong)CAGradientLayer *colorLayer;

@property (nonatomic, assign)NSInteger step;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CAGradientLayer *colorLayer = [CAGradientLayer layer];
    
    colorLayer.frame = (CGRect){CGPointZero,CGSizeMake(200, 200)};
    
    colorLayer.position = self.view.center;
    
    [self.view.layer addSublayer:colorLayer];
    
    
    colorLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor greenColor].CGColor,(__bridge id)[UIColor blueColor].CGColor];
    
    colorLayer.locations = @[@(0.25),@(0.5),@(0.75)];
    
    colorLayer.startPoint = CGPointMake(0, 0);
    
    colorLayer.endPoint = CGPointMake(1, 0);
    
    _colorLayer = colorLayer;
    
    
    
    _gameTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(transaction:)];
    
    [_gameTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    
}
- (void)transaction:(CADisplayLink *)displayLink
{
    static CGFloat test = - 0.1f;
    
    
    if(_step%60 == 0)
    {
        
        
        if (test >= 1.1)
        {
            test = - 0.1f;
            [CATransaction setDisableActions:NO];
            _colorLayer.locations  = @[@(test), @(test + 0.01), @(test + 0.011)];
        }
        else
        {
            [CATransaction setDisableActions:NO];
            _colorLayer.locations  = @[@(test), @(test + 0.01), @(test + 0.011)];
        }
        NSLog(@"%f",test);
        
        test += 0.1f;
    }
    _step ++;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
