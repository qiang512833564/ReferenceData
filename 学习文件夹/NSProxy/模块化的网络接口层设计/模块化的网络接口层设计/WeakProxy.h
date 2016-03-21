//
//  WeakProxy.h
//  模块化的网络接口层设计
//
//  Created by lizhongqiang on 16/3/17.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 A proxy used to hold a weak object.
 It can be used to avoid retain cycles, such as the target in NSTimer or CADisplayLink.
 */
@interface WeakProxy : NSProxy
//这里用的是weak，实现了弱引用，因为正常情况下，timer与CADisplayLink会导致内存泄露
@property (nonatomic, weak, readonly) id target;
- (void)startwork;
- (instancetype)initWithTarget:(id)target;
+ (instancetype)proxyWithTarget:(id)target;
@end
