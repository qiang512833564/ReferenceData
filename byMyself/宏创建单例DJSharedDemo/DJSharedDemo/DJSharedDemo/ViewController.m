//
//  ViewController.m
//  DJSharedDemo
//
//  Created by asios on 15/9/7.
//  Copyright (c) 2015年 梁大红. All rights reserved.
//

#import "ViewController.h"
#import "SharedMaxTools.h"
#import "SharedHttpTools.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    SharedMaxTools *t1 = [SharedMaxTools sharedMaxTools];
    SharedMaxTools *t2 = [[SharedMaxTools alloc] init];
    SharedMaxTools *t3 = [SharedMaxTools new];
    
    NSLog(@"\n[SharedMaxTools sharedMaxTools] = %p \n[[SharedMaxTools alloc] init] = %p \n[SharedMaxTools new] = %p", t1, t2, t3);
}


@end
