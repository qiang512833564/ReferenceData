//
//  RACSubscriber.m
//  ReactiveCocoa
//
//  Created by Josh Abernathy on 3/1/12.
//  Copyright (c) 2012 GitHub, Inc. All rights reserved.
//

#import "RACSubscriber.h"
#import "RACSubscriber+Private.h"
#import "RACEXTScope.h"
#import "RACCompoundDisposable.h"

@interface RACSubscriber ()

// These callbacks should only be accessed while synchronized on self.
@property (nonatomic, copy) void (^next)(id value);
@property (nonatomic, copy) void (^error)(NSError *error);
@property (nonatomic, copy) void (^completed)(void);

@property (nonatomic, strong, readonly) RACCompoundDisposable *disposable;

@end

@implementation RACSubscriber

#pragma mark Lifecycle

+ (instancetype)subscriberWithNext:(void (^)(id x))next error:(void (^)(NSError *error))error completed:(void (^)(void))completed {
	RACSubscriber *subscriber = [[self alloc] init];

	subscriber->_next = [next copy];//这里是获取到接收到信号的block操作
	subscriber->_error = [error copy];
	subscriber->_completed = [completed copy];

	return subscriber;
}

- (id)init {
	self = [super init];
	if (self == nil) return nil;

	@unsafeify(self);

	RACDisposable *selfDisposable = [RACDisposable disposableWithBlock:^{
		@strongify(self);

		@synchronized (self) {
			self.next = nil;
			self.error = nil;
			self.completed = nil;
		}
	}];

	_disposable = [RACCompoundDisposable compoundDisposable];
	[_disposable addDisposable:selfDisposable];

	return self;
}

- (void)dealloc {
	[self.disposable dispose];
}

#pragma mark RACSubscriber

- (void)sendNext:(id)value {
	@synchronized (self) {
		void (^nextBlock)(id) = [self.next copy];
		if (nextBlock == nil) return;

		nextBlock(value);//接收到信号的block操作调用
	}
}

- (void)sendError:(NSError *)e {
	@synchronized (self) {
		void (^errorBlock)(NSError *) = [self.error copy];
		[self.disposable dispose];

		if (errorBlock == nil) return;
		errorBlock(e);
	}
}

- (void)sendCompleted {
	@synchronized (self) {
		void (^completedBlock)(void) = [self.completed copy];
		[self.disposable dispose];

		if (completedBlock == nil) return;
		completedBlock();
	}
}

- (void)didSubscribeWithDisposable:(RACCompoundDisposable *)otherDisposable {
	if (otherDisposable.disposed) return;

	RACCompoundDisposable *selfDisposable = self.disposable;
	[selfDisposable addDisposable:otherDisposable];

	@unsafeify(otherDisposable);

	// If this subscription terminates, purge its disposable to avoid unbounded
	// memory growth.
    //如果这个订阅终止,清除其可支配的内存，避免内存的无限增长
	[otherDisposable addDisposable:[RACDisposable disposableWithBlock:^{
		@strongify(otherDisposable);
		[selfDisposable removeDisposable:otherDisposable];
	}]];
}

@end
