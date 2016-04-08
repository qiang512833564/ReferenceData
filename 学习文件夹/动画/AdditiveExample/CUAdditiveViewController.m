//
//  CUAdditiveViewController.m
//  CoreAnimationExample
//
//  Created by yuguang on 30/6/14.
//  Copyright (c) 2014 lion. All rights reserved.
//

#import "CUAdditiveViewController.h"

//#define USING_UIKIT 1



typedef NS_OPTIONS(NSUInteger, CUAnimationType) {
    CUAnimationTypeNone,
    CUAnimationTypeAdditive,
    CUAnimationTypeBeginFromCurrentState
};

@interface CUAdditiveViewController ()

@property(weak, nonatomic) IBOutlet UIImageView *imageViewLeft;
@property(weak, nonatomic) IBOutlet UIImageView *imageViewCenter;
@property(weak, nonatomic) IBOutlet UIImageView *imageViewRight;
@end

@implementation CUAdditiveViewController
{
  BOOL _isForwardLeft;
  BOOL _isForwardCenter;
  BOOL _isForwardRight;
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  self.imageViewLeft.backgroundColor = [UIColor redColor];
  self.imageViewCenter.backgroundColor = [UIColor blueColor];
  self.imageViewRight.backgroundColor = [UIColor greenColor];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)animationClicked:(id)sender {
  
#ifdef USING_UIKIT
  
  static BOOL bTest = NO;
  [self UIKitAnimation:bTest];
  [self  UIKitAnimationDefault:bTest];
  bTest = !bTest;
  
#else
  
  [self animateType:CUAnimationTypeNone inLayer:self.imageViewLeft.layer];
  [self animateType:CUAnimationTypeAdditive inLayer:self.imageViewCenter.layer];
  [self animateType:CUAnimationTypeBeginFromCurrentState inLayer:self.imageViewRight.layer];
  
#endif
}

- (void)UIKitAnimation:(BOOL)isReverse
{
  if (!isReverse) {
    [UIView animateWithDuration:1.0f
                     animations:^{
                       self.imageViewRight.center = CGPointMake(self.imageViewRight.center.x, 500);
                     }];
  }
  else
  {
    [UIView animateWithDuration:1.0f
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear
                     animations:^{
                       self.imageViewRight.center = CGPointMake(self.imageViewRight.center.x, 88);
                     } completion:^(BOOL finished) {
                     }];
  }
}

- (void)UIKitAnimationDefault:(BOOL)isReverse
{
  if (!isReverse) {
    [UIView animateWithDuration:1.0f
                     animations:^{
                       self.imageViewLeft.center = CGPointMake(self.imageViewLeft.center.x, 500);
                     }];
  }
  else
  {
    [UIView animateWithDuration:1.0f
                     animations:^{
                       self.imageViewLeft.center = CGPointMake(self.imageViewLeft.center.x, 88);
                     } completion:^(BOOL finished) {
                     }];
  }
}

- (void)animateType:(CUAnimationType)type inLayer:(CALayer *)animationLayer {
  
  NSNumber *fromValue = @88;
  NSNumber *toValue = @500;
  NSNumber *endValue = toValue;
  CABasicAnimation *animation = [CABasicAnimation animation];
  animation.keyPath = @"position.y";
  animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
  animation.duration = 1; //modify better
  
  switch (type) {
  case CUAnimationTypeNone: {
    
    if (!_isForwardLeft) {
      _isForwardLeft = YES;
      animation.fromValue = fromValue;
      animation.toValue = toValue;
      endValue = toValue;
    }
    else {
      _isForwardLeft = NO;
      animation.fromValue = toValue;
      animation.toValue = fromValue;
      endValue = fromValue;
    }
    
    animationLayer.position = CGPointMake(animationLayer.position.x, [endValue intValue]);
    
    NSString *key = [NSString stringWithFormat:@"ani"];
    [animationLayer addAnimation:animation forKey:key];
  }
      break;
  case CUAnimationTypeAdditive: {
    
    if (!_isForwardCenter) {
      _isForwardCenter = YES;
      animation.fromValue = @([fromValue intValue] - [toValue intValue]);
    }
    else {
      _isForwardCenter = NO;
      animation.fromValue = @([toValue intValue] - [fromValue intValue]);
      endValue = fromValue;
    }
    
    animation.toValue = @(0);
    //使用了 Core Animation 中的 additive 属性，动画被设置成相对的，那么就和动画具体的位置无关。
    animation.additive = YES;//决定了动画如果指定的值被添加到当前的渲染树值来产生新的渲染树值。

    animationLayer.position = CGPointMake(animationLayer.position.x, [endValue intValue]);
    animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:.5 :0 :.5 :1]; // better easing function
    
    static NSUInteger number = 0; // use nil key or integer, not [NSDate date] because string description only shows seconds
    NSString *key = [NSString stringWithFormat:@"ani_%lu", (unsigned long)number++];
    
    [animationLayer addAnimation:animation forKey:key];
  }
      break;
  case CUAnimationTypeBeginFromCurrentState: {
#pragma mark --- view 从当前的渲染位置，动画过渡到终点位置
    if (!_isForwardRight) {
      _isForwardRight = YES;
      animation.fromValue = @([animationLayer.presentationLayer position].y);
      animation.toValue = toValue;
      endValue = toValue;
    }
    else {
      _isForwardRight = NO;
      animation.fromValue = @([animationLayer.presentationLayer position].y);
      animation.toValue = fromValue;
      endValue = fromValue;
    }
    
    animationLayer.position = CGPointMake(animationLayer.position.x, [endValue intValue]);
    
    NSString *key = [NSString stringWithFormat:@"ani"];
    [animationLayer addAnimation:animation forKey:key];
  }
      break;

  default:
    break;
  }
}

- (void)timeProc
{
  
}

@end
