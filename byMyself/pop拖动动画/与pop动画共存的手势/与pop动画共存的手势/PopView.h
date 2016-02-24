//
//  PopView.h
//  与pop动画共存的手势
//
//  Created by lizhongqiang on 15/7/14.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PopView;

@protocol PopViewDelegate <NSObject>

@optional
- (void)panView:(PopView *)popView panPopGesture:(UIPanGestureRecognizer *)pan;

@end


@interface PopView : UIView

@property (nonatomic, assign)id<PopViewDelegate> panDelegate;
@property (nonatomic, assign)BOOL enablePanGesture;

@end
