//
//  main.m
//  Block实现底层原理
//
//  Created by lizhongqiang on 16/3/26.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        __block int a = 0;
        void (^block)() = ^{
            a = 20;
            NSLog(@"AAAA=%d",a);
        }  ;
        
        if(true)
        {
            
        }
        else
        {
            block = ^{
                NSLog(@"BBBB");
            };
        }
        NSLog(@"%@",block);
        block();
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
