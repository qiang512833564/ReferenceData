//
//  WFChatCell.h
//  ChatPageDemo
//
//  Created by Yong Feng Guo on 14-12-16.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const WFReuseIdOfReceiveCell;//自己发
extern NSString *const WFReuseIdOfSendCell;//别人发
@interface WFChatCell : UITableViewCell

/**
 * reuseId 传WFChatCellToType 或者 WFChatCellFromType
 */
+(instancetype)chatCellWithTableView:(UITableView *)tableView reuseId:(NSString *)reuseId;


#pragma mark 属性

/**
 *头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;

/**
 *聊天消息
 */
@property (copy, nonatomic)NSString *msg;


@property (weak, nonatomic) IBOutlet UILabel *msgLabel;


@end
