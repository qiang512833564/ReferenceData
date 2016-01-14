//
//  AnnotationView.m
//  MapByMyself
//
//  Created by lizhongqiang on 15/8/24.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "AnnotationView.h"

@interface AnnotationView ()

@property (nonatomic, strong)UILabel *titleLabel;

@end

@implementation AnnotationView

- (void)setTitle:(NSString *)title
{
    if(_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 16)];
        [self addSubview:_titleLabel];
        _titleLabel.textColor = [UIColor redColor];
    }
    _titleLabel.text = title;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
