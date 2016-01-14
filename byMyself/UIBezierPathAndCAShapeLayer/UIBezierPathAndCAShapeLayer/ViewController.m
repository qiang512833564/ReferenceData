//
//  ViewController.m
//  UIBezierPathAndCAShapeLayer
//
//  Created by lizhongqiang on 15/7/24.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"
#import "RadiusShapeLayer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    RadiusShapeLayer *shapeLayer = [[RadiusShapeLayer alloc]initWithFrame:CGRectMake(40, 100, 100, 100)];
    [self.view addSubview:shapeLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
