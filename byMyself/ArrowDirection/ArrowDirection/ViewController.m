//
//  ViewController.m
//  ArrowDirection
//
//  Created by lizhongqiang on 15/7/13.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"
#import "XIArrowView.h"

@interface ViewController ()

@property (nonatomic, strong)XIArrowButton *arrowBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initArrowButton];
}
- (void)initArrowButton
{
    self.arrowBtn = [[XIArrowButton alloc]initWithFrame:CGRectMake(100, 100, 47, 39)];
    
    self.arrowBtn.arrowDirection = ArrowDirectionRight;
    
    self.arrowBtn.strokeColor = [UIColor grayColor];
    
    self.arrowBtn.highlightedStrokeColor = [UIColor redColor];
    
    self.arrowBtn.lineWidth = 5;
    
    [self.view addSubview:self.arrowBtn];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
