//
//  AnimationLayer.m
//  CAReplicatorLayer
//
//  Created by lizhongqiang on 15/7/23.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "AnimationLayer.h"

@implementation AnimationLayer

- (instancetype)init
{
    if(self = [super init])
    {
//        UIImageView *imageView = [[UIImageView alloc]init];
//        imageView.frame = CGRectMake(0, 0,20, 20);
//        imageView.image = [UIImage imageNamed:@"1_PxCook"];
//        [self addSubview:imageView];
        self.backgroundColor = [UIColor redColor];
        CAReplicatorLayer *replicatiorLayer = (CAReplicatorLayer *)self.layer;
        
        replicatiorLayer.instanceCount = 3;
        
    }
    return self;
}

+ (Class)layerClass
{
    return [CAReplicatorLayer class];
}

@end
