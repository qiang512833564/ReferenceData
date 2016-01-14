//
//  HWAccountTool.h
//  黑马微博2期
//
//  Created by apple on 14-10-12.
//  Copyright (c) 2014年 heima. All rights reserved.
//  处理账号相关的所有操作:存储账号、取出账号、验证账号

#import <Foundation/Foundation.h>
#import "HWAccount.h"

@interface HWAccountTool : NSObject
/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(HWAccount *)account;

/**
 *  返回账号信息
 *
 *  @return 账号模型（如果账号过期，返回nil）
 */
+ (HWAccount *)account;
@end
