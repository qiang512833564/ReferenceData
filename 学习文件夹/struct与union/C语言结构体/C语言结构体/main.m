//
//  main.m
//  C语言结构体
//
//  Created by lizhongqiang on 15/10/24.
//  Copyright (c) 2015年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#if 1
struct data {int a,b,c;};


 struct objc_ivar {
 char *ivar_name;
 char *ivar_type;
 int ivar_offset;
 #ifdef __LP64__
 int space;
 #endif
 };
 typedef struct objc_ivar myIvar;
 

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
       // NSLog(@"%lu-----%lu",sizeof(struct objc_ivar),sizeof(myIvar));
        NSLog(@"%lu",sizeof(struct data));

        struct data arg;
        arg.a = 27;
        NSLog(@"%d",arg.a);
        
        struct data *p;//
        p = malloc(sizeof(struct data));
        p->a = 100;//结构体的指向---->需要先开辟内存空间
    }
    return 0;
}
#endif
