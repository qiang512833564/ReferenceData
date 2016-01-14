//
//  ImageView.m
//  rrmj个人主页
//
//  Created by lizhongqiang on 15/8/28.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ImageView.h"
#define spaceX  (7)
@implementation ImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.imageView.layer.masksToBounds = YES;
        self.imageView.layer.cornerRadius = (CGRectGetWidth(frame) - 2*spaceX)/2.f;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.font = [UIFont systemFontOfSize:12.5];
    }
    return self;
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
     return CGRectMake(0,(CGRectGetWidth(contentRect) - 3*spaceX), CGRectGetWidth(contentRect) , CGRectGetHeight(contentRect) - (CGRectGetWidth(contentRect) - 2*spaceX));
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(spaceX, 0, CGRectGetWidth(contentRect) - 2*spaceX, CGRectGetWidth(contentRect) - 2*spaceX);

   
}

@end
