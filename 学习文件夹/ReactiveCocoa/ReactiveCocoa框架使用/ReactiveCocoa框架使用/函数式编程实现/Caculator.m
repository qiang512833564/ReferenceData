//
//  Caculator.m
//  ReactiveCocoa框架使用
//
//  Created by lizhongqiang on 16/1/23.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "Caculator.h"

@implementation Caculator
- (Caculator *)caculator:(int (^)(int))block{
    
    self.result = block(0);
    return self;
}
- (Caculator *)equle:(BOOL (^)(int))block{
    self.isEqule = block(self.result);
    return self;
}
@end
