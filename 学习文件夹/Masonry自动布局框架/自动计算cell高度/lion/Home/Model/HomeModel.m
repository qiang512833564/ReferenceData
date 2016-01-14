//
//  HomeModel.m
//  thinklion
//
//  Created by user on 15/12/5.
//  Copyright (c) 2015年 user. All rights reserved.
//  本人也是iOS开发者 一枚，酷爱技术 这是我的官方交流群  519797474

#import "HomeModel.h"
#import "HomeViewCell.h"

@implementation HomeModel

//惰性初始化是这样写的
-(CGFloat)cellHeight
{
    //只在初始化的时候调用一次就Ok
    if(!_cellHeight){
        HomeViewCell *cell=[[HomeViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeIndentifier];
        NSLog(@"我要计算高度");
        // 调用cell的方法计算出高度
        _cellHeight=[cell rowHeightWithCellModel:self];
    
    }
    
    
    return _cellHeight;
}

@end
