//
//  ViewController.m
//  多层嵌套模型KVC
//
//  Created by lizhongqiang on 15/10/14.
//  Copyright (c) 2015年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"
#import "SuperModel.h"
#import "SubModel.h"
@interface ViewController ()
@property (nonatomic, strong)UILabel *father;
@property (nonatomic, strong)UILabel *children;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _father = [[UILabel alloc]init];
    _father.center = CGPointMake(self.view.center.x, 100);
    _father.bounds = CGRectMake(0, 0, 100, 20);
    _father.textColor = [UIColor redColor];
    [self.view addSubview:_father];
    
    _children = [[UILabel alloc]init];
    _children.center = CGPointMake(self.view.center.x, 150);
    _children.bounds = CGRectMake(0, 0, 100, 20);
    _children.textColor = [UIColor redColor];
    [self.view addSubview:_children];
    
    NSDictionary *dic = @{@"name":@"father",@"age":@(40),@"chirldren":@{@"name":@"children"}};
    
    NSLog(@"%@",dic);
    SuperModel *model = [SuperModel objectWithKeyValues:dic];
    
    _father.text = model.name;
    _children.text = model.chirldren.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
