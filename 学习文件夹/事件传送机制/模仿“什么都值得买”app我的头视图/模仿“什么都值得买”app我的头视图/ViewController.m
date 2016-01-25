//
//  ViewController.m
//  模仿“什么都值得买”app我的头视图
//
//  Created by lizhongqiang on 16/1/21.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"
#import "HeadView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    HeadView *view = [[HeadView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
