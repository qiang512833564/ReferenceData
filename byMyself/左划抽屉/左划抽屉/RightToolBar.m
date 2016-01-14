//
//  RightToolBar.m
//  左划抽屉
//
//  Created by lizhongqiang on 15/7/13.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "RightToolBar.h"

@interface RightToolBar ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSArray *dataArr;

@property (nonatomic ,assign)CGFloat timeTemp;

@property (nonatomic, assign)int cellNum;

@end

@implementation RightToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        
        self.backgroundColor = [UIColor blackColor];
        
        _dataArr = @[@"1",@"2",@"3",@"4",@"5"];
        
        [self initTableView];
        
        
    }
    return self;
}
- (void)updateTableView
{
    _timeTemp = 0;
    
    _cellNum = 0;
    
    [_tableView reloadData];
}
- (void)initTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.frame.size.width, self.frame.size.height - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = _dataArr[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 57;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.delegate&&[self.delegate respondsToSelector:@selector(selectedToolItem:)])
    {
        [self.delegate selectedToolItem:indexPath.row];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row < _cellNum)
    {
        return;
    }
    
    _cellNum = (int)indexPath.row;
    
    CGAffineTransform transform = CGAffineTransformTranslate(CGAffineTransformIdentity, self.frame.size.width, 0);
    cell.transform = transform;
#if 0
    [UIView animateKeyframesWithDuration:.7f delay:_timeTemp options:UIViewKeyframeAnimationOptionCalculationModeDiscrete animations:^{
        
        cell.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
    }];
#endif
#if 1
    [UIView animateWithDuration:.7f delay:_timeTemp usingSpringWithDamping:1.f initialSpringVelocity:0.7f options:0 animations:^{
        cell.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
    
    _timeTemp += 0.2;
#endif
    
    
}
- (void)show
{
    CGAffineTransform transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -self.frame.size.width, 0);
    
    [UIView animateWithDuration:.5f animations:^{
        
        self.transform = transform;
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}
- (void)hide
{
    [UIView animateWithDuration:.5f animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
}
@end
