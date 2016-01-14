//
//  LoadingLine.m
//  loading
//
//  Created by lizhongqiang on 15/7/14.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "LoadingLine.h"
#define kLineHeight (1.f)

@interface LoadingLine()

@property (nonatomic, strong)CAGradientLayer *gradientlayer;

@property (nonatomic, strong)CADisplayLink *gameTimer;

@property (nonatomic, assign)NSInteger stepNum;

@end

@implementation LoadingLine



- (instancetype)init
{
    if(self = [super init])
    {
        self.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, kLineHeight);
        
//        self.backgroundColor = [UIColor redColor];
        
        self.gradientlayer = (CAGradientLayer *)self.layer;
        
//        CGColorRef ref1 = [LoadingLine getColorFromRed:223 Green:25 Blue:33 Alpha:1.0];
//        CGColorRef ref2 = [LoadingLine getColorFromRed:35 Green:132 Blue:247 Alpha:1.0];
//        CGColorRef ref3 = [LoadingLine getColorFromRed:184 Green:51 Blue:161 Alpha:1.0];
        
        self.gradientlayer.colors = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor greenColor].CGColor,(__bridge id)[UIColor blueColor].CGColor];
        self.gradientlayer.locations = @[@(0.25),@(0.5),@(0.75)];
        
        
        self.gradientlayer.startPoint = CGPointMake(0, 0);
        self.gradientlayer.endPoint = CGPointMake(1, 0);
        
        
        
////////////////////////////////////////////////
        self.gameTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(moving)];
        [self.gameTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}
- (void)moving
{
    
    static CGFloat test = 0;
    
    
    
    if(self.stepNum%1 != 0)
    {
        self.stepNum++;
        
        return;
    }
    
    
    if(test >= 1)
    {
        test = 0;
    }
#if 0
    self.gradientlayer.startPoint = CGPointMake(0, 0);
    self.gradientlayer.endPoint = CGPointMake(test+0.1, 0);
#endif
    self.gradientlayer.locations = @[@(test),@(test+0.2),@(1-2*test - 0.1)];
    
    test += 0.01;
    self.stepNum++;
    
}
+(CGColorRef) getColorFromRed:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha
{
    CGFloat r = (CGFloat) red/255.0;
    CGFloat g = (CGFloat) green/255.0;
    CGFloat b = (CGFloat) blue/255.0;
    CGFloat a = (CGFloat) alpha/255.0;
    CGFloat components[4] = {r,g,b,a};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGColorRef color = (CGColorRef)CGColorCreate(colorSpace, components);
    CGColorSpaceRelease(colorSpace);
    
    return color;
}
+ (Class)layerClass
{
    return [CAGradientLayer class];
}
@end
