//
//  TableViewCell.m
//  photoBrowser
//
//  Created by lizhongqiang on 15/7/10.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "TableViewCell.h"
#import "UIButton+WebCache.h"
#import "ScrollView.h"

@interface TableViewCell ()<ScrollViewDelegate>

@end

@implementation TableViewCell

- (void)awakeFromNib {
    
}
- (void)setPicArr:(NSArray *)picArr
{
    _picArr = picArr;
    
    for(int i=0; i < picArr.count; i++)
    {
        int row = i%3;
        
        int clum = i/3;
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20+row*(100+16), 16+clum*(100+16), 100, 100)];
        
        btn.imageView.contentMode = UIViewContentModeScaleToFill;
        
        btn.clipsToBounds = YES;
        
        btn.tag = i+100;
        
        [btn sd_setImageWithURL:[NSURL URLWithString:picArr[i]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"whiteplaceholder"]];
        
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:btn];
    }
}
- (void)buttonClick:(UIButton *)btn
{
    ScrollView *scrollView = [[ScrollView alloc]init];
    
    scrollView.currentImageIndex = (int)btn.tag - 100;
    
    scrollView.customDelegate = self;
    
    scrollView.currentImageIndex = (int)_picArr.count;
    
    scrollView.sourceImagesContainerView = self.contentView;
    
    [scrollView show];
}

- (UIImage *)photoBrowser:(NSInteger)index
{
    return [self.contentView.subviews[index] currentImage];
}

+ (CGFloat)returnFromCount:(NSInteger)count
{
    int clum = (int)count/3;
    
    return (100+16)*clum+16;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
