//
//  SubCard.h
//  CoreData数据库
//
//  Created by lizhongqiang on 15/9/2.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Card;

@interface SubCard : NSManagedObject

@property (nonatomic, retain) NSString * number;
@property (nonatomic, retain) Card *card;

@end
