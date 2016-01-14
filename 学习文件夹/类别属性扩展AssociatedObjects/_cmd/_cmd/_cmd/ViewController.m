//
//  ViewController.m
//  _cmd
//
//  Created by lizhongqiang on 15/11/6.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    Test *modal = [[Test alloc]init];
    modal.associatedObject_copy = @"dadad";
    NSLog(@"%@",modal.associatedObject_copy);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation Test



@end