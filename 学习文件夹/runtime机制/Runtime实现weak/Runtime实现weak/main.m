//
//  main.m
//  Runtime实现weak
//
//  Created by lizhongqiang on 16/3/27.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "Object_weak.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
#pragma  mark ----- 
        
#pragma mark ---- 赋值(由下，可见，对象之间的赋值，并不是简单的retain,而是直接把对象里的内容，进行了类似浅拷贝copy操作)
       id obj = [[NSObject alloc]init];
        id obj1;
        obj1 = obj;
        obj = [[NSObject alloc]init];
        NSLog(@"%@---%@",obj,obj1);
        obj = nil;
        NSLog(@"%@-----%@",obj,obj1);
 
#pragma mark --- weak操作(objc_storeWeak函数，是通过赋值对象，去找到赋值对象指向的地址块，所以，对应的hash表的key与value分别是key=赋值对象地址,value=__weak对象地址----也就是说：在 runtime 阶段，对于 weak 变量而言，系统使用 hash 表进行管理，将赋值对象地址作为 hash 表的 key，当赋值对象的引用计数为零的时候，系统根据赋值对象的内存地址找到所有指向该对象的 weak 变量，并将这些 weak 变量置为 nil。) 总之：__weak对象与赋值对象指向的地址块，是一样的
        
        id weakNew ;
        id weakOld = [[NSObject alloc]init];
        objc_storeWeak(&weakNew, weakOld);//参数一：_weak对象的地址，参数二：_weak对象指向的赋值对象
       // weakNew = [[NSObject alloc]init];
        weakOld = nil;
        //objc_loadWeak(&weakNew);
    
        objc_storeWeak(&weakNew, 0);
        
        //[weakOld release];
        NSLog(@"%p--%@-----%p",weakNew,weakNew,weakOld);
        
#pragma mark -- assgin操作
        Object_weak *weakObjc = [[Object_weak alloc]init];
        NSObject *objc = [[NSObject alloc]init];
        weakObjc.weakObjc = objc;
        weakObjc.assignObjc = objc;//如果assignObjc是由 assign 修饰的，则： 在 objc 非 nil 时，assignObjc 和 objc 指向同一个内存地址，在 objc 变 nil 时，assignObjc 还是指向该内存地址，变野指针。此时向 assignObjc 发送消息极易崩溃
        NSLog(@"first =  %@",weakObjc.weakObjc);
        //由此可以看出，当__weak对象的赋值对象被释放时（或者被置为nil）的时候，系统会在hash表中，找到对应的__weak对象，并将这些__weak对象，置为nil
        objc = nil;
        
        //NSLog(@"second = %@, assign = %@, copy = %@",weakObjc.weakObjc, weakObjc.assignObjc, weakObjc.mycopyObjc);
#pragma mark --- copy操作（imutable(NSDictionary、NSString、NSArray) copy实现原理,只是简单的指针拷贝, mutable copy与mutableCopy都是内容拷贝）
        NSMutableString *string = [NSMutableString stringWithString:@"origin"];//copy
        NSString *stringCopy = [string copy];
        
        [string appendFormat:@"origion!"];
        NSLog(@"mutable=%@\np=%p,\n copy=%@\np=%p",string,string,stringCopy,stringCopy);
        
        NSString *imutablestring = [NSString stringWithFormat:@"copy啊"];
        id object_test = [imutablestring copy];
        imutablestring = nil;
        NSLog(@"%@",object_test);
#pragma mark --- 总结
        /*
         对象之间的赋值操作，类似copy浅拷贝操作
         
         你可以把objc_storeWeak(&a, b)理解为：objc_storeWeak(value, key)，并且当key变nil，将value置nil。
         
         在b非nil时，a和b指向同一个内存地址，在b变nil时，a变nil。此时向a发送消息不会崩溃：在Objective-C中向nil发送消息是安全的。
         
         而如果a是由 assign 修饰的，则： 在 b 非 nil 时，a 和 b 指向同一个内存地址，在 b 变 nil 时，a 还是指向该内存地址，变野指针。此时向 a 发送消息极易崩溃。
         
         assign   简单赋值，不更改索引计数，
         copy：   建立一个索引计数为1的对象
                        这就是为什么assign与copy在对原对象进行nil赋值的时候，调用assign操作后的对象会崩溃，而copy操作后的对象则不会崩溃的原因
         retain   提高输入对象的索引计数为1
         */
    }
    return 0;
}
#pragma mark ---- 遗留问题：1 对象之间的赋值，是不是通过retain，还是？
                         //2 对象被置为nil,或者release,其指向的内存块，会立刻被释放吗？(经过测试，是立刻释放的，但是释放内存有块有慢，当运行比较快的时候，不会出现EXC_BAD_ACCESS)
                         //3 对象指向的内存块，释放的条件除了是对象retainCount=0以外，还有什么情况会被释放
