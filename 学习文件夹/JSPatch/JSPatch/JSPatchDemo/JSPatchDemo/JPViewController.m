//
//  XRViewController.m
//  JSPatchDemo
//
//  Created by lizhongqiang on 16/3/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "JPViewController.h"

@interface JPViewController ()

@end

@implementation JPViewController

- (instancetype)initWithContent:(NSString *)title{
    self = [super init];
    if (self) {
        self.title = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
