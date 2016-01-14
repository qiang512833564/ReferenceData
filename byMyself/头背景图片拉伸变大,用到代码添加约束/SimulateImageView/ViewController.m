//
//  ViewController.m
//  SimulateImageView
//
//  Created by lizhongqiang on 15/7/8.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"

#import "HeadView.h"

const void* _ARSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWOFFSET = &_ARSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWOFFSET;


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)UIImageView *headImg;

@property (nonatomic, strong)HeadView *headView;

@property (nonatomic, strong)NSLayoutConstraint *headerHeightConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.view.backgroundColor = [UIColor whiteColor];
    
    HeadView *headView = [[HeadView alloc]init];
    
    headView.translatesAutoresizingMaskIntoConstraints = NO;//这一行在添加约束时候，必须要设置为NO
    
    [self.view addSubview:headView];
    
    
   // headView.imageView.userInteractionEnabled = YES;
    
    self.headImg = headView.imageView;
    
    _headView = headView;
    
    UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(panGestRec:)];

    //headView.userInteractionEnabled = YES;
    
    
   [headView.imageView addGestureRecognizer:pan];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    
    [_tableView addObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset)) options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:_ARSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWOFFSET];
    
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:_tableView];
    
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
//    
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
//    
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
//    
//    [_tableView addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:[UIScreen mainScreen].bounds.size.height]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:headView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:headView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    NSLayoutConstraint *layout = [NSLayoutConstraint constraintWithItem:headView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    [self.view addConstraint:layout];
    
    self.headerHeightConstraint = [NSLayoutConstraint constraintWithItem:headView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:280];
    layout.active = NO;
    
    [headView addConstraint:self.headerHeightConstraint];
    
    _tableView.backgroundColor = [UIColor whiteColor];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    _tableView.contentInset = UIEdgeInsetsMake(280, 0, 0, 0);
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSLog(@"-------%f-----",_tableView.contentOffset.y);
    });
    [self.view bringSubviewToFront:headView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = @"title";
    
    return cell;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{if (context == _ARSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWOFFSET)
{
    NSLog(@"%f",self.headerHeightConstraint.constant);
    CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
    CGFloat offsetY = offset.y;
    CGPoint oldOffset = [change[NSKeyValueChangeOldKey] CGPointValue];
    CGFloat oldOffsetY = oldOffset.y;
    CGFloat deltaOfOffsetY = offset.y - oldOffsetY;
    CGFloat offsetYWithSegment = offset.y ;

    if(deltaOfOffsetY > 0)
    {// 当滑动是向上滑动时
        // 跟随移动的偏移量进行变化
        // NOTE:直接相减有可能constant会变成负数，进而被系统强行移除，导致header悬停的位置错乱或者crash
        if (self.headerHeightConstraint.constant - deltaOfOffsetY <= 0) {
            self.headerHeightConstraint.constant = 0;
            
            //self.headerHeightConstraint.active = YES;
        } else {
            self.headerHeightConstraint.constant -= deltaOfOffsetY;
        }
        // 如果到达顶部固定区域，那么不继续滑动
        if (self.headerHeightConstraint.constant <= 0) {
            self.headerHeightConstraint.constant = 0;
        }
    }
    else
    {
        // 当向下滑动时
        // 如果列表已经滚动到屏幕上方
        // 那么保持顶部栏在顶部
        if (offsetY > 0) {
            if (self.headerHeightConstraint.constant <= 0) {
                self.headerHeightConstraint.constant = 0;
            }
        } else {
            // 如果列表顶部已经进入屏幕
            // 如果顶部栏已经到达底部
            if (self.headerHeightConstraint.constant >= 280) {
                // 如果当前列表滚到了顶部栏的底部
                // 那么顶部栏继续跟随变大，否这保持不变
                if (-offsetYWithSegment > 280) {
                    self.headerHeightConstraint.constant = -offsetYWithSegment;
                } else {
                    self.headerHeightConstraint.constant = 280;
                }
            } else {
                // 在顶部拦未到达底部的情况下
                // 如果列表还没滚动到顶部栏底部，那么什么都不做
                // 如果已经到达顶部栏底部，那么顶部栏跟随滚动
                if (self.headerHeightConstraint.constant < -offsetYWithSegment) {
                    self.headerHeightConstraint.constant -= deltaOfOffsetY;
                }
            }
        }
    }
}

}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    return _headView;
//}
- (void)panGestRec:(UITapGestureRecognizer *)pan
{
    
    NSLog(@"%s",__func__);
    
    
}
- (void)dealloc
{
    [_tableView removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset))];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
