//
//  RepresentCell.m
//  rrmj个人主页
//
//  Created by lizhongqiang on 15/8/26.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "RepresentCell.h"
#import "CustomImageView.h"

CGFloat spaceX = 10;
CGFloat width = 83;
@interface RepresentCell ()<UIScrollViewDelegate>
@property (nonatomic, strong)CustomImageView *lastImageView;
@end
@implementation RepresentCell

- (void)awakeFromNib {
    // Initialization code
    
    self.scrollView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)config:(int)index
{
    for(int i=0; i<index; i++)
    {
        CustomImageView *imageView = [[[NSBundle mainBundle]loadNibNamed:@"CustomImageView" owner:self options:nil]lastObject];
        imageView.frame = CGRectMake(spaceX+(width+20)*i, 2, width, 110);
        imageView.starLabel.text = @"9.5";
        [self.scrollView addSubview:imageView];
        if(i == index - 1)
        {
            _lastImageView = imageView;
        }
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)]];
    }
    
    self.scrollView.contentSize = CGSizeMake(index*(width+20), 0);
}
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    UIImageView *imageView = (UIImageView *)tap.view;
    CGRect rect = [imageView convertRect:imageView.frame toView:nil];
    
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat x = scrollView.contentOffset.x;
    
    
#if 1
    [scrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CustomImageView *imageView = (CustomImageView *)obj;
        if(CGRectGetMaxX([_lastImageView frame]) - x <= scrollView.bounds.size.width)
        {
            return ;
        }
        if(CGRectGetMinX(imageView.frame)<=x&&CGRectGetMaxX(imageView.frame)>=x)
        {
            scrollView.contentOffset = CGPointMake(CGRectGetMinX(imageView.frame)-spaceX, 0);
        }
    }];
#endif
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat x = scrollView.contentOffset.x;
    
    
#if 1
    [scrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CustomImageView *imageView = (CustomImageView *)obj;
        if(CGRectGetMaxX([_lastImageView frame]) - x <= scrollView.bounds.size.width)
        {
            return ;
        }
        if(CGRectGetMinX(imageView.frame)<=x&&CGRectGetMaxX(imageView.frame)>=x)
        {
            scrollView.contentOffset = CGPointMake(CGRectGetMinX(imageView.frame)-spaceX, 0);
        }
    }];
#endif
}

@end
