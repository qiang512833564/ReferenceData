//
//  RightToolBar.h
//  左划抽屉
//
//  Created by lizhongqiang on 15/7/13.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  RightToolBarDelegate<NSObject>

- (void)selectedToolItem:(NSInteger)row;

@end

@interface RightToolBar : UIView

@property (nonatomic, assign)id<RightToolBarDelegate> delegate;

- (void)show;

- (void)hide;

- (void)updateTableView;

@end
