//
//  StarsLine.h
//  rrmj个人主页
//
//  Created by lizhongqiang on 15/8/27.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HeadTyep = 0,
    CommtentTyper
} StarStype;

@interface StarsLine : UIView
@property (nonatomic, assign)CGFloat score;
@property (nonatomic, assign)StarStype type;
@property (nonatomic, assign)BOOL usered;
@property (nonatomic, copy)void(^showScoreState)(NSString *score);
@end
