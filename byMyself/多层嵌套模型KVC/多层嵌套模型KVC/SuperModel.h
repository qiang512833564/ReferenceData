//
//  SuperModel.h
//  多层嵌套模型KVC
//
//  Created by lizhongqiang on 15/10/14.
//  Copyright (c) 2015年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SubModel;
@interface SuperModel : NSObject

@property (nonatomic, copy)NSString *name;

@property (nonatomic, copy)NSString *age;

@property (nonatomic, strong)SubModel *chirldren;

@end
