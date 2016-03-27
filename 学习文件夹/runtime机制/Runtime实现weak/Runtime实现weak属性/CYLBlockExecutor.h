//
//  CYLBlockExecutor.h
//  Runtime实现weak
//
//  Created by lizhongqiang on 16/3/27.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^voidBlock) (void);

@interface CYLBlockExecutor : NSObject

- (id)initWithBlock:(voidBlock)block;

@end
