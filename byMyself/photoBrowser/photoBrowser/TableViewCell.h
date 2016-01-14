//
//  TableViewCell.h
//  photoBrowser
//
//  Created by lizhongqiang on 15/7/10.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (nonatomic, strong)NSArray *picArr;

+ (CGFloat)returnFromCount:(NSInteger)count;

@end
