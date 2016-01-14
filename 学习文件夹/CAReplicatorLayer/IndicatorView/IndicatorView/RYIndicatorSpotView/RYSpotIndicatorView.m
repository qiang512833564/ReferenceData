//
//  RYSpotIndicatorView.m
//  IndicatorView
//
//  Created by Dinotech on 16/1/4.
//  Copyright © 2016年 Dinotech. All rights reserved.
//

#import "RYSpotIndicatorView.h"
#define kRYSIZE CGSizeMake(80,30)
@interface RYSpotIndicatorView()


@property (nonatomic,strong) CAReplicatorLayer *  replicatorLayer;
@end
@implementation RYSpotIndicatorView

- (instancetype)init
{
    self = [super init];
    if (self) {
       
        
        [self updateUI];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        [self updateUI];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self updateUI];
    }
    return self;
}
- (instancetype)initWihTintColor:(UIColor *)color circleSize:(CGSize )size{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.defaultTintColor = color;
    self.circleSize = size;
    [self updateUI];
    
    return self;
}
- (void)setUpUI{
    
 NSLog(@"%@",NSStringFromCGRect(self.frame));
    self.replicatorLayer.frame=CGRectMake(0, 0,self.frame.size.width, self.frame.size.height);
    //不指定数量可以直接修改
    NSInteger numOfDot = self.instanceCount>0?self.instanceCount:5;
    
    self.replicatorLayer.instanceCount = numOfDot;
    self.replicatorLayer.instanceTransform = CATransform3DMakeTranslation((self.frame.size.width/numOfDot), 0, 0);
    self.replicatorLayer.instanceDelay = kRYBounceSpotAnimationDuration/numOfDot;
    // 注释：此处主要是为了判断视图范围，防止超出窗口外部
    CGSize newSize = ([NSStringFromCGSize(self.circleSize)compare:NSStringFromCGSize(self.bounds.size) ]==NSOrderedAscending)?self.frame.size:self.circleSize;
    
    self.animationLayer.bounds = CGRectMake(0, 0, newSize.height/2, newSize.height/2);
    self.animationLayer.position = CGPointMake(((self.frame.size.width/5)/2), (self.bounds.size.height)/2);
    self.animationLayer.cornerRadius = newSize.height/4;
    self.animationLayer.borderWidth = 2.0f;
    self.animationLayer.borderColor = [UIColor grayColor].CGColor;
    [self addCyclingSpotAnimationLayerGroup];
}
- (void)updateUI{
    // 复制图层，用来做倒影视图用的CAReplicatorLayer
    self.replicatorLayer =[CAReplicatorLayer layer];
   
//     self.replicatorLayer.position = CGPointMake(self.center.x,self.center.y);
    self.replicatorLayer.backgroundColor = [UIColor clearColor].CGColor;
    
   
//    self.replicatorLayer.anchorPoint = CGPointMake(0, 0);
    [self.layer addSublayer:self.replicatorLayer];
    
    self.animationLayer = [CALayer layer];
    
    self.animationLayer.backgroundColor =[UIColor clearColor].CGColor;
    self.animationLayer.position = CGPointMake(0, 0);
    
    //    self.animationLayer.transform = CATransform3DMakeScale(0.8, 0.8, 1.0);
    [self.replicatorLayer addSublayer:self.animationLayer];
    [self setUpUI];
}

- (void)addCyclingSpotAnimationLayerGroup{
   
    [self.animationLayer removeAnimationForKey:@"animation"];
    
    //transform.scale
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.fromValue = (id)[UIColor grayColor].CGColor;
    animation.toValue = (id)[UIColor orangeColor].CGColor;
    animation.duration = kRYBounceSpotAnimationDuration;
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation1.fromValue = (id)[UIColor orangeColor].CGColor;
    animation1.toValue = (id)[UIColor clearColor].CGColor;
    animation1.duration = kRYBounceSpotAnimationDuration;
    CAAnimationGroup * group = [CAAnimationGroup animation];
    group.duration = kRYBounceSpotAnimationDuration*1.2;
    group.animations=@[animation,animation1];
    group.removedOnCompletion = NO;
    group.fillMode =kCAFillModeBoth;
    
    group.autoreverses = YES;
    group.repeatCount = INFINITY;
    [self.animationLayer addAnimation:group forKey:@"animation"];
}
- (void)setInstanceCount:(NSInteger)instanceCount{
    _instanceCount = instanceCount;
    [self setUpUI];
    
}
- (void)setDefaultTintColor:(UIColor *)defaultTintColor{
    _defaultTintColor = defaultTintColor;
    [self setUpUI];
}
- (void)setCircleSize:(CGSize)circleSize{
    _circleSize = circleSize;
    [self setUpUI];
    
}

- (void)setAnimationLayer:(CALayer *)animationLayer{
    _animationLayer = animationLayer;
    [self setUpUI];
}
- (void)removeAnimation{
    [self.animationLayer removeAnimationForKey:@"animation"];
}

@end
