//
//  Download.h
//  Exam
//
//  Created by lizhongqiang on 15/12/31.
//  ;Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RankModel.h"

@interface Download : NSObject<NSCopying>

@property (nonatomic,strong)NSMutableArray *modelArray;

- (void)downloadData:(NSString *)urlString;
@end
