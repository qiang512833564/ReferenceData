//
//  RYSpotIndicatorView.h
//  IndicatorView
//
//  Created by Dinotech on 16/1/4.
//  Copyright © 2016年 Dinotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kRYBounceSpotAnimationDuration 0.6
NS_ASSUME_NONNULL_BEGIN
IB_DESIGNABLE
@interface RYSpotIndicatorView : UIView
/**
 *  设置复制图层次数
 */
@property (nonatomic,assign)IBInspectable NSInteger  instanceCount;
/**
 *  设置环形圆圈大小,暂不支持
 */
@property (nonatomic,assign)IBInspectable CGSize circleSize;
/**
 *  动画图层
 */
@property (nonatomic,strong,nonnull) CALayer  * animationLayer;
/**
 *  设置动画默认颜色
 */
@property (nonnull,nonatomic,strong) UIColor  * defaultTintColor;

/**
 *  // 初始化方法
 *
 *  @param color 默认显示颜色
 *  @param size  <#size description#>
 *
 *  @return 返回当前对象
 */
- (instancetype)initWihTintColor:(UIColor *)color circleSize:(CGSize )size;

/**
 *  手动自行移除动画
 */
- (void)removeAnimation;

@end
NS_ASSUME_NONNULL_END