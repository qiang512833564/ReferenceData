//
//  TableViewCell.m
//  EGO_BaseRefresh
//
//  Created by lizhongqiang on 15/12/24.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "TableViewCell.h"
#import "UIView+AutoLayout.h"
@interface TableViewCell()
@property (nonatomic, strong)UILabel *moneyLabel;
@property (nonatomic, strong)UILabel *subTitle;
@end
@implementation TableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        _moneyLabel = [UILabel newAutoLayoutView];
        _moneyLabel.textAlignment = NSTextAlignmentRight;
        _moneyLabel.font = [UIFont systemFontOfSize:20.0f];
        [self.contentView addSubview:_moneyLabel];
        _moneyLabel.text = @"10000";
        //_moneyLabel.backgroundColor = [UIColor greenColor];
        [_moneyLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:5.5];
        //        self.bottom =[_moneyLabel autoConstrainAttribute:ALDimensionHeight toAttribute:ALDimensionHeight ofView:nil withOffset:20 relation:NSLayoutRelationEqual];
        [_moneyLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:-15];
        [_moneyLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:0];
        
        _subTitle = [UILabel newAutoLayoutView];
        _subTitle.textAlignment = NSTextAlignmentRight;
        _subTitle.font = [UIFont systemFontOfSize:12];
        _subTitle.textColor = [UIColor grayColor];
        _subTitle.text = @"副标题";
        _subTitle.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_subTitle];
        //        [UIView autoSetPriority:750 forConstraints:^{
        //            self.bottom = [_subTitle autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.contentView withOffset:-5.5];
        //        }];
        
        //        [_subTitle autoConstrainAttribute:ALDimensionHeight toAttribute:ALDimensionHeight ofView:nil withOffset:20 relation:NSLayoutRelationEqual];
        [_subTitle autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:-15];
        [_subTitle autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:0];
        
        [_moneyLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:_subTitle withOffset:0];

    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
