//
//  MJIvar.h
//  多层嵌套模型KVC
//
//  Created by lizhongqiang on 15/10/14.
//  Copyright (c) 2015年 lizhongqiang. All rights reserved.
//

#import "MJMember.h"
#import "MJType.h"
@interface MJIvar : MJMember//利用父类的_srcObject对象（父类是id，这里是NSDictionary对象），去存储关联对象propertyName与value
@property (nonatomic, assign)Ivar ivar;
@property (nonatomic, strong, readonly) MJType *type;


@property (nonatomic, copy)NSString *propertyName;
@property (nonatomic)id value;

- (instancetype)initMJIvar:(Ivar )ivar scrObject:(id)object;
@end

typedef void (^MJIvarsBlock)(MJIvar *ivar, BOOL *stop);
typedef void (^MJClassesBlock)(Class c, BOOL *stop);
