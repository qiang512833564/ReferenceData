//
//  ShowScoreView.m
//  rrmj个人主页
//
//  Created by lizhongqiang on 15/8/28.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ShowScoreView.h"
#import "ScoreView.h"
#define kScoreHeight  (755/3.f)

@interface ShowScoreView()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) CAAnimation *showMenuAnimation;
@property (nonatomic, strong) CAAnimation *dismissMenuAnimation;
@property (nonatomic, strong) CAAnimation *dimingAnimation;
@property (nonatomic, strong) CAAnimation *lightingAnimation;
@property (nonatomic, strong)ScoreView *scoreView;
@property (nonatomic, strong)UITapGestureRecognizer *tapGesture;
@end
@implementation ShowScoreView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (ShowScoreView *)sharedShowScoreView
{
    
    static ShowScoreView *scoreView = nil;
    if(scoreView != nil)
    {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        [window addSubview:scoreView];
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scoreView = [[ShowScoreView alloc]init];
    });
    return scoreView;
}
- (instancetype)init
{
    if(self = [super init])
    {
        self.frame = [UIScreen mainScreen].bounds;
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        [window addSubview:self];
        
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        tapGesture.delegate = self;
        self.tapGesture = tapGesture;
        [self addGestureRecognizer:tapGesture];
        
        _scoreView = [[ScoreView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds) - kScoreHeight, [UIScreen mainScreen].bounds.size.width, kScoreHeight)];
        //_scoreView.alpha = 0;
        [self addSubview:_scoreView];
    }
    return self;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if ([gestureRecognizer isEqual:self.tapGesture]) {
        CGPoint p = [gestureRecognizer locationInView:self];
     
        if (CGRectContainsPoint(_scoreView.frame, p)) {
            return NO;
        }
    }
    return YES;
}
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.2];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setCompletionBlock:^{
          [self removeFromSuperview];
//        [_scoreView removeFromSuperview];
    }];
    [self.layer addAnimation:self.lightingAnimation forKey:@"lighting"];
    [_scoreView.layer addAnimation:self.dismissMenuAnimation forKey:@"dismissMenu"];
    [CATransaction commit];
}
#pragma mark -
- (void)showScoreView
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.2];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [self.layer addAnimation:self.dimingAnimation forKey:@"diming"];//背景的黑色覆盖
    [_scoreView.layer addAnimation:self.showMenuAnimation forKey:@"showMenu"];
    [CATransaction commit];
}
- (CAAnimation *)dimingAnimation
{
if (_dimingAnimation == nil) {
CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
opacityAnimation.fromValue = (id)[[UIColor colorWithWhite:0.0 alpha:0.0] CGColor];
opacityAnimation.toValue = (id)[[UIColor colorWithWhite:0.0 alpha:0.4] CGColor];
[opacityAnimation setRemovedOnCompletion:NO];
[opacityAnimation setFillMode:kCAFillModeBoth];
_dimingAnimation = opacityAnimation;
}
return _dimingAnimation;
}

- (CAAnimation *)lightingAnimation
{
if (_lightingAnimation == nil ) {
CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
opacityAnimation.fromValue = (id)[[UIColor colorWithWhite:0.0 alpha:0.4] CGColor];
    opacityAnimation.toValue = (id)[[UIColor colorWithWhite:0.0 alpha:0.0] CGColor];
    [opacityAnimation setRemovedOnCompletion:NO];
[opacityAnimation setFillMode:kCAFillModeBoth];
_lightingAnimation = opacityAnimation;
}
return _lightingAnimation;
}

- (CAAnimation *)showMenuAnimation
{
if (_showMenuAnimation == nil) {
CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
CATransform3D t = CATransform3DIdentity;
t.m34 = 1 / -500.0f;
CATransform3D from = CATransform3DRotate(t, -30.0f * M_PI / 180.0f, 1, 0, 0);
CATransform3D to = CATransform3DIdentity;
[rotateAnimation setFromValue:[NSValue valueWithCATransform3D:from]];
    [rotateAnimation setToValue:[NSValue valueWithCATransform3D:to]];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    [scaleAnimation setFromValue:@0.9];
    [scaleAnimation setToValue:@1.0];
    
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    [positionAnimation setFromValue:[NSNumber numberWithFloat:50.0]];
    [positionAnimation setToValue:[NSNumber numberWithFloat:0.0]];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [opacityAnimation setFromValue:@0.0];
    [opacityAnimation setToValue:@1.0];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    [group setAnimations:@[rotateAnimation, scaleAnimation, opacityAnimation, positionAnimation]];
    [group setRemovedOnCompletion:NO];
    [group setFillMode:kCAFillModeBoth];
    _showMenuAnimation = group;
}
    return _showMenuAnimation;
}

- (CAAnimation *)dismissMenuAnimation
{
    if (_dismissMenuAnimation == nil) {
        CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        CATransform3D t = CATransform3DIdentity;
        t.m34 = 1 / -500.0f;
        CATransform3D from = CATransform3DIdentity;
        CATransform3D to = CATransform3DRotate(t, -30.0f * M_PI / 180.0f, 1, 0, 0);
        [rotateAnimation setFromValue:[NSValue valueWithCATransform3D:from]];
        [rotateAnimation setToValue:[NSValue valueWithCATransform3D:to]];
        
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [scaleAnimation setFromValue:@1.0];
        [scaleAnimation setToValue:@0.9];
        
        CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        [positionAnimation setFromValue:[NSNumber numberWithFloat:0.0]];
        [positionAnimation setToValue:[NSNumber numberWithFloat:50.0]];
        
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        [opacityAnimation setFromValue:@1.0];
        [opacityAnimation setToValue:@0.0];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        [group setAnimations:@[ rotateAnimation,scaleAnimation, opacityAnimation, positionAnimation]];
        [group setRemovedOnCompletion:NO];
        [group setFillMode:kCAFillModeBoth];
        _dismissMenuAnimation = group;
    }
    return _dismissMenuAnimation;
}

@end
