//
//  NSObject+_objc_msgForward.h
//  _objc_msgForward
//
//  Created by lizhongqiang on 16/3/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (_objc_msgForward)
- (void)sendMessage;
- (void)test;
@end
