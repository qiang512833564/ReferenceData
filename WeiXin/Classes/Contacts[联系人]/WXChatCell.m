//
//  WXChatCell.m
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-22.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import "WXChatCell.h"

@implementation WXChatCell

+(instancetype)chatCellWithTableView:(UITableView *)tableView{
 
    static NSString *ID = @"ChateCell";
    WXChatCell *chatCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (nil == chatCell) {
        chatCell = [[WXChatCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    return chatCell;
    
}

@end
