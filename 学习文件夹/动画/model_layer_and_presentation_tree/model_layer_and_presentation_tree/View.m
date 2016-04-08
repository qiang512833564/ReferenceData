//
//  View.m
//  model_layer_and_presentation_tree
//
//  Created by lizhongqiang on 16/4/8.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "View.h"

@implementation View
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    UIView *view =  [super hitTest:point withEvent:event];
    
    if ( self.delegate && [self.delegate respondsToSelector:@selector(touchAction:)]) {
        [self.delegate touchAction:point];
    }
    
    return view;
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    BOOL bool0 = [super pointInside:point withEvent:event];
    return bool0;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches  withEvent:event];
}
@end
