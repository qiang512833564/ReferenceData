//
//  ViewController.h
//  左划抽屉
//
//  Created by lizhongqiang on 15/7/13.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewControllerDelegate <NSObject>

- (void)showRightToolBar;

- (void)hideRightToolBar;

@end



@interface ViewController : UIViewController

@property (nonatomic, assign)id<ViewControllerDelegate> delegate;

- (void)show;

- (void)hide;

@end

