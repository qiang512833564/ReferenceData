//
//  ScoreView.m
//  rrmj个人主页
//
//  Created by lizhongqiang on 15/8/28.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ScoreView.h"
#import "StarsLine.h"
#define kX (16)
@interface ScoreView ()
@property (nonatomic, strong)UILabel *reminder;
@property (nonatomic, strong)StarsLine *stars;
@property (nonatomic, strong)UIButton *commitBtn;
@property (nonatomic, strong)NSString *score;
@end
@implementation ScoreView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _reminder = [[UILabel alloc]init];
        _reminder.center = CGPointMake(CGRectGetWidth(frame)/2.f, 75);
        _reminder.bounds = CGRectMake(0, 0, 200, 16);
        _reminder.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_reminder];
        //_reminder.backgroundColor = [UIColor redColor];
        _reminder.text = @"滑动或点击星星进行评分";
        _reminder.font = [UIFont systemFontOfSize:13.5];
        _reminder.textColor = [UIColor colorWithRed:91/255.f green:92/255.f blue:93/255.f alpha:1.0];
        
        _stars = [[StarsLine alloc]init];
        [self addSubview:_stars];
        _stars.type = CommtentTyper;
        _stars.score = 7.5;
        _stars.usered = YES;
        _stars.center = CGPointMake(_reminder.center.x, CGRectGetMaxY(_reminder.frame)+29);
        _stars.bounds = CGRectMake(0, 0, 210, 85/3.f);
        
        __unsafe_unretained ScoreView *weakSelf = self;
        _stars.showScoreState = ^(NSString *score)
        {
            weakSelf.score = score;
        };
        
        
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitBtn.center = CGPointMake(self.center.x, CGRectGetMaxY(_stars.frame)+47);
        [self addSubview:_commitBtn];
        _commitBtn.bounds = CGRectMake(0, 0, 117, 28);
        _commitBtn.layer.borderWidth = 0.6;
        _commitBtn.layer.borderColor = [UIColor colorWithRed:226/255.f green:227/255.f blue:228/255.f alpha:1.0].CGColor;
        _commitBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_commitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_commitBtn setTitle:@"提交评分" forState:UIControlStateNormal];
        [_commitBtn addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}
- (void)commitAction
{
    NSLog(@"提交评分：%@",self.score);
}
- (void)drawRect:(CGRect)rect
{
    NSString *title = @"评 分";
    [title drawAtPoint:CGPointMake(self.center.x - 20, 100/6.f) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor]}];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    [super drawLayer:layer inContext:ctx];
   // CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, kX, 137/3.f);
    CGContextAddLineToPoint(ctx, CGRectGetWidth(self.frame) - 2*kX, 137/3.f);
    CGContextSetLineWidth(ctx, 0.5);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:234/255.f green:235/255.f blue:236/255.f alpha:1.0].CGColor);
    CGContextDrawPath(ctx, kCGPathStroke);
}
@end
