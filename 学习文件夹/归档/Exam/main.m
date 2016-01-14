//
//  main.m
//  Exam
//
//  Created by lizhongqiang on 15/12/31.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Download.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        Download *load = [[Download alloc]init];
        [load downloadData:@"http://online.dongting.com/module/rank?page=1&utdid=VPKhKyoz9h4DANpyKlAtL6Pe&size=100"];
        NSLog(@"Hello, World!");
    }
    return 0;
}
