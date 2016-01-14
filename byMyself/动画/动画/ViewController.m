//
//  ViewController.m
//  动画
//
//  Created by lizhongqiang on 15/8/31.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"
#import "AnimationImageView.h"
#define kDuration (1.5)
@interface ViewController ()
@property (nonatomic, strong)UIView *toolView;
@property (nonatomic, strong)AnimationImageView *animation;
@property (nonatomic, strong)UIView *sliderView;
@property (nonatomic, strong)CADisplayLink *play;
@property (nonatomic, strong)NSNumber *number;
@property (nonatomic, strong)UIPanGestureRecognizer *pan;
@property (nonatomic, assign)BOOL turnTo;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _toolView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 60, CGRectGetWidth(self.view.frame), 60)];
    [self.view addSubview:_toolView];
    _toolView.backgroundColor = [UIColor lightGrayColor];
    
    
    _animation = [[AnimationImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(_toolView.frame)/2.f-30/2.f, CGRectGetHeight(_toolView.frame)/2.f - 30/2.f, 30, 30) superView:_toolView];
 
//    [_toolView addSubview:_animation];
    
    self.sliderView = [[UIView alloc]init];
    self.sliderView.center = CGPointMake(CGRectGetWidth(_toolView.frame)/2.f, CGRectGetHeight(_toolView.frame)/2.f);
    self.sliderView.bounds = CGRectMake(0, 0, 15, 15);
    self.sliderView.layer.cornerRadius = 15/2.f;
    self.sliderView.layer.masksToBounds = YES;
    self.sliderView.userInteractionEnabled = YES;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveAction:)];
    [self.sliderView addGestureRecognizer:pan];
    [pan addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    _pan = pan;
    
    self.sliderView.backgroundColor = [UIColor blueColor];
    [_toolView addSubview:self.sliderView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"state"])
    {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)object;
        if(pan.state == UIGestureRecognizerStateEnded)
        {
        
            {
                _play = [CADisplayLink displayLinkWithTarget:self selector:@selector(animationStep:)];
                [_play addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            }
            
        }
    }
}
- (void)animationStep:(CADisplayLink *)player
{
    [_sliderView removeGestureRecognizer:_pan];
    
    CGPoint center = _sliderView.center;
    
    CGRect frame = CGRectZero;
    frame = CGRectContainsPoint(_animation.frame1, center)?_animation.frame1:(CGRectContainsPoint(_animation.frame2, center)?_animation.frame2:(CGRectContainsPoint(_animation.frame3, center)?_animation.frame3:CGRectZero));
    
    if(frame.size.width != 0)
    {
        center = CGPointMake(CGRectGetMidX(frame), CGRectGetHeight(_toolView.frame)/2.f);
        _sliderView.center = center;
        
        _turnTo = YES;
        
        return;
    }
    else
    {
        _turnTo = NO;
    }
    if(center.x >= CGRectGetWidth([UIScreen mainScreen].bounds)-60)
    {
        [player invalidate];
        player = nil;
        
        [_sliderView addGestureRecognizer:_pan];
    }
//    center.x += 25;
    
    if(_turnTo)
    {
        
        return;
    }
    
//    _sliderView.center = center;
}
- (void)moveAction:(UIPanGestureRecognizer *)pan
{
    
    
#if 1
    CGPoint point = [pan translationInView:self.sliderView];
    CGPoint center = self.sliderView.center ;
    NSLog(@"%@",NSStringFromCGPoint(point));
    center.x = point.x+center.x;
    self.sliderView.center = center;
    
    [pan setTranslation:CGPointZero inView:pan.view];
    
    if(point.x>170||point.x < -170)
    {
        return;
    }
#endif
#if 0
    CGPoint point = [pan locationInView:self.sliderView];
    CGPoint center = self.sliderView.center;
    center.x = point.x;
    self.sliderView.center = center;
#endif
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
