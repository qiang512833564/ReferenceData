//
//  ActorsCell.m
//  rrmj个人主页
//
//  Created by lizhongqiang on 15/8/28.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ActorsCell.h"
#import "ImageView.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageDownloader.h"
@implementation ActorsCell

- (void)awakeFromNib {
    // Initialization code
    [self.moreBtn setTitleColor:[UIColor colorWithRed:153/255.f green:153/255.f blue:153/255.f alpha:1.0] forState:UIControlStateNormal];
}
- (IBAction)moreAction:(id)sender {
}
- (void)setIndex:(int)index
{
    for(int i=0; i<index; i++)
    {
        ImageView *imageView = [[ImageView alloc]initWithFrame:CGRectMake(13+i*(87+27), 9, 95, 130)];
        
        [imageView.imageView setImageWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=969466565,205201187&fm=116&gp=0.jpg"]];
        //imageView.backgroundColor = [UIColor redColor];
        SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
        
        [downloader downloadImageWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=969466565,205201187&fm=116&gp=0.jpg"] options:SDWebImageDownloaderUseNSURLCache progress:^(NSUInteger receivedSize, long long expectedSize) {
            
        } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            [imageView setImage:image forState:UIControlStateNormal];
        }];
        NSString *title1 = @"艾米利亚-克莱克";
        NSString *title2 = @"饰演 龙女";
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n%@",title1,title2]];
        NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc]init];
        para.paragraphSpacing = 1.0;
        para.alignment = NSTextAlignmentCenter;
        [attributedStr addAttributes:@{NSParagraphStyleAttributeName:para} range:NSMakeRange(0, attributedStr.string.length)];
        [attributedStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.5],NSForegroundColorAttributeName:[UIColor colorWithRed:240/255.f green:48/255.f blue:129/255.f alpha:1.0]} range:NSMakeRange(0, title1.length)];
        [attributedStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.5],NSForegroundColorAttributeName:[UIColor colorWithRed:34/255.f green:34/255.f blue:34/255.f alpha:1.0]} range:NSMakeRange(title1.length+2, title2.length-1)];
        [imageView setAttributedTitle:attributedStr forState:UIControlStateNormal];
        //imageView.titleLabel.attributedText = attributedStr;
        
        [self.scrollView addSubview:imageView];
        
        if(index == i+1)
        {
            self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(imageView.frame)+13, 0);
        }
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
