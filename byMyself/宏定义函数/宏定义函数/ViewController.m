//
//  ViewController.m
//  宏定义函数
//
//  Created by lizhongqiang on 15/10/16.
//  Copyright (c) 2015年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
UIColorFromHexColor(Color);
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [self getColor:@"f2f2f2"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
