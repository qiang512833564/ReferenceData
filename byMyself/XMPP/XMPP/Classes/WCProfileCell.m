//
//  WCProfileCell.m
//  XMPP
//
//  Created by lizhongqiang on 15/9/27.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "WCProfileCell.h"
#import "XMPPvCardTemp.h"

@implementation WCProfileCell

- (void)awakeFromNib {
    // Initialization code
    //显示头像和微信号
    //从数据库里取出用户信息
    //获取登录用户信息的，使用电子名片模块
    //登录用户的电子名片信息
    //1.它内部会去数据查找
    XMPPvCardTemp *myvCard = [WCXMPPTool sharedWCXMPPTool].vCard.myvCardTemp;
    
    //获取头像
    if(myvCard.photo){
        self.avatarImgView.image = [UIImage imageWithData:myvCard.photo];
    }
    
    //微信号(用户名)
    //为什么jid是空，原因使因为服务器返回的电子名片xmp数据没有JABBERJID的节点
    if(myvCard.jid){
        self.wechatNumLabel.text = myvCard.jid.user;
    }else{
        self.wechatNumLabel.text = [@"微信号:" stringByAppendingString:[WCAccount shareAccount].loginUser];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
