//
//  测试responder.m
//  事件传送机制
//
//  Created by lizhongqiang on 16/1/6.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "测试responder.h"

@implementation __responder
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event当有事件发生的时候，该方法，会被自动调用！，不管该事件是发生在该视图上，还是父视图上----当事件发生的时候，会调用父视图和子视图的该方法，以便于确定事件发生的最终位置
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    return [super pointInside:point withEvent:event];
}
#pragma mark - 这样比较清晰，大家也会直观的看到nextResponder的查找过程。
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIResponder *responder = self;

    while (responder) {
        NSLog(@"%@", responder.class);
        responder = responder.nextResponder;
    }
    NSLog(@"----------------------------------");
   // BOOL inside = [self pointInside:point withEvent:event];
   // NSLog(@"inside=%d",inside);
    UIView *view = [super hitTest:point withEvent:event];
    return view;
}

@end
