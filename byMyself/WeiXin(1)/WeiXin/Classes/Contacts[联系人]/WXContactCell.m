//
//  WXContactCell.m
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-22.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import "WXContactCell.h"

@interface WXContactCell()

@property (weak, nonatomic) IBOutlet UILabel *displayNameLabel;

@end

@implementation WXContactCell

- (void)awakeFromNib {
    // Initialization code
}

+(instancetype)contactCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"WXContactCell";
    WXContactCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WXContactCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
}


-(void)setMFriend:(XMPPUserCoreDataStorageObject *)mFriend{
    _mFriend = mFriend;
    
    // 有昵称用昵称，没有使用账号
    XMPPUserCoreDataStorageObject *friend = mFriend;
    NSString *displayName = friend.nickname;
    if (!friend.nickname) {
        displayName = friend.jid.user;
    }
    
    NSString *onlineStatus = @"[离线]";
    switch ([friend.sectionNum intValue]) {
        case 0:
            onlineStatus = @"[在线]";
            break;
        case 1:
            onlineStatus = @"[离开]";
            break;
        case 2:
            onlineStatus = @"[离线]";
            break;
        default:
            onlineStatus = @"[见鬼了]";
            break;
    }
    
    
    
    self.displayNameLabel.text = [NSString stringWithFormat:@"%@ %@",onlineStatus,displayName];
}

@end
