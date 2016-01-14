//
//  DynamicTableViewCell.m
//  rrmj个人主页
//
//  Created by lizhongqiang on 15/8/26.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "DynamicTableViewCell.h"
#import "UIImageView+WebCache.h"

#define imageWidth (80)

@implementation DynamicTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    //self.picturesView.hidden = YES;
    
    [self.iconImageView setImageWithURL:[NSURL URLWithString:@"http://d.hiphotos.baidu.com/image/pic/item/8cb1cb13495409237656a4939658d109b3de4924.jpg"]];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius = 52/2.f;
    
    self.timeSourceLabel.textColor = [UIColor colorWithRed:153/255.f green:153/255.f blue:153/255.f alpha:1.0];
    //self.timeSourceLabel.font = [UIFont systemFontOfSize:10];//ArialMT Regular
    [self.shareBtn setTitleColor:self.timeSourceLabel.textColor forState:UIControlStateNormal];
    [self.comtentBtn setTitleColor:self.timeSourceLabel.textColor forState:UIControlStateNormal];
    [self.goodBtn setTitleColor:self.timeSourceLabel.textColor forState:UIControlStateNormal];
    
    [self.shareBtn setImage:[UIImage imageNamed:@"icon_news_share_n"] forState:UIControlStateNormal];
   // self.shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, self.shareBtn.frame.size.width);
    [self.comtentBtn setImage:[UIImage imageNamed:@"icon_list_review_n"] forState:UIControlStateNormal];//,
    [self.goodBtn setImage:[UIImage imageNamed:@"icon_list_link_n"] forState:UIControlStateNormal];

#if 0
    self.picturesHeightConstraint.constant = 0;
    
    [self setNeedsUpdateConstraints];
#endif
}
- (void)config:(int)number
{
    if(number == 0)
    {
        self.picturesHeightConstraint.constant = 0;
        [self setNeedsUpdateConstraints];
    }
    [self.picturesView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    for(int i=0; i<number; i++)
    {
        UIImageView *imageview = [[UIImageView alloc]init];
        imageview.layer.masksToBounds = YES;
        [self.picturesView addSubview:imageview];
        imageview.frame = CGRectMake(i*(imageWidth+10), 0, imageWidth, 67);
        
        [imageview setImageWithURL:[NSURL URLWithString:@"http://h.hiphotos.baidu.com/image/pic/item/a9d3fd1f4134970a8f47d7c291cad1c8a7865d23.jpg"]];
    }
}
- (IBAction)shareAction:(id)sender {
}
- (IBAction)comentAction:(id)sender {
}
- (IBAction)goodAction:(id)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
