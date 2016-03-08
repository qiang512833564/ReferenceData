//
//  RACDynamicSignal.m
//  ReactiveCocoa
//
//  Created by Justin Spahr-Summers on 2013-10-10.
//  Copyright (c) 2013 GitHub, Inc. All rights reserved.
//

#import "RACDynamicSignal.h"
#import "RACEXTScope.h"
#import "RACCompoundDisposable.h"
#import "RACPassthroughSubscriber.h"
#import "RACScheduler+Private.h"
#import "RACSubscriber.h"
#import <libkern/OSAtomic.h>

@interface RACDynamicSignal ()

// The block to invoke for each subscriber.
@property (nonatomic, copy, readonly) RACDisposable * (^didSubscribe)(id<RACSubscriber> subscriber);

@end

@implementation RACDynamicSignal

#pragma mark Lifecycle

+ (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe {
	RACDynamicSignal *signal = [[self alloc] init];
	signal->_didSubscribe = [didSubscribe copy];
	return [signal setNameWithFormat:@"+createSignal:"];
}

#pragma mark Managing Subscribers
//注意这里subscribe方法的调用时间：
//RACSignal里面方法：- (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock内部调用
- (RACDisposable *)subscribe:(id<RACSubscriber>)subscriber {
	NSCParameterAssert(subscriber != nil);

	RACCompoundDisposable *disposable = [RACCompoundDisposable compoundDisposable];
    //将disposable与subscriber关联起来
	subscriber = [[RACPassthroughSubscriber alloc] initWithSubscriber:subscriber signal:self disposable:disposable];

	if (self.didSubscribe != NULL) {
        //schedule函数，会在内部调用传入的block参数，并返回一个RACDisposable对象
		RACDisposable *schedulingDisposable = [RACScheduler.subscriptionScheduler schedule:^{
            //这里才真正的开始传递信号
			RACDisposable *innerDisposable = self.didSubscribe(subscriber);//调用创建信号是传入的block函数
			[disposable addDisposable:innerDisposable];
		}];
        //通过销毁通过schedule方法返回的RACDisposable对象
        //来去掉已经在调度中（scheduling）的block
		[disposable addDisposable:schedulingDisposable];
	}
	
	return disposable;
}

@end
