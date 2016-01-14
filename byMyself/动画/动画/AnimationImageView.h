//
//  AnimationImageView.h
//  动画
//
//  Created by lizhongqiang on 15/8/31.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationImageView : UIView
@property (nonatomic, strong)NSArray *positionArray;
@property (nonatomic, assign)CGRect frame1;
@property (nonatomic, assign)CGRect frame2;
@property (nonatomic, assign)CGRect frame3;
- (instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView;
- (void)startAnimation;
- (void)endAnimation;

@end
