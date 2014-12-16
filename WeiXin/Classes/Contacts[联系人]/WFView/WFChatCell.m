//
//  WFChatCell.m
//  ChatPageDemo
//
//  Created by Yong Feng Guo on 14-12-16.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import "WFChatCell.h"
NSString *const WFReuseIdOfReceiveCell = @"ReceiveCell";//自己发
NSString *const WFReuseIdOfSendCell = @"SendCell";//别人发


@interface WFChatCell()


@end


@implementation WFChatCell


+(instancetype)chatCellWithTableView:(UITableView *)tableView reuseId:(NSString *)reuseId{
    
    WFChatCell *chatCell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    //NSLog(@"%p",reuseId);
    if (chatCell == nil) {
        NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"WFChatCell" owner:nil options:nil];
        for (WFChatCell *tmpChatCell in cells) {
            if ([tmpChatCell.reuseIdentifier isEqualToString:reuseId]) {
                chatCell = tmpChatCell;
                break;
            }
        }
    }
    
    NSAssert(chatCell != nil, @"WFChatCell.xib 缺少 两种类型【ToCell / FromCell】的表格Cell ");
    
    //设置颜色
//    if ([reuseId isEqualToString:WFReuseIdOfReceiveCell]) {
//        chatCell.backgroundColor = [UIColor grayColor];
//    }else{
//        chatCell.backgroundColor = [UIColor purpleColor];
//    }
//    

//    UIView *bg = [[UIView alloc] init];
//    bg.backgroundColor = [UIColor clearColor];
//    chatCell.selectedBackgroundView = bg;
//    chatCell.backgroundView = bg;
    
    chatCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return chatCell;
}


-(void)setMsg:(NSString *)msg{
    _msg = msg;

    //设置面容
    self.msgLabel.text = _msg;
    
}

-(void)awakeFromNib{
    //设置label最大的宽度
    self.msgLabel.preferredMaxLayoutWidth = 260;
}




@end
