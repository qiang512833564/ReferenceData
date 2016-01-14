//
//  HomeViewCell.h
//  thinklion
//
//  Created by user on 15/12/5.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@class HomeModel;

static  NSString *homeIndentifier=@"homeCell";

@interface HomeViewCell : UITableViewCell

//数据模型
@property (nonatomic,strong) HomeModel *homeModel;

//我们最后得到cell的高度的方法
-(CGFloat)rowHeightWithCellModel:(HomeModel *)homeModel;

@end
