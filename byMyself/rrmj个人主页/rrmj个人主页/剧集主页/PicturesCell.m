//
//  PicturesCell.m
//  rrmj个人主页
//
//  Created by lizhongqiang on 15/8/28.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "PicturesCell.h"
#import "UIImageView+WebCache.h"
#define kSpaceX (10)
@implementation PicturesCell

- (void)awakeFromNib {
    // Initialization code
    [self.moreBtn setTitleColor:[UIColor colorWithRed:153/255.f green:153/255.f blue:153/255.f alpha:1.0] forState:UIControlStateNormal];
}
- (IBAction)moreAction:(id)sender {
}
- (void)setNumber:(int)number
{
    for(int i=0; i<number; i++)
    {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.masksToBounds = YES;
        [imageView setImageWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=858113953,1259575755&fm=116&gp=0.jpg"]];
        imageView.frame = CGRectMake(kSpaceX+i*(115+6.7), 0, 115, 90);
        [self.scrollView addSubview:imageView];
        
        if(i+1 == number)
        {
            self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(imageView.frame)+kSpaceX, 0);
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
