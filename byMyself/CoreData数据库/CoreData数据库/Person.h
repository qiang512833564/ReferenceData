//
//  Person.h
//  CoreData数据库
//
//  Created by lizhongqiang on 15/9/2.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Card;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Card *card;

@end
