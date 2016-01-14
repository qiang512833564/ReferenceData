//
//  RootViewController.m
//  左划抽屉
//
//  Created by lizhongqiang on 15/7/13.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController.h"
#import "RightToolBar.h"
#import "MyRadioVC.h"

@interface RootViewController ()<ViewControllerDelegate,RightToolBarDelegate>

@property (nonatomic, strong)ViewController *mainVC;

@property (nonatomic, strong)MyRadioVC *radioVC;

@property (nonatomic, strong)RightToolBar *toolBar;

@property (nonatomic, strong)UIButton *rightBtn;

@property (nonatomic, assign)BOOL isShowingToolBar;

@property (nonatomic, strong)UIViewController *currentVC;

@property (nonatomic, strong)NSArray *controllers;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    
    
    _mainVC = [[ViewController alloc]init];
    _mainVC.delegate = self;
    
    [self addChildViewController:_mainVC];
    [self.view addSubview:_mainVC.view];
    [self didMoveToParentViewController:_mainVC];
    
    
    _radioVC = [[MyRadioVC alloc]init];
    _radioVC.delegate = self;
    
    
    [self addChildViewController:_radioVC];
    
    [self initWithRightBtn];
    
    _controllers = @[_mainVC,_radioVC];
    
    _currentVC = _mainVC;
}
- (void)initWithRightBtn
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightBtn.frame = CGRectMake(self.view.bounds.size.width - 39 - 10, 20, 39, 44);
    
    
    rightBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [rightBtn setImage:[UIImage imageNamed:@"menuIcon"] forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(slipLeftContentView:) forControlEvents:UIControlEventTouchUpInside];
    
    _rightBtn = rightBtn;
    
    [self.view addSubview:rightBtn];
}

- (void)slipLeftContentView:(UIButton *)leftBtn
{
    if(_isShowingToolBar)
    {
        
       
        {
            [self hideRightToolBar];
            
            [self.mainVC  hide];
            
            
            
        }
    }
    else
    {
        
        
        {
            [self showRightToolBar];
            [self.mainVC show];
            
            
            
        }
    }
}

- (void)showRightToolBar
{
    
        if(_toolBar == nil)
        {
            [self initRightContentView];
        }
        [_toolBar show];
    
    [UIView animateWithDuration:0.5f animations:^{
        _rightBtn.transform  = CGAffineTransformTranslate(CGAffineTransformIdentity, -100, 0);
        
    }completion:^(BOOL finished) {
        _isShowingToolBar = YES;
    }];
    
  
    [_toolBar updateTableView];
}
- (void)initRightContentView
{
    _toolBar = [[RightToolBar alloc]initWithFrame:CGRectMake( self.view.frame.size.width,0, 100, self.view.frame.size.height)];

    _toolBar.delegate = self;
    
    [self.view addSubview:_toolBar];
    
}
- (void)selectedToolItem:(NSInteger)row
{
    if(row > 1)
    {
        return;
    }
    
    
    
    UIViewController *ctrl = _controllers[row];
    
    
    
 
        [self transitionFromViewController:self.currentVC toViewController:ctrl duration:0 options:0 animations:^{
            
        } completion:^(BOOL finished) {
            
//            [self.currentVC willMoveToParentViewController:nil];
//            [self.currentVC removeFromParentViewController];
//            [self.currentVC didMoveToParentViewController:nil];
            
            
//            [ctrl willMoveToParentViewController:self];
//            [self addChildViewController:ctrl];
//            [ctrl didMoveToParentViewController:self];
//
            
            [self.view insertSubview:ctrl.view belowSubview:self.rightBtn];
            
             self.currentVC = ctrl;
            
        }];
    
}
- (void)hideRightToolBar
{
    [_toolBar hide];
    
    [UIView animateWithDuration:0.5f animations:^{
        _rightBtn.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        _isShowingToolBar = NO;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
