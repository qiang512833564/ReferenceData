//
//  RankModel.h
//  Exam
//
//  Created by lizhongqiang on 15/12/31.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankModel : NSObject<NSCoding>
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *desc;
@property (nonatomic, strong)NSMutableDictionary *songDict;
- (instancetype)initWithDataDic:(NSDictionary *)dic;
@end
