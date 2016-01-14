//
//  ViewController.m
//  短信Demo
//
//  Created by lizhongqiang on 15/7/28.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"
#import "RegViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *strArray = @[@"短信验证码注册",@"语音验证码注册",@"通讯录好友",@"提交用户资料"];
    for(int i=0 ; i<4; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:strArray[i] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor purpleColor];
        btn.frame = CGRectMake(30, 80+i*(37+10), [UIScreen mainScreen].bounds.size.width - 2*30, 37);
        [self.view addSubview:btn];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)btnAction:(UIButton *)btn
{
    if(btn.tag == 100)
    {
        RegViewController *reg = [[RegViewController alloc]init];
        [self.navigationController pushViewController:reg animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
