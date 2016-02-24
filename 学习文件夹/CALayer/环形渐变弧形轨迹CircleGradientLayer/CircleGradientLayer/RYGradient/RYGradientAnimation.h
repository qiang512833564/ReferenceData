//
//  RYGradientAnimation.h
//  CircleGradientLayer
//
//  Created by Dinotech on 16/1/8.
//  Copyright © 2016年 Dinotech. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  将一个角度转换成弧度
 *
 *  @param angle 弧度
 *
 *  @return 返回一个CGFloat
 */
static inline CGFloat ConvertToRadiusAngle(CGFloat angle){
    
    return ((M_PI*(angle))/180.f);
    
}

@interface RYGradientAnimation : UIView


@end
