//
//  ViewController.m
//  UIView获取相对于屏幕的位置
//
//  Created by lizhongqiang on 15/7/27.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _tableView =  [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//    if(cell == nil)
//    {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
//    }
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 100, 80)];
    imageView.backgroundColor = [UIColor redColor];
    [cell addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)]];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D200/sign=c22182fc4b4a20a42e1e3bc7a0539847/0df431adcbef7609ca0143712adda3cc7dd99ed2.jpg"]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        imageView.image = [UIImage imageWithData:data];
    }];
    return cell;
}
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    UIView *view = tap.view;
    CGRect rect = [view convertRect:view.frame toView:nil];//获取view相对于屏幕的坐标
    NSLog(@"%@",NSStringFromCGRect(rect));
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
