//
//  ViewController.m
//  Animation动画
//
//  Created by lizhongqiang on 15/8/29.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Genie.h"

@interface ViewController ()
@property (nonatomic, strong)UIView *animationView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.animationView = [[UIView alloc]init];
    self.animationView.center = self.view.center;
    self.animationView.bounds = CGRectMake(0, 0, 100, 120);
    self.animationView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.animationView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"动画" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont  systemFontOfSize:15];
    btn.frame  =  CGRectMake(64, 64, 100, 16);
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(startOrEndAnimation) forControlEvents:UIControlEventTouchUpInside];
}
- (void)startOrEndAnimation
{
    CGRect endFrame = CGRectZero;
    
    [self.animationView genieInTransitionWithDuration:1.0 destinationRect:CGRectMake(self.animationView.frame.origin.x, self.view.bounds.size.height  - 5, 10, 10) destinationEdge:BCRectEdgeTop completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
