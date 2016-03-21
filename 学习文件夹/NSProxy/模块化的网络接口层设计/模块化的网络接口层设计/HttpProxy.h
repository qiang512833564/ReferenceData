//
//  HttpProxy.h
//  模块化的网络接口层设计
//
//  Created by lizhongqiang on 16/3/17.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Custom_Protocol.h"
@interface HttpProxy : NSProxy<UserHttpHandler,CommentHttpHandler>
+ (instancetype)sharedInstance;
- (void)registerHttpProtocol:(Protocol *)httpProtocol handler:(id)handler;
@end
