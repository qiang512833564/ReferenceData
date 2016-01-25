//
//  va_list_test.h
//  ReactiveCocoa框架使用
//
//  Created by lizhongqiang on 16/1/23.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface va_list_test : NSObject
@property (nonatomic, copy)NSString *name;
- (instancetype)setNameWithFormat:(NSString *)format, ...;
@end
