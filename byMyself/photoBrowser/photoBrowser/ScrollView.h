//
//  ScrollView.h
//  photoBrowser
//
//  Created by lizhongqiang on 15/7/10.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollViewDelegate <NSObject>

- (UIImage *)photoBrowser:(NSInteger)index;

@end

@interface ScrollView : UIScrollView

@property (nonatomic, assign)id<ScrollViewDelegate> customDelegate;

@property (nonatomic, weak) UIView *sourceImagesContainerView;
@property (nonatomic, assign) int currentImageIndex;
@property (nonatomic, assign) NSInteger imageCount;//图片总数

- (void)show;

@end
