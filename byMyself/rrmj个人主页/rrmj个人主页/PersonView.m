//
//  PersonView.m
//  rrmj个人主页
//
//  Created by lizhongqiang on 15/8/27.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "PersonView.h"
#import "UIImageView+WebCache.h"

@implementation PersonView

- (instancetype)init
{
    if(self = [super init])
    {
        UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self addSubview:iconImageView];
        iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        [iconImageView setImageWithURL:[NSURL URLWithString:@"http://h.hiphotos.baidu.com/image/h%3D360/sign=ac686a399045d688bc02b4a294c37dab/4b90f603738da97756872521b251f8198618e314.jpg"]];
        iconImageView.layer.cornerRadius = 36;
        iconImageView.layer.masksToBounds = YES;
        iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        UIImageView *iconStar = [[UIImageView alloc]init];
        iconStar.image = [UIImage imageNamed:@"icon_star_big"];
        iconStar.contentMode = UIViewContentModeScaleAspectFill;
        iconStar.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:iconStar];
        
        NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:iconImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
        NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:iconImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:8];
        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:iconImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:72];
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:iconImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:72];
        [self addConstraints:@[centerX,centerY,width,height]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:iconStar attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:iconImageView attribute:NSLayoutAttributeCenterX multiplier:1 constant:36]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:iconStar attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:iconImageView attribute:NSLayoutAttributeCenterY multiplier:1 constant:12]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:iconStar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:25]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:iconStar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:25]];
        
        UILabel *chineseName = [[UILabel alloc]initWithFrame:CGRectZero];
        UILabel *englishName = [[UILabel alloc]initWithFrame:CGRectZero];
        [self addSubview:chineseName];
        [self addSubview:englishName];
        chineseName.textAlignment = NSTextAlignmentCenter;
        englishName.textAlignment = NSTextAlignmentCenter;
        chineseName.font = [UIFont systemFontOfSize:16.2];
        englishName.font = [UIFont systemFontOfSize:10];
        chineseName.textColor = [UIColor whiteColor];
        englishName.textColor = [UIColor whiteColor];
        
        chineseName.translatesAutoresizingMaskIntoConstraints = NO;
        englishName.translatesAutoresizingMaskIntoConstraints = NO;
        
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:chineseName attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:chineseName attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:200]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:chineseName attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:16]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:chineseName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:iconImageView attribute:NSLayoutAttributeBottom multiplier:1 constant:8]];
        
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:englishName attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:englishName attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:200]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:englishName attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:10]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:englishName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:chineseName attribute:NSLayoutAttributeBottom multiplier:1 constant:7]];
        
        chineseName.text = @"艾米利亚*克拉克";
        englishName.text = @"Emilia Clarke";
        
        
        _iconImageView = iconImageView;
        _iconStar = iconStar;
        _nameLabel = chineseName;
        _englishLabel = englishName;
    }
    return self;
}

@end
