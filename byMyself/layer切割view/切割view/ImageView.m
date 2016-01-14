//
//  ImageView.m
//  切割view
//
//  Created by lizhongqiang on 15/7/13.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ImageView.h"

@interface ImageView ()

@property (nonatomic, strong)CAShapeLayer *shapeLayer;

@end

@implementation ImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
       self.backgroundColor = [UIColor blueColor];
        
        [self dwMakeBottomRoundCornerWidthRadius:10.f];
    }
    return self;
}
//- (void)setImage:(UIImage *)image
//{
//    [super setImage:image];
//    
//    [self dwMakeBottomRoundCornerWidthRadius:3];
//}
- (void)dwMakeBottomRoundCornerWidthRadius:(CGFloat)radius
{
//    _shapeLayer = (CAShapeLayer *)self.layer;
//    
    CGSize size = self.frame.size;
    
    
    _shapeLayer = [CAShapeLayer layer];
    
    [_shapeLayer setFillColor:[UIColor blueColor].CGColor];
    
//    _shapeLayer.masksToBounds = YES;
    
   // _shapeLayer.frame = CGRectMake(100, 100, 60, 40);
    
   // _shapeLayer.backgroundColor = [UIColor redColor].CGColor;
    
    //[self.layer addSublayer:_shapeLayer];
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, size.width - radius, size.height);
    
    CGPathAddArc(path, NULL, size.width - radius, size.height - radius, radius, M_PI_2, 0.0, YES);
    
    
    CGPathAddLineToPoint(path, NULL, size.width, 0);
    
    CGPathAddLineToPoint(path, NULL, 0, 0);
    
    CGPathAddLineToPoint(path, NULL, 0, size.height - radius);
    
    CGPathAddArc(path, NULL, radius, size.height - radius, radius, M_PI, M_PI_2, YES);
    
    CGPathCloseSubpath(path);
    
    
    
    [_shapeLayer setStrokeColor:[UIColor redColor].CGColor];
    
    [_shapeLayer setPath:path];
    
    CFRelease(path);
    
    self.layer.mask = _shapeLayer;
    //根据shapelayer的边界，来裁剪self.layer
    
}
//+ (Class)layerClass
//{
//    return [CAShapeLayer class];
//}
@end
