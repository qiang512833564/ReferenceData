//
//  RCTConvert+StatusBarAnimation.m
//  Demo
//
//  Created by lizhongqiang on 15/9/30.
//  Copyright (c) 2015年 Facebook. All rights reserved.
//

#import "RCTConvert+StatusBarAnimation.h"

@implementation RCTConvert (StatusBarAnimation)
RCT_ENUM_CONVERTER(MyStatusBarAnimation, (@{@"statusBarAnimationNone":@(MyStatusBarAnimationNone),@"statusBarAnimationFade" : @(MyStatusBarAnimationFade),@"statusBarAnimationSlide" : @(MyStatusBarAnimationSlide)}), MyStatusBarAnimationNone, integerValue)
@end


