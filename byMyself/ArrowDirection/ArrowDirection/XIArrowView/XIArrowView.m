//
//  XIArrowView.m
//  UIBezierPathSymbol_Demo
//
//  Created by yxlong on 15/7/9.
//  Copyright (c) 2015年 Kjuly. All rights reserved.
//

#import "XIArrowView.h"

@interface XIArrowPath : NSObject
+ (UIBezierPath *)bezierPathInRect:(CGRect)rect arrowDirection:(ArrowDirection)direction;
+ (UIBezierPath *)bezierPathCroppingBoundInRect:(CGRect)rect arrowDirection:(ArrowDirection)direction;
@end

@implementation XIArrowView
@synthesize lineWidth=_lineWidth;
@synthesize strokeColor=_strokeColor;
@synthesize highlightedStrokeColor=_highlightedStrokeColor;
@synthesize arrowDirection=_arrowDirection;

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame]){
        self.backgroundColor = [UIColor clearColor];
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    _lineWidth = 2.0;
    _strokeColor = [UIColor blueColor];
    _arrowDirection = ArrowDirectionLeft;
    _highlightedStrokeColor = [UIColor colorWithWhite:0.8 alpha:1];
}

- (void)setStrokeColor:(UIColor *)strokeColor
{
    _strokeColor = strokeColor;
    [self setNeedsDisplay];
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    [self setNeedsDisplay];
}

- (void)setArrowDirection:(ArrowDirection)arrowDirection
{
    _arrowDirection = arrowDirection;
    [self setNeedsDisplay];
}

- (void)setHighlighted:(BOOL)highlighted
{
    _highlighted = highlighted;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGFloat halfLineWidth = _lineWidth*3/4;
    UIEdgeInsets insets = UIEdgeInsetsMake(halfLineWidth, halfLineWidth, halfLineWidth, halfLineWidth);
    CGRect drawRect = UIEdgeInsetsInsetRect(rect, insets);
    
    // Drawing code
    UIBezierPath *path = [XIArrowPath bezierPathInRect:drawRect arrowDirection:_arrowDirection];
    path.lineCapStyle = kCGLineCapSquare;
    path.lineJoinStyle = kCGLineJoinMiter;
    path.lineWidth = _lineWidth;
    
    UIColor *__strokeColor = _highlighted==YES?_highlightedStrokeColor:_strokeColor;
    [__strokeColor setStroke];
    [path stroke];
}

@end

@implementation XIArrowButton
@synthesize lineWidth=_lineWidth;
@synthesize strokeColor=_strokeColor;
@synthesize highlightedStrokeColor=_highlightedStrokeColor;
@synthesize arrowDirection=_arrowDirection;

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame]){
        self.backgroundColor = [UIColor clearColor];
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    _lineWidth = 2.0;
    _strokeColor = [UIColor blueColor];
    _arrowDirection = ArrowDirectionLeft;
    _highlightedStrokeColor = [UIColor colorWithWhite:0.8 alpha:1];
}

- (void)setStrokeColor:(UIColor *)strokeColor
{
    _strokeColor = strokeColor;
    [self setNeedsDisplay];
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    [self setNeedsDisplay];
}

- (void)setArrowDirection:(ArrowDirection)arrowDirection
{
    _arrowDirection = arrowDirection;
    [self setNeedsDisplay];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGFloat halfLineWidth = _lineWidth*3/4;
    UIEdgeInsets insets = UIEdgeInsetsMake(halfLineWidth+self.contentEdgeInsets.top, halfLineWidth+self.contentEdgeInsets.left, halfLineWidth+self.contentEdgeInsets.bottom, halfLineWidth+self.contentEdgeInsets.right);
    CGRect drawRect = UIEdgeInsetsInsetRect(rect, insets);
    
    // Drawing code
    UIBezierPath *path = [XIArrowPath bezierPathCroppingBoundInRect:drawRect arrowDirection:_arrowDirection];
    path.lineCapStyle = kCGLineCapSquare;
    path.lineJoinStyle = kCGLineJoinMiter;
    path.lineWidth = _lineWidth;
    
    UIColor *__strokeColor = self.highlighted==YES?_highlightedStrokeColor:_strokeColor;
    [__strokeColor setStroke];
    [path stroke];
}

@end

@implementation XIArrowPath

+ (UIBezierPath *)bezierPathInRect:(CGRect)rect arrowDirection:(ArrowDirection)direction
{
    CGFloat min_x = CGRectGetMinX(rect);
    CGFloat mid_x = CGRectGetMidX(rect);
    CGFloat max_x = CGRectGetMaxX(rect);
    CGFloat min_y = CGRectGetMinY(rect);
    CGFloat mid_y = CGRectGetMidY(rect);
    CGFloat max_y = CGRectGetMaxY(rect);
    
    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = CGRectGetHeight(rect);
    
    CGPoint leftPoint, rightPoint, topPoint, bottomPoint;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    if(direction==ArrowDirectionLeft){
        if(width>height){
            leftPoint = CGPointMake(min_x+(width-height)/2+height/4, mid_y);
            topPoint = CGPointMake(mid_x+height/4, min_y);
            bottomPoint = CGPointMake(mid_x+height/4, max_y);
        }
        else{
            leftPoint = CGPointMake(min_x+width/4, mid_y);
            topPoint = CGPointMake(mid_x+width/4, min_y+(height-width)/2);
            bottomPoint = CGPointMake(mid_x+width/4, min_y+height -(height-width)/2);
        }
        
        [path moveToPoint:topPoint];
        [path addLineToPoint:leftPoint];
        [path addLineToPoint:bottomPoint];
    }
    else if(direction==ArrowDirectionRight){
        if(width>height){
            rightPoint = CGPointMake(min_x+(width-height)/2+height/4, mid_y);
            topPoint = CGPointMake(mid_x+height/4, min_y);
            bottomPoint = CGPointMake(mid_x+height/4, max_y);
        }
        else{
            rightPoint = CGPointMake(max_x-width/4, mid_y);
            topPoint = CGPointMake(mid_x-width/4, min_y+(height-width)/2);
            bottomPoint = CGPointMake(mid_x-width/4, min_y+height -(height-width)/2);
        }
        [path moveToPoint:topPoint];
        [path addLineToPoint:rightPoint];
        [path addLineToPoint:bottomPoint];
    }
    
    return path;
}

+ (UIBezierPath *)bezierPathCroppingBoundInRect:(CGRect)rect arrowDirection:(ArrowDirection)direction
{
    CGFloat min_x = CGRectGetMinX(rect);
    CGFloat mid_x = CGRectGetMidX(rect);
    CGFloat max_x = CGRectGetMaxX(rect);
    CGFloat min_y = CGRectGetMinY(rect);
    CGFloat mid_y = CGRectGetMidY(rect);
    CGFloat max_y = CGRectGetMaxY(rect);
    
    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = CGRectGetHeight(rect);
    
    CGPoint leftPoint, rightPoint, topPoint, bottomPoint;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    if(direction==ArrowDirectionLeft){
        if(width>height/2){
            leftPoint = CGPointMake(min_x+(width-height)/2+height/4, mid_y);
            topPoint = CGPointMake(mid_x+height/4, min_y);
            bottomPoint = CGPointMake(mid_x+height/4, max_y);
        }
        else{
            leftPoint = CGPointMake(min_x, mid_y);
            topPoint = CGPointMake(max_x, min_y+height/2-width);
            bottomPoint = CGPointMake(max_x, min_y+height/2+width);
        }
        [path moveToPoint:topPoint];
        [path addLineToPoint:leftPoint];
        [path addLineToPoint:bottomPoint];
    }
    else if(direction==ArrowDirectionRight){
        if(width>height/2){
            rightPoint = CGPointMake(min_x+(width-height)/2+height/4, mid_y);
            topPoint = CGPointMake(mid_x+height/4, min_y);
            bottomPoint = CGPointMake(mid_x+height/4, max_y);
        }
        else{
            rightPoint = CGPointMake(max_x, mid_y);
            topPoint = CGPointMake(min_x, min_y+height/2-width);
            bottomPoint = CGPointMake(min_x, min_y+height/2+width);
        }
        [path moveToPoint:topPoint];
        [path addLineToPoint:rightPoint];
        [path addLineToPoint:bottomPoint];
    }
    
    return path;
}

@end
