//
//  WXContactCell.h
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-22.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPPUserCoreDataStorageObject.h"

@interface WXContactCell : UITableViewCell

+(instancetype)contactCellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property(nonatomic,strong)XMPPUserCoreDataStorageObject *mFriend;
@end
