//
//  CustomImageView.m
//  rrmj个人主页
//
//  Created by lizhongqiang on 15/8/26.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "CustomImageView.h"
#import "UIImageView+WebCache.h"
#define starWidth (16)
#define starHeight (13)
@interface CustomImageView ()
@property (nonatomic, strong)UIImageView *star;
@end
@implementation CustomImageView
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        

    }
    return self;
}
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    self.star.frame = CGRectMake(CGRectGetWidth(frame) - starWidth, 0, starWidth, starHeight);
    self.starLabel.frame = CGRectOffset(self.star.bounds, 1, -3);
    self.star.image = [UIImage imageNamed:@"icon_score"];
//    [self.starLabel setBackgroundColor:[UIColor colorWithPatternImage:[[[UIImage imageNamed:@"icon_score"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]imageWithAlignmentRectInsets:UIEdgeInsetsMake(0.5, 0.5, 0, 0)]]];
}
- (void)awakeFromNib
{
    self.starLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.starLabel.textColor = [UIColor whiteColor];
    self.starLabel.adjustsFontSizeToFitWidth = YES;
    
    self.star = [[UIImageView alloc]init];
    [self.star addSubview:self.starLabel];
    [self addSubview:self.star];
    self.star.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.imageView setImageWithURL:[NSURL URLWithString:@"http://f.hiphotos.baidu.com/image/h%3D360/sign=344953e0d854564efa65e23f83df9cde/80cb39dbb6fd5266ad0b53e7ae18972bd4073624.jpg"]];
    self.titleLabel.text = @"权力的游戏";
    self.imageView.layer.masksToBounds = YES;
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.titleLabel.textColor = [UIColor grayColor];
}

@end
