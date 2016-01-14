//
//  IntroductionCell.m
//  rrmj个人主页
//
//  Created by lizhongqiang on 15/8/28.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "IntroductionCell.h"
@interface IntroductionCell ()

@end
@implementation IntroductionCell

- (void)awakeFromNib {
    // Initialization code
    self.introduction.textColor = [UIColor colorWithRed:102/255.f green:102/255.f blue:102/255.f alpha:1.0];
    self.movieName.textColor = self.introduction.textColor;
    self.tvName.textColor = self.introduction.textColor;
    self.typeName.textColor = self.introduction.textColor;
    
    
    [self.pullBtn setImage:[UIImage imageNamed:@"btn_drama_collapse"] forState:UIControlStateSelected];
    //self.pullBtn.backgroundColor = [UIColor blackColor];
}
- (IBAction)pullAction:(id)sender {
    
    switch (self.pullBtn.selected) {
        case 0:
        {
            self.pullBtn.selected = YES;
            self.introductionHeight.constant = [IntroductionCell returnFromNSString:self.introduction.text];
        }
            break;
            
        default:
        {
            self.introductionHeight.constant = 73;
            if([IntroductionCell returnFromNSString:_introduction.text]<73)
            {
                self.introductionHeight.constant = [IntroductionCell returnFromNSString:_introduction.text];
            }
            self.pullBtn.selected = NO;
        }
            break;
    }
    [UIView animateWithDuration:1.0 animations:^{
        [self.introduction layoutIfNeeded];
    }];
  
    if(self.updateContraints)
    {
        self.updateContraints();
    }
}
- (void)setTitle:(NSString *)title
{
    self.introduction.text = title;
    if([IntroductionCell returnFromNSString:_introduction.text]<73)
    {
        self.introductionHeight.constant = [IntroductionCell returnFromNSString:_introduction.text];
    }
}
+ (CGFloat)returnFromNSString:(NSString *)title
{
    CGRect bounds = [title boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 16, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];//,NSLinkAttributeName:NSLineBreakByTruncatingTail
    
    return bounds.size.height+5;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
