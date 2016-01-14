//
//  ViewController.m
//  rrmj个人主页
//
//  Created by lizhongqiang on 15/8/26.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"
#import "SeriesViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)pushToSecondStoryboard:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SecondStoryboard" bundle:nil];
    
    SeriesViewController *seriesVC = [storyboard instantiateViewControllerWithIdentifier:@"SeriesViewControllerId"];
    
    [self.navigationController pushViewController:seriesVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
