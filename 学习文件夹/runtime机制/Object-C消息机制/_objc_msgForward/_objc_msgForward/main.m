//
//  main.m
//  _objc_msgForward
//
//  Created by lizhongqiang on 16/3/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Responder_Object.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Responder_Object *objc = [[Responder_Object alloc]init];
        
        [objc sendMessage];
     
        [objc methodSignature];
    }
    return 0;
}
