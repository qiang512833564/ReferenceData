//
//  CYLBlockExecutor.m
//  Runtime实现weak
//
//  Created by lizhongqiang on 16/3/27.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "CYLBlockExecutor.h"

@interface CYLBlockExecutor ()
{
    voidBlock _block;
}
@property (nonatomic, copy) NSString *title;
@end

@implementation CYLBlockExecutor
@synthesize title = _title;
- (id)initWithBlock:(voidBlock)aBlock{
    self = [super init];
    if (self) {
        _block = [aBlock copy];
        _title = @"dada";
        
    }
    return self;
}

- (void)dealloc{
    _block ? _block() : nil;
}

@end
