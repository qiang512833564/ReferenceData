//
//  UIImageView+RadiusImageView.m
//  CircleImageView
//
//  Created by lizhongqiang on 15/7/10.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "UIImageView+RadiusImageView.h"

@implementation UIImageView (RadiusImageView)

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

- (void)drawImageView:(UIImage *)image offSet:(CGFloat)offset
{
#if 0
    
    UIGraphicsBeginImageContext(image.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 20);
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    CGRect rect = CGRectMake(offset, offset, image.size.width - 2*offset, image.size.height - 2*offset);
    
    CGContextAddEllipseInRect(context, rect);
    
    CGContextClip(context);
    
    
    [image drawInRect:rect];
    
    CGContextAddEllipseInRect(context, rect);
    
    CGContextStrokePath(context);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    self.image = newImage;
#endif
    
#if 1
    CGFloat radius;
    
    CGRect rect;
    
    if(image.size.width >= image.size.height)
    {
        radius = image.size.height;
        
        rect = CGRectMake((image.size.width - radius)/2.f, 0, radius, radius);
    }
    else
    {
        radius =  image.size.width;
        
        rect = CGRectMake(0, (image.size.height - radius)/2.f, radius, radius);
        
    }
    
    CGImageRef imageRef = image.CGImage;
    
    CGImageRef newImage = CGImageCreateWithImageInRect(imageRef, rect);
    
    
    image = [UIImage imageWithCGImage:newImage];
    
    UIGraphicsBeginImageContext(rect.size);
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    rect = CGRectMake(0, 0, radius, radius);
    
    CGContextSetLineWidth(ctx, offset);
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    
    CGContextAddEllipseInRect(ctx, rect);
    
    CGContextClip(ctx);

    
    
    [image drawInRect:rect];
    
    CGContextAddEllipseInRect(ctx, rect);
    
    CGContextStrokePath(ctx);/*
                              补画外围圆形图片
                              */
    
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
#endif
}

@end
