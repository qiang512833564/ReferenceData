//
//  ViewController.m
//  IvarLayour
//
//  Created by lizhongqiang on 16/3/29.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "Object_one.h"
#import <objc/message.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    Class class = allocateClass();
    
    id sark = [class new];
    Ivar weakIvar = class_getInstanceVariable(class, "_girlFriend");
    Ivar strongIvar = class_getInstanceVariable(class, "_gayFriend");
    {
        id girl = [NSObject new];
        id boy = [NSObject new];
        object_setIvar(sark, weakIvar, girl);
        object_setIvar(sark, strongIvar, boy);
    }//ARC 在这里会释放大括号内的 girl, boy
    // 输出：weakIvar 为 nil, strongIvar 有值
    NSLog(@"%@, %@", object_getIvar(sark, weakIvar), object_getIvar(sark, strongIvar));
    // Do any additional setup after loading the view, typically from a nib.
    
    ;
    NSLog(@"%s---weak=%s",class_getIvarLayout([Object_one class]),class_getIvarLayout(objc_getClass("Sark"))) ;
}
/*
 发现ivar的修饰信息存放在了Class的Ivar Layout中：
 struct class_ro_t {
 uint32_t flags;
 uint32_t instanceStart;
 uint32_t instanceSize;
 #ifdef __LP64__
 uint32_t reserved;
 #endif
 
 const uint8_t * ivarLayout; 记录了哪些是 strong 的 ivar
 
 const char * name;
 method_list_t * baseMethodList;
 protocol_list_t * baseProtocols;
 const ivar_list_t * ivars;
 
 const uint8_t * weakIvarLayout; 记录了哪些是 weak 的 ivar
 property_list_t *baseProperties;
 
 method_list_t *baseMethods() const {
 return baseMethodList;
 }
 };
 */
Class allocateClass(){
    Class class = objc_allocateClassPair(NSObject.class, "Sark", 0);
    class_addIvar(class,"_gayFriend",sizeof(id), log2(sizeof(id)), @encode(id));
    class_addIvar(class, "_girlFriend", sizeof(id), log2(sizeof(id)), @encode(id));
    class_addIvar(class, "_company", sizeof(id), log2(sizeof(id)), @encode(id));
    
    class_setIvarLayout(class, (const uint8_t *)"\x01\x12");
    class_setWeakIvarLayout(class, (const uint8_t *)"\x11\x10"); // <--- new
    
    objc_registerClassPair(class);
    
    fixup_class_arc(class);
    
    return class;
}
/*
 0120
 0 weak 1 strong
 2 waek 1 strong
 
 1 weak 0 strong
 1 weak 2 strong
 0 weak 1 strong
 本以为解决了这个问题，但是 runtime 继续打脸，strong 和 weak 的内存管理并没有生效，继续研究发现， class 的 flags 中有一个标记位记录这个类是否 ARC，正常编译的类，且标识了 -fobjc-arc flag 时，这个标记位为 1，而动态创建的类并没有设置它。所以只能继续黑魔法，运行时把这个标记位设置上，探索过程不赘述了，实现如下：
 */
static void fixup_class_arc(Class class) {
    struct {
        Class isa;
        Class superclass;
        struct {
            void *_buckets;
            uint32_t _mask;
            uint32_t _occupied;
        } cache;
        uintptr_t bits;
    } *objcClass = (__bridge typeof(objcClass))class;
#if !__LP64__
#define FAST_DATA_MASK 0xfffffffcUL
#else
#define FAST_DATA_MASK 0x00007ffffffffff8UL
#endif
    struct {
        uint32_t flags;
        uint32_t version;
        struct {
            uint32_t flags;
        } *ro;
    } *objcRWClass = (typeof(objcRWClass))(objcClass->bits & FAST_DATA_MASK);
#define RO_IS_ARR 1<<7
    objcRWClass->ro->flags |= RO_IS_ARR;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
typedef struct {
    uint8_t *bits;
    size_t bitCount;
    size_t bitsAllocated;
    bool weak;
} layout_bitmap;
static void set_bits(layout_bitmap bits, size_t which, size_t count)
{
    // fixme optimize for byte/word at a time
    size_t bit;
    for (bit = which; bit < which + count  &&  bit < bits.bitCount; bit++) {
        bits.bits[bit/8] |= 1 << (bit % 8);
    }
    if (bit == bits.bitCount  &&  bit < which + count) {
        // couldn't fit full type in bitmap
        //_objc_fatal("layout bitmap too short");
    }
}
static void decompress_layout(const unsigned char *layout_string, layout_bitmap bits)
{
    unsigned char c;
    size_t bit = 0;
    while ((c = *layout_string++)) {
        unsigned char skip = (c & 0xf0) >> 4;
        unsigned char scan = (c & 0x0f);
        bit += skip;
        set_bits(bits, bit, scan);
        bit += scan;
    }
}
@end
