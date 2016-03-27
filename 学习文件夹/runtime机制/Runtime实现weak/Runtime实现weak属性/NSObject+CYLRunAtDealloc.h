//
//  NSObject+CYLRunAtDealloc.h
//  Runtime实现weak
//
//  Created by lizhongqiang on 16/3/27.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

//const void *my_runAtDeallocBlockKey = &my_runAtDeallocBlockKey;

@interface NSObject (CYLRunAtDealloc)

@property (nonatomic, strong) NSObject *object;

- (void) cyl_runAtDealloc:(id)block;

@end
