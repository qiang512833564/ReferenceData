//
//  ViewController.m
//  CircleImageView
//
//  Created by lizhongqiang on 15/7/10.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"

#import "UIImageView+RadiusImageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    

    [self.view addSubview:imageView];
  
    
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://img.1985t.com/uploads/attaches/2013/04/10823-Nzbzi1.jpg"]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        [imageView drawImageView:[UIImage imageWithData:data] offSet:27];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
