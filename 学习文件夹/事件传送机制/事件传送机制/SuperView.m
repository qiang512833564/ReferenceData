//
//  SuperView.m
//  事件传送机制
//
//  Created by lizhongqiang on 15/12/11.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "SuperView.h"

@implementation SuperView
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    return [super pointInside:point withEvent:event];
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    return [super hitTest:point withEvent:event];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
