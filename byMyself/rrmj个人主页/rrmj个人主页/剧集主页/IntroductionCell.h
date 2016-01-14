//
//  IntroductionCell.h
//  rrmj个人主页
//
//  Created by lizhongqiang on 15/8/28.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroductionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *movieName;
@property (weak, nonatomic) IBOutlet UILabel *tvName;
@property (weak, nonatomic) IBOutlet UILabel *typeName;
@property (weak, nonatomic) IBOutlet UILabel *introduction;
@property (weak, nonatomic) IBOutlet UIButton *pullBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *introductionHeight;
@property (nonatomic, strong)void (^updateContraints)(void);
@property (nonatomic, copy)NSString *title;
+ (CGFloat)returnFromNSString:(NSString *)title;
@end
