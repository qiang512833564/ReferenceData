//
//  SimpleIntroductionCellTableViewCell.m
//  rrmj个人主页
//
//  Created by lizhongqiang on 15/8/26.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "SimpleIntroductionCell.h"

@implementation SimpleIntroductionCell

- (void)awakeFromNib {
    // Initialization code
    self.introductionLabel.textColor = [UIColor colorWithRed:102/255.f green:102/255.f blue:102/255.f alpha:1.0];
    [self.pullBtn setImage:[UIImage imageNamed:@"btn_drama_expansion"] forState:UIControlStateNormal];
    
    [self.pullBtn setImage:[UIImage imageNamed:@"btn_drama_collapse"] forState:UIControlStateSelected];
    
    self.introductionLabel.font = [UIFont systemFontOfSize:13];
    
    
    //self.introductionLabel.backgroundColor = [UIColor redColor];
}
- (IBAction)tapPullAction:(id)sender {

        if(self.pullBtn.selected)
        {
            self.introductionHeight.constant = 73.0f;
            /*
             self.introductionHeight = [NSLayoutConstraint constraintWithItem:self.introductionLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:73];
             [self.introductionLabel addConstraint:self.introductionHeight];
             */
        }
        else
        {
            self.introductionHeight.constant = [SimpleIntroductionCell returnFromNSString:self.introductionLabel.text];
            //[self.introductionLabel removeConstraint:self.introductionHeight];
        }
        if(self.updateContraints)
        {
            self.updateContraints();
        }
 
    
    
    
    switch (self.pullBtn.selected) {
        case 0:
            self.pullBtn.selected = YES;
            break;
            
        default:
            self.pullBtn.selected = NO;
            break;
    }
}
- (void)config:(NSString *)title
{
    self.introductionLabel.text = title;
 
    if([SimpleIntroductionCell returnFromNSString:title]<73)
    {
        //[self.introductionLabel removeConstraint:self.introductionHeight];
        self.introductionHeight.constant = [SimpleIntroductionCell returnFromNSString:title];
    }

    
}
+ (CGFloat)returnFromNSString:(NSString *)title
{
    CGRect bounds = [title boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 18, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];//,NSLinkAttributeName:NSLineBreakByTruncatingTail
    
    return bounds.size.height+9;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
