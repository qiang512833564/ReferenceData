//
//  main.m
//  Block__底层实现原理
//
//  Created by lizhongqiang on 16/3/26.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Runtime_Object.h"
#import "MRC_Copy_Block.h"
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
 
 // 存储 __block 外部变量的结构体
 struct __Block_byref_objc_0 {
 void *__isa; // 对象指针
 __Block_byref_objc_0 *__forwarding; //指向自己的指针
 int __flags; // 标志位变量
 int __size; // 结构体大小
 void (*__Block_byref_id_object_copy)(void*, void*);
 void (*__Block_byref_id_object_dispose)(void*);
 Runtime_Object *objc; // 外部变量
 };
 
 struct __block_impl {
 void *isa;//这里isa就是runtime中objc_class结构体里指向Class的isa
           //由此可以看出block，在runtime中，被当做一个对象处理
           //block 的三种类型：_NSConcreteStackBlock、_NSConcreteGlobalBlock、_NSConcreteMallocBlock
 int Flags;//按位承载 block 的附加信息；
 int Reserved;//保留变量
 void *FuncPtr;//函数指针，指向block要执行的函数
 };
 
 struct __main_block_impl_0 {
 struct __block_impl impl;
 struct __main_block_desc_0* Desc;
 int a;/看这里～看这里～/
 __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int _a, int flags=0) : a(_a) {
 //构造函数 __main_block_impl_0 冒号后的表达式 a(_a) 的意思是，用 _a 初始化结构体成员变量 a
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
#pragma mark --- 解释：从上面的流程，可以看出，大致过程是：先根据block实现部分，初始化一个__main_block_impl_0类型的struct,这个struct里面，又有两个结构体和使用的外部变量，这两个结构体分别是block方法的实现与block方法内存相关的描述，得到的__main_block_impl_0 类型变量后赋值给 block，最后执行 block->FuncPtr()函数，即 printf("Block\n")
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int a = 10;
        __block Runtime_Object *objc = [[Runtime_Object alloc]init];
        void (^block) () = [^{
            
            //objc = [[Runtime_Object alloc]init];
            printf("%d---%p",a,objc);
        } copy];
        //我们通常对NSObject对象设置block属性的时候，其@propetry设置为copy的原因是：当 block 从栈拷贝到堆后，当栈上变量作用域结束时，仍然可以继续使用 block
        //再次给a 赋值
        printf("%d---%p",a,objc);
        a = 20;
        objc = [[Runtime_Object alloc]init];
        NSLog(@"new=%p",objc);
        block();
#pragma mark -- ARC中有下面几种情况不需要调用copy，编译器会自动为我们实现block的copy
        /*
        1 当 block 作为函数返回值返回时，编译器自动将 block 作为 _Block_copy 函数，效果等同于 block 直接调用 copy 方法；
        2 当 block 被赋值给 __strong id 类型的对象或 block 的成员变量时，编译器自动将 block 作为 _Block_copy 函数，效果等同于 block 直接调用 copy 方法；
        3 当 block 作为参数被传入方法名带有 usingBlock 的 Cocoa Framework 方法或 GCD 的 API 时。这些方法会在内部对传递进来的 block 调用 copy 或 _Block_copy 进行拷贝;
         */
        MRC_Copy_Block *block_copy = [[MRC_Copy_Block alloc]init];
    }
    return 0;
}


