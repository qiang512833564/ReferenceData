//
//  NewJuPingCell.m
//  rrmj个人主页
//
//  Created by lizhongqiang on 15/8/28.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "NewJuPingCell.h"
#import "UIImageView+WebCache.h"
@implementation NewJuPingCell

- (void)awakeFromNib {
    // Initialization code
    self.rightImageVIew.contentMode = UIViewContentModeScaleAspectFill;
    self.rightImageVIew.layer.masksToBounds = YES;
    self.dateAndtitleLabel.textColor = [UIColor colorWithRed:153/255.f green:153/255.f blue:153/255.f alpha:1.0];
    self.introduction.textColor = [UIColor colorWithRed:102/255.f green:102/255.f blue:102/255.f alpha:1.0];
    self.titleLabel.textColor = [UIColor colorWithRed:34/255.f green:34/255.f blue:34/255.f alpha:1.0];
    self.dateAndtitleLabel.font = [UIFont systemFontOfSize:36/3.f];
    [self.rightImageVIew setImageWithURL:[NSURL URLWithString:@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=444406892,431981687&fm=116&gp=0.jpg"]];
}

- (void)drawRect:(CGRect)rect
{
    if(self.tipLabel.text.length)
    {
        return;
    }
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, 0, 0.4);
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(self.bounds),  0.4);
    CGContextSetLineWidth(ctx, 0.4);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:220/255.f green:221/255.f blue:222/255.f alpha:1.0].CGColor);
    CGContextDrawPath(ctx, kCGPathStroke);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
