//
//  CAKeyframeAnimation+Animation.m
//  弹性动画
//
//  Created by lizhongqiang on 15/7/13.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "CAKeyframeAnimation+Animation.h"

@implementation CAKeyframeAnimation (Animation)

+(NSMutableArray *) animationValues:(id)fromValue toValue:(id)toValue usingSpringWithDamping:(CGFloat)damping initialSpringVelocity:(CGFloat)velocity duration:(CGFloat)duration{
    //60个关键帧
    NSInteger numOfPoints  = duration * 60;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:numOfPoints];
    for (NSInteger i = 0; i < numOfPoints; i++) {
        [values addObject:@(0.0)];
    }
    //差值
    CGFloat d_value = [toValue floatValue] - [fromValue floatValue];
    for (NSInteger point = 0; point<numOfPoints; point++)
    {
        CGFloat x = (CGFloat)point / (CGFloat)numOfPoints;
        CGFloat value = [toValue floatValue] - d_value * (pow(M_E, -damping * x) * cos(velocity * x)); //1 y = 1-e^{-5x} * cos(30x)
        values[point] = @(value);
    }
    return values;
}
+(CAKeyframeAnimation *)createSpring:(NSString *)keypath duration:(CFTimeInterval)duration usingSpringWithDamping:(CGFloat)damping initialSpringVelocity:(CGFloat)velocity fromValue:(id)fromValue toValue:(id)toValue
{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:keypath];
    NSMutableArray *values = [self animationValues:fromValue toValue:toValue usingSpringWithDamping:damping  initialSpringVelocity:velocity  duration:duration];
    anim.values = values;
    anim.duration = duration;
    return anim;
}
@end
