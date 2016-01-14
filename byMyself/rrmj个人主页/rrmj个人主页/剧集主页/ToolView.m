//
//  ToolView.m
//  rrmj个人主页
//
//  Created by lizhongqiang on 15/8/28.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ToolView.h"
#import "ShowScoreView.h"
#define kBtnWidth (83)
@implementation ToolView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithRed:252/255.f green:253/255.f blue:255/255.f alpha:1.0];
        //------
        CGFloat spaceX = (CGRectGetWidth(frame) - 3*kBtnWidth)/(3*2.f);
        NSArray *normal = @[@"icon_tab_score_n",@"icon_tab_community_n",@"icon_tab_video_n"];
        NSArray *height =@[@"icon_tab_score_h",@"icon_tab_community_h",@"icon_tab_video_h"];
        NSArray *titleArray = @[@" 评分",@" 专区",@" 追剧"];
        for(int i=0; i<3; i++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(spaceX+(2*spaceX+kBtnWidth)*i, 10, kBtnWidth, CGRectGetHeight(frame)-2*10);
            [btn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            [btn setImage:[UIImage imageNamed:normal[i]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:height[i]] forState:UIControlStateHighlighted];
            [self addSubview:btn];
            [btn setBackgroundImage:[self createImageByColor:[UIColor colorWithRed:23/255.f green:176/255.f blue:252/255.f alpha:1.0]] forState:UIControlStateHighlighted];
        }
    }
    return self;
}
- (UIImage *)createImageByColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1.f, 1.f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    
    CGContextFillRect(ctx, rect);
    
    CGContextDrawPath(ctx, kCGPathFill);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}
- (void)tapAction:(UIButton *)btn
{
    if([btn.titleLabel.text isEqualToString:@" 评分"])
    {
        NSLog(@"%@",btn.titleLabel.text);
        [[ShowScoreView sharedShowScoreView] showScoreView];
    }
    if([btn.titleLabel.text isEqualToString:@" 专区"])
    {
        NSLog(@"%@",btn.titleLabel.text);
    }
    if([btn.titleLabel.text isEqualToString:@" 追剧"])
    {
        NSLog(@"%@",btn.titleLabel.text);
    }

}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, CGRectGetWidth(self.frame), 0);
    CGContextSetLineWidth(ctx, 0.3);
    CGContextSetStrokeColorWithColor(ctx, [UIColor lightGrayColor].CGColor);
    CGContextDrawPath(ctx, kCGPathStroke);
}


@end
