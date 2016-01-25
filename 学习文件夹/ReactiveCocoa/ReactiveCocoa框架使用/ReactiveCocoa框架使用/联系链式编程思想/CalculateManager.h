//
//  CalculateManager.h
//  ReactiveCocoa框架使用
//
//  Created by lizhongqiang on 16/1/23.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculateManager : NSObject
@property (nonatomic, assign)int result;
@property (nonatomic, assign)CalculateManager* (^mydelete)();
//加法
- (CalculateManager *(^)(int))add;
- (CalculateManager *(^)(int))sub;
- (CalculateManager *(^)(int))muilt;
- (CalculateManager *(^)(int))divide;

@end
