//
//  HYPWheelView.h
//  彩票
//
//  Created by huangyipeng on 14-8-17.
//  Copyright (c) 2014年 HYP. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <UIKit/UIKit.h>

@interface HYPWheelView : UIView

+ (instancetype)wheelView;

- (IBAction)startSelectNumber;

- (void)start;
- (void)stop;




@end
