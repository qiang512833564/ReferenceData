//
//  Utility.m
//  视图切割与阴影颜色
//
//  Created by lizhongqiang on 15/11/5.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "Utility.h"

@implementation Utility
+ (UIView *)createSnapshotFromView:(UIView *)view afterUpdates:(BOOL)afterUpdates location:(CGFloat)offset left:(BOOL)left
{
    
    CGSize size = view.frame.size;
    UIView *snapshotView=nil;
    CGRect rect = CGRectMake(offset, 0, size.width/4.f, size.height);
    //方法：
    /*
     - (UIView *)resizableSnapshotViewFromRect:(CGRect)rect afterScreenUpdates:(BOOL)afterUpdates withCapInsets:(UIEdgeInsets)capInsets
     截取的图片是整个self包括其子视图
     */
    snapshotView = [view resizableSnapshotViewFromRect:rect afterScreenUpdates:afterUpdates withCapInsets:UIEdgeInsetsZero];
    snapshotView = [self addShadowToView:snapshotView reverse:NO];
    snapshotView.layer.anchorPoint = CGPointMake(left ? 0.0 : 1.0, 0.5);
    return snapshotView;
}
//创建一个阴影视图
+(UIView*)addShadowToView:(UIView*)view reverse:(BOOL)reverse{
    //根据view创建一个一样大小的视图
    UIView *viewWithShadow = [[UIView alloc]initWithFrame:view.frame];
    //创建阴影
    UIView *shadowView = [[UIView alloc]initWithFrame:viewWithShadow.bounds];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = shadowView.bounds;
    gradient.colors = @[(id)[UIColor colorWithWhite:0.0 alpha:0.0].CGColor,
                        (id)[UIColor colorWithWhite:0.0 alpha:1.0].CGColor];
    gradient.startPoint = CGPointMake(reverse ? 0.0 : 1.0, reverse ? 0.2 : 0.0);
    gradient.endPoint = CGPointMake(reverse ? 1.0 : 0.0, reverse ? 0.0 : 1.0);
    [shadowView.layer insertSublayer:gradient atIndex:1];
    //添加原视图到新视图中
    view.frame = view.bounds;
    [viewWithShadow addSubview:view];
    //将阴影视图放在最上边
    [viewWithShadow addSubview:shadowView];
    
    return viewWithShadow;
    
}
+ (void)startAnimation:(UIView *)superView
{
    CGFloat foldWidth = CGRectGetWidth(superView.frame)/4.f;
    NSArray *fromViewFolds = superView.subviews;
    CGSize size = superView.frame.size;
    //添加一个视角转换
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.005;
    
#if  1
    [UIView animateWithDuration:5 animations:^{
        //设置每个褶皱的最后状态
        for (int i = 0; i < superView.subviews.count/2; i++) {
            float offset = (float)i * foldWidth*2;
            //左边和右边的褶皱从——fromView,在每一个视图都定位在屏幕的边缘,90度转换和1.0 alpha的影子。
            UIView *leftFromView = fromViewFolds[i*2];
            //leftFromViewFold.layer.position = CGPointMake(offset, size.height*0.5);
            
            leftFromView.layer.position = CGPointMake(0.0, size.height*0.5);//这里的作用是产生位移移动动画----注意一点将要消失的页面分隔成的四个片段最后都是移动到一个位置
            leftFromView.layer.transform = CATransform3DRotate(transform, M_PI_2, 0.0, 1.0, 0.0);//这里的作用使产生旋转动画
            [leftFromView.subviews[1] setAlpha:1.0];
            
            UIView *rightFromView = fromViewFolds[i*2+1];
            rightFromView.layer.position = CGPointMake(0.0, size.height*0.5);
            rightFromView.layer.transform = CATransform3DRotate(transform, -M_PI_2, 0.0, 1.0, 0.0);
            [rightFromView.subviews[1] setAlpha:1.0];
            
            
            
        }
    } completion:^(BOOL finished) {
        //移除快照视图
        
        for (UIView *view in fromViewFolds) {
            [view removeFromSuperview];
        }
        //重新保存toview和fromview的位置
        
        //[transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
#endif
}

@end
