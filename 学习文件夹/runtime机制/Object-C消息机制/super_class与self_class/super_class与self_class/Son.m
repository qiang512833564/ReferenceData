//
//  Son.m
//  super_class与self_class
//
//  Created by lizhongqiang on 16/3/27.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "Son.h"

@implementation Son
- (instancetype)init{
    self = [super init];
    if(self){
        NSLog(@"super = %@,self = %@",[self class],[super class]);
        
    }
    return self;
}
@end
