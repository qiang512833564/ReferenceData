//
//  main.m
//  Block__底层实现原理
//
//  Created by lizhongqiang on 16/3/26.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 / Runtime copy/destroy helper functions (from Block_private.h)
 #ifdef __OBJC_EXPORT_BLOCKS
 extern "C" __declspec(dllexport) void _Block_object_assign(void *, const void *, const int);
 extern "C" __declspec(dllexport) void _Block_object_dispose(const void *, const int);
 extern "C" __declspec(dllexport) void *_NSConcreteGlobalBlock[32];
 extern "C" __declspec(dllexport) void *_NSConcreteStackBlock[32];
 #else
 __OBJC_RW_DLLIMPORT void _Block_object_assign(void *, const void *, const int);
 __OBJC_RW_DLLIMPORT void _Block_object_dispose(const void *, const int);
 __OBJC_RW_DLLIMPORT void *_NSConcreteGlobalBlock[32];
 __OBJC_RW_DLLIMPORT void *_NSConcreteStackBlock[32];
 #endif
 #endif
 #define __block
 #define __weak
 
 
 struct __block_impl {
 void *isa;
 int Flags;
 int Reserved;
 void *FuncPtr;
 };
 
 struct __main_block_impl_0 {
 struct __block_impl impl;
 struct __main_block_desc_0* Desc;
 int a;/看这里～看这里～/
 __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int _a, int flags=0) : a(_a) {
 impl.isa = &_NSConcreteStackBlock;
 impl.Flags = flags;
 impl.FuncPtr = fp;
 Desc = desc;
 }
 };
 static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
 int a = __cself->a; // bound by copy(再执行block，a的值仍然不变的原因)
 
 printf("%d\n",a);
 }
 
 static struct __main_block_desc_0 {
 size_t reserved;
 size_t Block_size;
 } __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0)};
 int main(int argc, const char * argv[]) {
 / @autoreleasepool / { __AtAutoreleasePool __autoreleasepool;
     int a = 10;
     void (*block) () = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, a));
     
     a = 20;
     ((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);
 }
return 0;
}
 */
#pragma mark --- 解释：从上面的流程，可以看出，大致过程是：现根据block实现部分，初始化一个__main_block_impl_0类型的struct,这个struct里面，又有两个结构体和使用的外部变量，这两个结构体分别是block方法的实现与block方法内存相关的描述，
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int a = 10;
        void (^block) () = ^{
            printf("%d\n",a);
        };
        //再次给a 赋值
        a = 20;
        block();
    }
    return 0;
}
