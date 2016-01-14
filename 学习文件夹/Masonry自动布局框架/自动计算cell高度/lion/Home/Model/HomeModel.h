//
//  HomeModel.h
//  thinklion
//
//  Created by user on 15/12/5.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeModel : NSObject

@property (nonatomic,copy) NSString *icon; //图片
@property (nonatomic,copy) NSString *content; //内容的label
//单元格的高度
@property (nonatomic,assign) CGFloat cellHeight;

@end
