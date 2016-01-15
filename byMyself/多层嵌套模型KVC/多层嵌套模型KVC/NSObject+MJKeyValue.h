//
//  NSObject+MJKeyValue.h
//  多层嵌套模型KVC
//
//  Created by lizhongqiang on 15/10/14.
//  Copyright (c) 2015年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MJKeyValue <NSObject>
/**
 *  当字典转模型完毕时调用
 */
- (void)keyValuesDidFinishConvertingToObject;
/**
 *  当模型转字典完毕时调用
 */
- (void)objectDidFinishConvertingToKeyValues;
@end

@interface NSObject (MJKeyValue)<MJKeyValue>
+ (instancetype)objectWithKeyValues:(NSDictionary *)keyValues;
@end
