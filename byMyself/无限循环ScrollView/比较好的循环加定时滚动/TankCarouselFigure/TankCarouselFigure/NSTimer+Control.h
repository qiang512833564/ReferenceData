//
//  NSTimer+Control.h
//  TankCarouselFigure
//
//  Created by yanwb on 15/12/23.
//  Copyright © 2015年 JINMARONG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Control)
- (void)pauseTimer;
- (void)resumeTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end
