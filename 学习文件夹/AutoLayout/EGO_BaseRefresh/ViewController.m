//
//  ViewController.m
//  EGO_BaseRefresh
//
//  Created by lizhongqiang on 15/12/23.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"
#import "UIView+AutoLayout.h"
#import "EGO_BaseRefresh-Swift.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AutoTableViewController *vc = [[AutoTableViewController alloc]init];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
