//
//  Custom_Protocol.h
//  模块化的网络接口层设计
//
//  Created by lizhongqiang on 16/3/17.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UserHttpHandler <NSObject>
- (void)getUserWithID:(NSNumber *)userID;
@end

@protocol CommentHttpHandler<NSObject>
- (void)getCommentsWithDate:(NSDate *)date;
@end
