//
//  PopView.m
//  与pop动画共存的手势
//
//  Created by lizhongqiang on 15/7/14.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "PopView.h"

@implementation PopView
{
    UIGestureRecognizer* popGesture_;
    CGFloat panStartX_;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
        
        popGesture_ = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
        [self addGestureRecognizer:popGesture_];
        
    }
    return self;
}
- (void)panGesture:(UIPanGestureRecognizer *)sender
{

    if (self.panDelegate && [self.panDelegate respondsToSelector:@selector(panView:panPopGesture:)]) {
        [self.panDelegate panView:self panPopGesture:sender];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
