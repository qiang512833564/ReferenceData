//
//  ViewController.m
//  粘贴复制
//
//  Created by lizhongqiang on 15/7/14.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"
#import "UICopyLabel.h"

@interface ViewController ()

@property (nonatomic, strong)UICopyLabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.label = [[UICopyLabel alloc]initWithFrame:CGRectMake(10, 100, 60, 27)];
    self.label.text = @"分享r";
    
    [self.view addSubview:self.label];
    
    
    UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(100, 300, 200, 30)];
    [self.view addSubview:textfield];
    
    textfield.borderStyle = UITextBorderStyleRoundedRect;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
