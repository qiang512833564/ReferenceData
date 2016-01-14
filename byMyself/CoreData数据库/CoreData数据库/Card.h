//
//  Card.h
//  CoreData数据库
//
//  Created by lizhongqiang on 15/10/13.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person, SubCard;

@interface Card : NSManagedObject

@property (nonatomic, retain) NSString * no;
@property (nonatomic, retain) NSNumber * pingguo;
@property (nonatomic, retain) Person *person;
@property (nonatomic, retain) SubCard *subCard;

@end
