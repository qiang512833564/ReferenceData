//
//  NSObject+MJMember.h
//  多层嵌套模型KVC
//
//  Created by lizhongqiang on 15/10/14.
//  Copyright (c) 2015年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MJMember)
- (void)enumerateIvarsWithBlock:(MJIvarsBlock)block;
@end
