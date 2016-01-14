//
//  ViewController.m
//  切割view
//
//  Created by lizhongqiang on 15/7/13.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"
#import "ImageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
  
    self.view.backgroundColor = [UIColor redColor];
    
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://t1.mmonly.cc/uploads/allimg/150415/24815-1Lber4.jpg"]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        ImageView *imageView = [[ImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
        
        [self.view addSubview:imageView];
        
       imageView.image = [UIImage imageWithData:data];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
