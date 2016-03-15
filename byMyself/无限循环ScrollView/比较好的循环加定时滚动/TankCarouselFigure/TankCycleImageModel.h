//
//  TankCycleImageModel.h
//  TankCarouselFigure
//
//  Created by yanwb on 15/12/23.
//  Copyright © 2015年 JINMARONG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TankCycleImageModel : NSObject
@property (nonatomic, copy) NSString *attractionId; // 焦点图的ID
@property (nonatomic, copy) NSString *imageUrl; // 焦点图的url
@property (nonatomic, copy) NSString *linkUrl; // 焦点图跳转路径
@property (nonatomic, copy) NSString *title; // 标题
@property (nonatomic, copy) NSString *jumpType; // 跳转类型  NONE/HTML/Native
@end
