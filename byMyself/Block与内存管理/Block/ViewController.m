//
//  ViewController.m
//  Block
//
//  Created by lizhongqiang on 16/3/10.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"
#import "MyClass.h"
@interface ViewController ()

@end

@implementation ViewController
//Block
/*
 使用Block必须要自己管理内存，而内存管理正是使用Block最多坑的地方
 Block的使用很像函数指针，不过与函数最大的不同是：Block可以访问函数以外、词法作用域以内的外部变量的值。
 可以这样理解，Block其实包含两个部分内容：
     一个包含Block执行时需要的所有外部变量值的数据结构。Block将使用到的、作用域附近到的变量的值建立一份快照拷贝到栈上。
     Block与函数另一个不同的是，Block类似ObjC的对象，可以使用自动释放池管理内存（但Block并不完全等同于ObjC对象）
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    //create a NSGlobalBlock
    float (^sum)(float,float) = ^(float a, float b){
        return a+b;
    };
    NSLog(@"block is %@",sum);//<__NSGlobalBlock__: 0x10108f0a0>
    
    //create a NSStackBlock
    NSArray *testArr = @[@"1",@"2",@"3"];
    void(^TestBlock)(void) = ^{
        NSLog(@"testArr:%@",testArr);
    };
    NSLog(@"block is %@",TestBlock);//<__NSGlobalBlock__: 0x10108f0a0>
    //上面这句在非arc中打印是 NSStackBlock, 但是在arc中就是NSMallocBlock
    //即在arc中默认会将block从栈复制到堆上，而在非arc中，则需要手动copy.

    NSLog(@"block is %@",^{
        NSLog(@"testArr:%@",testArr);//<__NSStackBlock__: 0x7fff590f39e8>
    });
    [self basicData];
    
    MyClass *objc = [[MyClass alloc]init];
    
    [objc test];
#if 0
    [objc testRlease];
    NSLog(@"objc=%ld",objc.retainCount);
    /*
     经过测试得出：
     虽然对象已经被release掉了
     但是该对象指针所指向的内存并不是立马被释放掉，其速度可快可慢，具有不确定性，因此有的时候回发生崩溃，有的时候却没有发生
     */
    [objc release];
    NSLog(@"objc=%ld",objc.retainCount);
    [objc test];
#endif
    [self callBlock];
    
    UIView *subView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 20)];
    subView.backgroundColor = [UIColor redColor];
   // NSLog(@"%ld",subView.retainCount);
    [self.view addSubview:subView];
    //NSLog(@"%ld",subView.retainCount);
}
- (NSArray *)blocks{
    int i = 1;
    return @[^{ return i; }];
}
- (void)callBlock{
    int (^block)(void) = [self blocks][0];
    //在没有开启ARC，以下这段程式码会在执行到block()这一行的时候，发生Bad Access错误：
    //block();
    //原因是：在-blocks所回传的NSArray中所包含的bock
}
#pragma mark --- 基本数据类型
int globalBasicData = 200;
- (void)basicData{
#pragma mark --- 1.局部变量
    //局部自动变量，在Block中只读。Block定义时copy变量的值，在Block中作为常量使用，所以即使变量的值在Block外改变，也不影响他在Block中的值。
    int base = 100;
    long(^sum)(int,int)=^long(int a,int b){
        return base+a+b;
    };
    base = 0;
    
    NSLog(@"%ld\n",sum(1,2));// 这里输出是103，而不是3, 因为块内base为拷贝的常量 100
#pragma mark --- 2.Static修饰符的静态变量
    //因为全局变量或静态变量在内存中的地址是固定的，Block在读取该变量值的时候是直接从其所在内存读出，获取到的是最新值，而不是在定义时copy的常量.
    static int base1 = 100;
    long(^sum1)(int,int)=^long(int a, int b){
        base1++;
        return base1+a+b;
    };
    base1 = 0;
    NSLog(@"static==%ld\n",sum1(1,2));// 这里输出是4，而不是103, 因为base1被设置为了0
#pragma mark --- 3.全局变量
    long(^sum2)(int,int)=^long(int a, int b){
        globalBasicData ++;
        return globalBasicData+a+b;
    };
    globalBasicData = 0;
    NSLog(@"global==%ld\n",sum2(1,2));// 这里输出是4，而不是103, 因为globalBasicData被设置为了0
#pragma mark --- 4.__block修饰的变量
#pragma mark ---- 5.对象作为参数传入
    NSObject*(^test)(NSObject*,NSObject*)=^NSObject*(NSObject *a,NSObject *b){
        NSLog(@"%ld----%ld",a.retainCount,b.retainCount);
        return a;
    };
    NSObject *a = [[NSObject alloc]init];
    NSObject *b = [[NSObject alloc]init];
    test(a,b);
    NSLog(@"%ld---%ld",a.retainCount,b.retainCount);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
