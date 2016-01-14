//
//  ViewController.m
//  NSScan字符串
//
//  Created by lizhongqiang on 15/7/16.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str = @"3434 dada 3333 my age is d 23 dada 344";
    
    NSScanner *scanner = [NSScanner scannerWithString:str];
    
    NSInteger number = 0;
    
    NSString *scanStr = @"my age is";
    
    //if(![scanner isAtEnd])
    {
        [scanner scanInteger:&number];
    }
    NSString *resultStr;
    
    BOOL  result = [scanner scanString:scanStr intoString:&resultStr];
    
    NSLog(@"%@-----%d",resultStr,result);
    
    NSLog(@"%ld",number);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
