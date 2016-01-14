//
//  ScrollView.m
//  photoBrowser
//
//  Created by lizhongqiang on 15/7/10.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ScrollView.h"

@implementation ScrollView

- (instancetype)init
{
    if(self = [super init])
    {
        self.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 2*64);
        
        self.backgroundColor = [UIColor blackColor];
        
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    return self;
}
- (void)show
{
    UIView *sourceView = self.sourceImagesContainerView.subviews[self.currentImageIndex];
    
    UIView *parentView = [self getParsentView:sourceView];
    
    CGRect rect = [sourceView.superview convertRect:sourceView.frame toView:parentView];

    if([parentView isKindOfClass:[UITableView class]])
    {
        UITableView *tableView = (UITableView *)parentView;
        
        rect.origin.y -= tableView.contentOffset.y;
    }
    
    UIImageView *imageView = [[UIImageView alloc]init];
    
    imageView.frame = rect;
    
    [self addSubview:imageView];
    
    imageView.image = [self placeholderImageForIndex:self.currentImageIndex];
    
    NSLog(@"%@",NSStringFromCGSize(imageView.image.size));
    
    CGRect newRect;
    
    CGFloat appWidth = self.bounds.size.width;
    
    CGFloat appHeight = self.bounds.size.height;
    
    CGFloat placeHolderH = (imageView.image.size.height*appWidth)/imageView.image.size.width;
    
    if(placeHolderH <= appHeight)
    {
        newRect = CGRectMake(0, (appHeight - placeHolderH)/2.f, self.frame.size.width, placeHolderH);
    }
    else
    {
        
        newRect = CGRectMake(0, 0, self.frame.size.width, placeHolderH);
    }
    
    
    
    [UIView animateWithDuration:0.5f animations:^{
        
        imageView.frame = newRect;
        
    }completion:^(BOOL finished) {
        
        [imageView removeFromSuperview];
        
        self.hidden = NO;
        
    }];
}
- (void)setImageCount:(NSInteger)imageCount
{
    _imageCount = imageCount;
    
    self.contentSize = CGSizeMake(imageCount*self.bounds.size.width, 0);
}
#pragma mark 获取控制器的view
- (UIView *)getParsentView:(UIView *)view{
    if ([view isKindOfClass:[UITableView class]]) {
        return view;
    }
    return [self getParsentView:view.superview];
}
#pragma mark 获取低分辨率（占位）图片
- (UIImage *)placeholderImageForIndex:(NSInteger)index
{
    if ([self.customDelegate respondsToSelector:@selector(photoBrowser:)]) {
        return [self.customDelegate photoBrowser:index];
    }
    return nil;
}
@end
