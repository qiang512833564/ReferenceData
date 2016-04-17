//
//  MyClass.m
//  Block
//
//  Created by lizhongqiang on 16/3/10.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "MyClass.h"
@interface MyClass(){

}
@property (nonatomic, strong)NSObject *propertyObj;
@property (nonatomic, assign)int value;
@end
@implementation MyClass

NSObject *_globalObj = nil;

- (id)init{
    if (self = [super init]) {
        _instanceObj = [[NSObject alloc]init];
        /*
         self.propertyName 会让计数器＋1(因为alloc一次，strong一次);_propertyName却不会。
         _propertyName是类似于self->_propertyName。
         用self.propertyName 是更好的选择，因为这样可以兼容懒加载，同时也避免了使用下划线的时候忽视了self这个指针，后者容易在block中造成循环引用。
         */
        //self.propertyObj = [[NSObject alloc]init];
        //NSLog(@"original : instance=%ld,property=%ld",[_instanceObj retainCount],[self.propertyObj retainCount]);
        //[_propertyObj release];
        /*
         error for object 0x7fc11bc2e4e0: pointer being freed was not allocated
         *** set a breakpoint in malloc_error_break to debug
         */
        //就是说你malloc分配的内存赋值给了一个已经被释放的指针（此指针已不存在）
        self.propertyObj = [[NSObject alloc]init];
        NSLog(@"%ld",[self.propertyObj retainCount]);
    }
    return self;
}
//strong(不实现Setter方法的话，默认实现跟这里是相似的)
- (void)setPropertyObj:(NSObject *)propertyObj{
    if (_propertyObj != propertyObj) {
        [_propertyObj release];
        
        _propertyObj = [propertyObj retain];
    }
}
//assign
- (void)setAssign:(int)value{
    if (_value != value) {
        _value = value;
    }
}
- (void)testRlease{
    /*
     通 常我们没有必要去特地查询一个对象的retain count是多少。查询的结果常常会出乎意料。你不清楚framework里面的其他对象对你感兴趣的这个对象进行了多少retain操作。在debug 内存管理的问题时候，你只要关注保证你的代码符合所有者规则即可。
     so，在引用计数的内存管理方式里面，我们可以把alloc, retain, copy, new, mutableCopy看作是+1操作。而通常根据原则，你要负责在适当的时候执行-1操作以保证没有内存泄漏就可以了。
     
     这是内存管理的知识，你看一下内存管理方面的东西就知道了，还有就是引用计数不会出现是零的情况，你把自己alloc, retain, copy, new, mutableCopy的释放掉就可以了，就像addSubview，就一个addSubview好像引用计数都加六呢，很多方法内部会出现很多的内存管理，那都 不是你该管的，只要看好自己
     alloc, retain, copy, new, mutableCopy的就足够了，引用计数不要相信，不准确的
     
     经过测试得出：
     虽然对象已经被release掉了
     但是该对象指针所指向的内存并不是立马被释放掉，其速度可快可慢，具有不确定性，因此有的时候回发生崩溃，有的时候却没有发生
     */
    NSObject *obj = [[NSObject alloc]init];
    NSLog(@"obj=%ld",[obj retainCount]);
    [obj release];
    NSLog(@"obj=%ld",[obj retainCount]);
}
typedef void(^MyBlock)(void);
- (void)test{
    static NSObject *_staticObj = nil;
    _globalObj = [[NSObject alloc]init];
    _staticObj = [[NSObject alloc]init];
    
    NSObject *localObj = [[NSObject alloc]init];
    __block NSObject *blockObj = [[NSObject alloc]init];
    //NSLog(@"self = %ld,instance = %ld, property = %ld",[self retainCount],[_instanceObj retainCount],[_propertyObj retainCount]);
    
    
    MyBlock aBlock = ^{
        NSLog(@"%@",_globalObj);
        NSLog(@"%@",_staticObj);
        NSLog(@"%@",_instanceObj);
        NSLog(@"%ld----%@---%ld",localObj.retainCount,localObj,localObj.retainCount);
        NSLog(@"%@",blockObj);
        NSLog(@"%@",_propertyObj);
    };
    
    MyBlock globalBlock = ^{
        NSLog(@"block");
    };
    
    NSLog(@"%@",aBlock);//<__NSStackBlock__: 0x7fff5f4f78b8>
    //1.NSGlobalBlock,可以通过是否引用外部变量识别，未引用外部变量即为NSGlobalBlock,可以当做函数使用。
    NSLog(@"%@",globalBlock);//<__NSGlobalBlock__: 0x7f9662c0e320>
    //aBlock = [[aBlock copy]autorelease];
    NSLog(@"%@",aBlock);//<__NSStackBlock__: 0x7f9662c0e320>也就是说：
    aBlock();
    /*
     _globalObj和_staticObj在内存中的位置是确定的，所以Block copy时不会retain对象
     _instanceObj在Block copy时也没有直接retain _instanceObj对象本身，但会retain self。所以在Block中可以直接读取_instanceObj变量
     _propertyObj或者self.propertyObj也会造成retain self,但是propertyObj本身并没有被retain
     localObj在Block copy时，系统自动retain对象，增加其引用计数
     */
    NSLog(@"_globalObj=%ld",[_globalObj retainCount]);
    NSLog(@"_staticObj=%ld",[_staticObj retainCount]);
   // NSLog(@"self==%ld,instanceObj=%ld",[self retainCount],[_instanceObj retainCount]);
    //NSLog(@"self==%ld,property=%ld",[self retainCount],[_propertyObj retainCount]);
    NSLog(@"localObj=%ld",[localObj retainCount]);
    NSLog(@"blockObj=%ld",[blockObj retainCount]);
    
    [_staticObj release];
    [localObj release];
    [blockObj release];
}
- (void)dealloc{
    
    NSLog(@"self=%ld,globalObj=%ld,,instanceObj=%ld,propertyObj=%ld",[self retainCount],[_globalObj retainCount],[_instanceObj retainCount],[self.propertyObj retainCount]);
    /*
     虽然_staticObj,globalObj，instanceObj，propertyObj等对象，是全局对象等，但是不等同于基本的数据类型，存储方式，因为他们都是对象，都是由malloc方法开辟内存的，所以他们都是存储在堆中，因此其生命周期是有程序员自己控制的
     */
    [_globalObj release];
    [self->_instanceObj release];
    [self.propertyObj release];
    NSLog(@"self=%ld,_propertyObj=%ld,_instance=%ld",[self retainCount],[self.propertyObj retainCount],[_instanceObj retainCount]);
    [super dealloc];//调用该方法的同时，其内部会对_instanceObj进行release一次
    NSLog(@"self=%ld,_propertyObj=%ld",[self retainCount],[self.propertyObj retainCount]);
    
    //NSLog(@"self=%ld,globalObj=%ld,,instanceObj=%ld,propertyObj=%ld",[self retainCount],[_globalObj retainCount],[_instanceObj retainCount],[_propertyObj retainCount]);//这里再去获取globalObj，instanceObj，propertyObj等对象的引用次数，会崩溃，因为他们已经被释放掉了
}
/*
 野指针错误：访问了一块坏的内存（已经被回收的，不可用的内存）。
 僵尸对象：所占内存已经被回收的对象，僵尸对象不能再被使用。（打开僵尸对象检测）
 
 如果一个对象被释放后，那么最后引用它的变量需要手动设置为nil，否则可能造成野指针错误。
 
 对象之间可能交叉引用，此时需要遵循一个法则：谁创建，谁释放
 */
@end
