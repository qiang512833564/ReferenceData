//
//  main.m
//  Mach Port
//
//  Created by lizhongqiang on 16/4/14.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainThread.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        [MainThread startMainThread];
    }
    return 0;
}
