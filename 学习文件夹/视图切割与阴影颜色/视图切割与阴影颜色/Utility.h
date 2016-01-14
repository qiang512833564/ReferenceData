//
//  Utility.h
//  视图切割与阴影颜色
//
//  Created by lizhongqiang on 15/11/5.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Utility : NSObject
+ (UIView *)createSnapshotFromView:(UIView *)view afterUpdates:(BOOL)afterUpdates location:(CGFloat)offset left:(BOOL)left;
+(UIView*)addShadowToView:(UIView*)view reverse:(BOOL)reverse;
+ (void)startAnimation:(UIView *)superView;
@end
