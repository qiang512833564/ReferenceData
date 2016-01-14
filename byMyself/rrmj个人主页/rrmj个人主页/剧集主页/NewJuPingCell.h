//
//  NewJuPingCell.h
//  rrmj个人主页
//
//  Created by lizhongqiang on 15/8/28.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewJuPingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *JupingHeight;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *instroductionWidth;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateAndtitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *introduction;

@end
