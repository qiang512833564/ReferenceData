//
//  RCTConvert+StatusBarAnimation.h
//  Demo
//
//  Created by lizhongqiang on 15/9/30.
//  Copyright (c) 2015年 Facebook. All rights reserved.
//

#import "RCTConvert.h"

typedef NS_ENUM(NSInteger, MyStatusBarAnimation) {
  MyStatusBarAnimationNone,
  MyStatusBarAnimationFade,
  MyStatusBarAnimationSlide,
};

@interface RCTConvert (StatusBarAnimation)

@end
