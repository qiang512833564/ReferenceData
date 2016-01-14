//
//  SecondViewController.m
//  与pop动画共存的手势
//
//  Created by lizhongqiang on 15/7/14.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "SecondViewController.h"
#import "PopView.h"
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
@interface SecondViewController ()<PopViewDelegate,UINavigationControllerDelegate,UINavigationBarDelegate>
{
    id navPanTarget_;
    SEL navPanAction_;
}

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    
    // Do any additional setup after loading the view.
    // 获取系统默认手势Handler并保存
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        NSMutableArray *gestureTargets = [self.navigationController.interactivePopGestureRecognizer valueForKey:@"_targets"];
        id gestureTarget = [gestureTargets firstObject];
        navPanTarget_ = [gestureTarget valueForKey:@"_target"];
        navPanAction_ = NSSelectorFromString(@"handleNavigationTransition:");
    }
}
- (void)loadView
{
    PopView *popView = [[PopView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    popView.backgroundColor = [UIColor blueColor];
    popView.panDelegate = self;
    
    self.view = popView;
}

- (void)panView:(PopView *)popView panPopGesture:(UIPanGestureRecognizer *)pan
{
#if 1
    if (navPanTarget_ && [navPanTarget_ respondsToSelector:navPanAction_]) {
        [navPanTarget_ performSelector:navPanAction_ withObject:pan];
    }
#endif
#if 0
    [self.navigationController popViewControllerAnimated:YES];
#endif
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
