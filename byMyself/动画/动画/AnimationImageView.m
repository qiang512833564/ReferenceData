//
//  AnimationImageView.m
//  动画
//
//  Created by lizhongqiang on 15/8/31.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "AnimationImageView.h"
#import "ImageView.h"
#define kDuration (1.5)
@interface AnimationImageView ()

@property (nonatomic, strong)CADisplayLink *play;
@property (nonatomic, strong)ImageView *subView;
@property (nonatomic, strong)ImageView *subView1;
@property (nonatomic, strong)ImageView *subView2;

@property (nonatomic, strong)NSDate *animationBeginDate;
@property (nonatomic, strong)UIView *sliderView;
@property (nonatomic, assign)BOOL isfirst;
@property (nonatomic, assign)BOOL isStart1;

@end
@implementation AnimationImageView

- (instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView
{
    if(self = [super initWithFrame:frame])
    {
        _animationBeginDate = [NSDate date];
       // [self setNeedsDisplay];
        [superView addSubview:self];
        
#if 1
        CAReplicatorLayer *layer = (CAReplicatorLayer *)self.layer;
        layer.instanceCount = 3;
        layer.instanceDelay = kDuration/2.f;
        //layer.instanceColor = [UIColor redColor].CGColor;
       // layer.preservesDepth = NO;
        //layer.instanceColor = [UIColor blueColor].CGColor;
        
#endif
        
        _isfirst = YES;
        
        _play = [CADisplayLink displayLinkWithTarget:self selector:@selector(animationStep:)];
        [_play addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//        _play.frameInterval = 30;
        //[self animationStep:nil];
        

        
        ImageView *subView = [[ImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        [self addSubview:subView];
        //subView.alpha = 0;
        subView.transform = CGAffineTransformMakeScale(0.7, 0.7);
        //subView.hidden = YES;
        subView.layer.shouldRasterize = YES;
        subView.layer.rasterizationScale = [[UIScreen mainScreen]scale];
        subView.backgroundColor = [UIColor clearColor];
        _subView = subView;
        
        _subView1 = [[ImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        [self addSubview:_subView1];
        _subView1.transform = CGAffineTransformMakeScale(.7, .7);
        _subView1.layer.shouldRasterize = YES;
        _subView1.layer.rasterizationScale = [[UIScreen mainScreen]scale];
        _subView1.backgroundColor = [UIColor clearColor];
        
        
//        _subView2 = [[ImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
//        [self addSubview:_subView2];
//        _subView2.transform = CGAffineTransformMakeScale(.7, .7);
//        _subView2.layer.shouldRasterize = YES;
//        _subView2.layer.rasterizationScale = [[UIScreen mainScreen]scale];
//        _subView2.backgroundColor = [UIColor clearColor];
        
        
        
#if 0
        CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
        //move.fromValue = @(CGRectGetMaxX(self.frame));
        move.toValue = @(CGRectGetWidth([UIScreen mainScreen].bounds)/2.f - 20);
        //move.fillMode = kCAFillModeForwards;
        move.removedOnCompletion = YES;
        //move.duration = kDuration;
        move.repeatCount = CGFLOAT_MAX;
        move.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
        CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scale.fromValue = @(0.5);
        scale.toValue = @(1);
        scale.removedOnCompletion = YES;
        
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.duration = 0.1;
        opacityAnimation.toValue = @(1.0);
        opacityAnimation.fillMode = kCAFillModeForwards;
        //
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.animations = @[move,scale,opacityAnimation];
        group.delegate = self;
        group.duration = kDuration;
        group.repeatCount = CGFLOAT_MAX;
        [_subView.layer addAnimation:group forKey:nil];
#endif
        //self.userInteractionEnabled = YES;
        
        
    }
    return self;
}

- (void)animationDidStart:(CAAnimation *)anim
{
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"%s",__func__);
}
- (void)setBounds:(CGRect)bounds
{
    
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

+ (Class)layerClass
{
    return [CAReplicatorLayer class];
}
- (void)setUpStatus:(UIView *)view
{
    CGPoint center = view.center;
    CGAffineTransform transform = view.transform;
    transform.a += 0.0035;
    transform.d += 0.0035;
    center.x += 2;
    if(center.x >= CGRectGetWidth([UIScreen mainScreen].bounds)/2.f-10)
    {
        center.x = CGRectGetWidth(self.frame)/2.f;
        transform.a = 0.7;
        transform.d = 0.7;
//        NSTimeInterval aTimer = [_animationBeginDate timeIntervalSinceNow];
//        int hour = (int)(aTimer/3600);
//        int minute = (int)(aTimer - hour*3600)/60;
//        int second = aTimer - hour*3600 - minute*60;
//        NSLog(@"%d",second);
    }
    
    view.transform = transform;
    
    view.center = center;
}
- (void)animationStep:(CADisplayLink *)play
{

    [self setUpStatus:_subView];
    
    _frame1 = [self convertRect:_subView.frame toView:self.superview];
    
    if(_isfirst)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (NSEC_PER_SEC*1.25)/2.f), dispatch_get_main_queue(), ^{
            [self setUpStatus:_subView1];
            _isStart1 = YES;
        });
        
        //_isfirst = NO;
    }
    if(_isStart1)
    {
        [self setUpStatus:_subView1];
        _frame2 = [self convertRect:_subView1.frame toView:self.superview];
    }
    _isfirst = NO;

#if 0
    
    //NSLog(@"%f----1:%f----2:%f-----3:%f",[_animationBeginDate timeIntervalSinceNow],,,;
    CGRect frame1 = CGRectMake((((int)(betweenTime*100000)%(int)(kDuration*100000))/100000.f)*(CGRectGetWidth([UIScreen mainScreen].bounds)/2.f - 20)-CGRectGetWidth(self.frame)/2.f, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    CGRect frame2 = CGRectMake((((int)(betweenTime*100000 - kDuration/2.f*100000)%(int)(kDuration*100000))/100000.f)*(CGRectGetWidth([UIScreen mainScreen].bounds)/2.f - 20)-CGRectGetWidth(self.frame)/2.f, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    CGRect frame3 = CGRectMake((((int)(betweenTime*100000 - kDuration*200000)%(int)(kDuration*100000))/100000.f)*(CGRectGetWidth([UIScreen mainScreen].bounds)/2.f - 20)-CGRectGetWidth(self.frame)/2.f, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    frame1.origin.x += [UIScreen mainScreen].bounds.size.width/2.f;
    frame2.origin.x += [UIScreen mainScreen].bounds.size.width/2.f;
    frame3.origin.x += [UIScreen mainScreen].bounds.size.width/2.f;
    
    frame1.origin.y += 15;
    frame2.origin.y += 15;
    frame3.origin.y += 15;
    
    _frame1 = frame1;
    _frame2 = frame2;
    _frame3 = frame3;
#endif
}
- (void)startAnimation
{
    
    
}
- (void)endAnimation
{
    
}
@end
