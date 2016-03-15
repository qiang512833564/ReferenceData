//
//  TableViewCell.m
//  手势与cell的didSelectRowAiIndexPath冲突
//
//  Created by lizhongqiang on 16/3/15.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    return [super hitTest:point withEvent:event];
}
@end
