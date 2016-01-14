//
//  PicturesCell.h
//  rrmj个人主页
//
//  Created by lizhongqiang on 15/8/28.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicturesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numberPictures;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (nonatomic, assign)int number;
@end
