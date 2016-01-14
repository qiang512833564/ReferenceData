//
//  MorePictureCell.m
//  rrmj个人主页
//
//  Created by lizhongqiang on 15/8/26.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "MorePictureCell.h"
#import "UIImageView+WebCache.h"

CGFloat X = 10;
CGFloat length = 115;
@interface MorePictureCell ()<UIScrollViewDelegate>
@property (nonatomic, strong)UIImageView *lastImageView;
@end
@implementation MorePictureCell

- (void)awakeFromNib {
    // Initialization code
    _scrollView.delegate = self;
}
- (void)config:(int)index
{
    for(int i=0; i<index; i++)
    {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(X+(length+6.7)*i, 8, length, 87);
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.scrollView addSubview:imageView];
        [imageView setImageWithURL:[NSURL URLWithString:@"http://c.hiphotos.baidu.com/image/h%3D360/sign=6bb1c487d2a20cf45990f8d946094b0c/9d82d158ccbf6c81b2396fe8be3eb13533fa40a7.jpg"]];
        if(i == index - 1)
        {
            _lastImageView = imageView;
        }
        
    }
    self.scrollView.contentSize = CGSizeMake(index*(length+6.7)+2*X-6.7, 0);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat x = scrollView.contentOffset.x;
    
    
#if 1
    [scrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIImageView *imageView = (UIImageView *)obj;
        if(CGRectGetMaxX([_lastImageView frame]) - x <= scrollView.bounds.size.width)
        {
            return ;
        }
        if(CGRectGetMinX(imageView.frame)<=x&&CGRectGetMaxX(imageView.frame)>=x)
        {
            scrollView.contentOffset = CGPointMake(CGRectGetMinX(imageView.frame)-6.7/2.f, 0);
        }
    }];
#endif
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat x = scrollView.contentOffset.x;
    
    
#if 1
    [scrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIImageView *imageView = (UIImageView *)obj;
        if(CGRectGetMaxX([_lastImageView frame]) - x <= scrollView.bounds.size.width)
        {
            return ;
        }
        if(CGRectGetMinX(imageView.frame)<=x&&CGRectGetMaxX(imageView.frame)>=x)
        {
            scrollView.contentOffset = CGPointMake(CGRectGetMinX(imageView.frame)-6.7/2.f, 0);
        }
    }];
#endif
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
