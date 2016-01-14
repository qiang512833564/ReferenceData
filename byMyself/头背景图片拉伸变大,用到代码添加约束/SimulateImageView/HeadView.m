//
//  HeadView.m
//  SimulateImageView
//
//  Created by lizhongqiang on 15/7/8.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.imageView = [[UIImageView alloc]init];
        
        [self addSubview:self.imageView];//注意这句代码要放在addConstraint之前
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        self.imageView.layer.masksToBounds = YES;
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
         
         self.imageView.image = [UIImage imageNamed:@"listdownload.jpg"];
       
    }
    return self;
}
#if 1
#pragma mark 下面这个是使UIView覆盖在tableview而不拦截事件的关键代码（注意，如果使UIImageView则不必实现该代码，它默认不会拦截事件）----有时候，仅仅不想拦截事件，可以通过关闭userInteractionEnabled用户交互来实现
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"%@",event);
    
    return nil;
    /*
     UIView *view = [super hitTest:point withEvent:event];
     if (view == self) {
     return nil;
     }
     return view;
     */
}
#endif
@end
