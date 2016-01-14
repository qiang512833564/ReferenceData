//
//  ViewController.m
//  loading
//
//  Created by lizhongqiang on 15/7/14.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"
#import "LoadingLine.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LoadingLine *loading = [[LoadingLine alloc]init];
    
    [self.view addSubview:loading];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
