//
//  DynamicTableViewCell.h
//  rrmj个人主页
//
//  Created by lizhongqiang on 15/8/26.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *PartLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIView *picturesView;
@property (weak, nonatomic) IBOutlet UILabel *timeSourceLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *comtentBtn;
@property (weak, nonatomic) IBOutlet UIButton *goodBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picturesHeightConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *starIcon;
- (void)config:(int)number;
@end
