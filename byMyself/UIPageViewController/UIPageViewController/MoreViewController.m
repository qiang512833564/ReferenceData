//
//  MoreViewController.m
//  UIPageViewController
//
//  Created by lizhongqiang on 15/7/23.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = (NSString *)_dataObject;
    self.contentView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
   // [self.view addSubview:_contentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
