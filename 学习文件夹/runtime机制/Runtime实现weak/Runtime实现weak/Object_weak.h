//
//  Object_weak.h
//  Runtime实现weak
//
//  Created by lizhongqiang on 16/3/27.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Object_weak : NSObject
@property (nonatomic, weak) id weakObjc;
@property (nonatomic, assign) id assignObjc;
@property (nonatomic, copy) id mycopyObjc;
@end
