//
//  MJMember.m
//  多层嵌套模型KVC
//
//  Created by lizhongqiang on 15/10/14.
//  Copyright (c) 2015年 lizhongqiang. All rights reserved.
//

#import "MJMember.h"

@implementation MJMember

- (instancetype)initWithSrcObject:(id)srcObject
{
    if(self = [super init])
    {
        _srcObject = srcObject;
    }
    return self;
}
@end
