//
//  ViewController.m
//  TestautomaticallyAdjustsScrollViewInsets
//
//  Created by lizhongqiang on 16/3/14.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}
- (UIImage *)backImage{
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddRect(ctx, CGRectMake(0, 0, 1, 1));
    CGContextSetFillColorWithColor(ctx, [UIColor clearColor].CGColor);
    CGContextDrawPath(ctx, kCGPathFill);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
        
    }
    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
