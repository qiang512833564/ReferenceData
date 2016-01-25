//
//  Caculator.h
//  ReactiveCocoa框架使用
//
//  Created by lizhongqiang on 16/1/23.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Caculator : NSObject
@property (nonatomic, assign) BOOL isEqule;
@property (nonatomic, assign) int result;

- (Caculator *)caculator:(int(^)(int result))caculator;

- (Caculator *)equle:(BOOL(^)(int result))operation;

@end
