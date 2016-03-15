//
//  TableView.m
//  手势与cell的didSelectRowAiIndexPath冲突
//
//  Created by lizhongqiang on 16/3/15.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "TableView.h"

@implementation TableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    return [super hitTest:point withEvent:event];
}

@end
