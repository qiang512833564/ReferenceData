//
//  ViewController.m
//  TextScrollView
//
//  Created by lizhongqiang on 15/7/29.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIView *page0;
@property (nonatomic, strong)UIView *page1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.scrollView];
}
- (UIScrollView *)scrollView
{
    if(_scrollView == nil)
    {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 250)];
        _scrollView.delegate = self;
        
        _page0 = [[UIView alloc]init];
        _page0.frame = CGRectOffset(_scrollView.frame, 0, 0);
        _page0.backgroundColor = [UIColor redColor];
        _page1 = [[UIView alloc]init];
        _page1.frame = CGRectOffset(_page0.frame, _scrollView.bounds.size.width, 0);
        
        _page1.backgroundColor = [UIColor purpleColor];
        [_scrollView addSubview:_page0];
        [_scrollView addSubview:_page1];
        
        _scrollView.contentSize = CGSizeMake(2*_scrollView.bounds.size.width, 0);
    }
    return _scrollView;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.x >= _scrollView.bounds.size.width)
    {
        _page0.frame = CGRectOffset(_page1.frame, -scrollView.contentOffset.x, 0);
        _page1.frame = CGRectOffset(_page1.frame, scrollView.contentOffset.x, 0);
        [self loadSetup];
    }
}
- (void)loadSetup
{
    UIView *temp = _page0;
    _page0 = _page1;
    _page1 = temp;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
