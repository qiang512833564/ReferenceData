//
//  ViewController.m
//  与pop动画共存的手势
//
//  Created by lizhongqiang on 15/7/14.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"


@interface ViewController ()
{
    id navPanTarget_;
    SEL navPanAction_;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:@"跳转" forState:UIControlStateNormal];
    
    [self.view addSubview:btn];
    
    btn.frame = CGRectMake(100, 100, 49, 20);
    
    self.view.backgroundColor = [UIColor redColor];
    
    
    [btn addTarget:self action:@selector(turnToSecond) forControlEvents:UIControlEventTouchUpInside];
}
- (void)turnToSecond
{
    SecondViewController *secondVC = [[SecondViewController alloc]init];
    [self.navigationController pushViewController:secondVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
