//
//  NSObject+Caculator.h
//  ReactiveCocoa框架使用
//
//  Created by lizhongqiang on 16/1/23.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalculateManager.h"

@class CalculateManager;
@interface NSObject (Caculator)

//计算
+ (int)makeCaculators:(void(^)(CalculateManager *make))caculatorMaker;

@end
