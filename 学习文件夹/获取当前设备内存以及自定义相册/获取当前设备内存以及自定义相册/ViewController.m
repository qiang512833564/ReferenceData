//
//  ViewController.m
//  获取当前设备内存以及自定义相册
//
//  Created by lizhongqiang on 16/1/17.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"
#import "SystemServices.h"
@interface ViewController ()
@property (nonatomic, strong)UILabel *label1;
@property (nonatomic, strong)UILabel *label2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 200, 20)];
    self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 200, 20)];
    self.label1.textColor = [UIColor blackColor];
    self.label2.textColor = [UIColor blackColor];
    [self.view addSubview:self.label1];
    [self.view addSubview:self.label2];
    SystemServices *system = [SystemServices sharedServices];
    NSLog(@"%@",system.allSystemInformation);
    self.label1.text = [NSString stringWithFormat:@"总共%f",system.totalMemory];
    self.label2.text = [NSString stringWithFormat:@"点我"];
    self.label2.userInteractionEnabled = YES;
    [self.label2 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoOpen)]];
}
- (void)photoOpen{
    UIImagePickerController *vc = [[UIImagePickerController alloc]init];
    vc.navigationBar.backgroundColor = [UIColor redColor];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
