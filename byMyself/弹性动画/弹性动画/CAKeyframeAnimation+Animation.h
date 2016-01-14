//
//  CAKeyframeAnimation+Animation.h
//  弹性动画
//
//  Created by lizhongqiang on 15/7/13.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAKeyframeAnimation (Animation)

+ (CAKeyframeAnimation *)createSpring:(NSString *)keypath duration:(CFTimeInterval)duration usingSpringWithDamping:(CGFloat)damping initialSpringVelocity:(CGFloat)velocity fromValue:(id)fromValue toValue:(id)toValue;
/*
 keyPath可以使用的key
 
 - #define angle2Radian(angle) ((angle)/180.0*M_PI)
 
 - transform.rotation.x 围绕x轴翻转 参数：角度 angle2Radian(4)
 
 transform.rotation.y 围绕y轴翻转 参数：同上
 
 transform.rotation.z 围绕z轴翻转 参数：同上
 
 transform.rotation 默认围绕z轴
 
 transform.scale.x x方向缩放 参数：缩放比例 1.5
 
 transform.scale.y y方向缩放 参数：同上
 
 transform.scale.z z方向缩放 参数：同上
 
 transform.scale 所有方向缩放 参数：同上
 
 transform.translation.x x方向移动 参数：x轴上的坐标 100
 
 transform.translation.y x方向移动 参数：y轴上的坐标
 
 transform.translation.z x方向移动 参数：z轴上的坐标
 
 transform.translation 移动 参数：移动到的点 （100，100）
 
 opacity 透明度 参数：透明度 0.5
 
 backgroundColor 背景颜色 参数：颜色 (id)[[UIColor redColor] CGColor]
 
 cornerRadius 圆角 参数：圆角半径 5
 
 borderWidth 边框宽度 参数：边框宽度 5
 
 bounds 大小 参数：CGRect
 
 contents 内容 参数：CGImage
 
 contentsRect 可视内容 参数：CGRect 值是0～1之间的小数
 
 hidden 是否隐藏
 
 position
 
 shadowColor
 
 shadowOffset
 
 shadowOpacity
 
 shadowRadius
 
 *
 */
@end
