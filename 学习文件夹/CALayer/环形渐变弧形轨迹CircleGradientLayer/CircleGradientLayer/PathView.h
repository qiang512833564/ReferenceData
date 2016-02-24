//
//  PathView.h
//  CircleGradientLayer
//
//  Created by Dinotech on 16/1/6.
//  Copyright © 2016年 Dinotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <SystemConfiguration/SystemConfiguration.h>
#define degressToRadius(ang) (M_PI*(ang)/180.0f) //把角度转换成PI的方式
#define PROGRESS_WIDTH 80 // 圆直径
#define PROGRESS_LINE_WIDTH 4 //弧线的宽度
@interface PathView : UIView
{
    CAShapeLayer * _trackLayer;
    CAShapeLayer * _progressLayer;
    
}
@end
