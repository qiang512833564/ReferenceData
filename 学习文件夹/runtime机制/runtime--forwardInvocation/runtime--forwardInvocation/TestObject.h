//
//  TestObject.h
//  runtime--forwardInvocation
//
//  Created by lizhongqiang on 16/3/8.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForwardClass : NSObject
-(void)doSomethingElse;
@end
@interface SomeClass : NSObject
-(void)doSomething;
-(void)doSomethingElse;
- (void)anyAction;
@end