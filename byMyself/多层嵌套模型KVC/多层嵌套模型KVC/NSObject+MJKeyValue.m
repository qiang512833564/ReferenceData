//
//  NSObject+MJKeyValue.m
//  多层嵌套模型KVC
//
//  Created by lizhongqiang on 15/10/14.
//  Copyright (c) 2015年 lizhongqiang. All rights reserved.
//

#import "NSObject+MJKeyValue.h"

@implementation NSObject (MJKeyValue)
+ (instancetype)objectWithKeyValues:(NSDictionary *)keyValues
{
    id model=[[self alloc]init];
    [model setKeyValues:keyValues];
    return model;
}
- (void)setKeyValues:(NSDictionary *)keyValues
{
    [self enumerateIvarsWithBlock:^(MJIvar *ivar, BOOL *stop) {
        // 1.取出属性值
        NSString *key = ivar.propertyName;
        id value = keyValues[key];
        if (!value || [value isKindOfClass:[NSNull class]]) return;
        NSLog(@"%d",ivar.type.fromFoundation);
        if (ivar.type.typeClass&&!ivar.type.fromFoundation) {
            value = [ivar.type.typeClass objectWithKeyValues:value];
         }
        // 4.赋值
        ivar.value = value;
    }];
    // 转换完毕
    if ([self respondsToSelector:@selector(keyValuesDidFinishConvertingToObject)]) {
        [self keyValuesDidFinishConvertingToObject];
    }
}
@end
