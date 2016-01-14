//
//  testObjsct1.m
//  load
//
//  Created by lizhongqiang on 15/11/6.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "testObjsct1.h"

@implementation testObjsct1
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [super allocWithZone:zone];
}
+ (instancetype)alloc
{
    return [super alloc];
}
- (instancetype)init
{
    if(self = [super init]){
        
    }
    return self;
}
+(void)load
{
    NSLog(@"testObjsct1--------%@",NSStringFromSelector(_cmd));
}
+ (void)initialize
{
    NSLog(@"testObjsct1---------%@",NSStringFromSelector(_cmd));
}
@end
