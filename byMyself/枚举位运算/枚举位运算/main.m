//
//  main.m
//  枚举位运算
//
//  Created by lizhongqiang on 15/9/30.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, Test) {//第一个参数是类型，第二个参数Test是枚举名称
    TestA=1,
    TestB=1<<1,//2--->10
    TestC=1<<2,//4--->100
    TestD=1<<3,//8--->1000
    TestE=1<<4//16--->10000
};
typedef enum{
    UIViewAnimationCurveEaseInOut=1,
    UIViewAnimationCurveEaseIn,
    UIViewAnimationCurveEaseOut,
    UIViewAnimationCurveLinear
}UIViewAnimationCure;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        enum Test tes = (TestA|TestB);//相当于TestA+TestB
        NSLog(@"%ld",(long)tes);
        
        NSLog(@"%ld",(tes&TestA));//这个是判断某个枚举变量是否包含某个固定的枚举值---->使用前需要确保枚举值以及各个组合的唯一性
        NSLog(@"%ld",(tes&TestE));
        
    }
    return 0;
}
