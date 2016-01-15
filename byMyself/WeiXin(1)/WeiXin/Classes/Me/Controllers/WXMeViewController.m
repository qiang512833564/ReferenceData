//
//  WXMeViewController.m
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-20.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import "WXMeViewController.h"
#import "AppDelegate.h"
#import "XMPPvCardTemp.h"

@interface WXMeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *weiXinHaoLabel;

@property (weak, nonatomic) IBOutlet UIImageView *avatorImageV;//头像

@end

@implementation WXMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *bundle = [[NSBundle mainBundle] bundlePath];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@",bundle);
    NSLog(@"%@",doc);
    
    // 设置电子名片信息
    //[self setupVCard];
}

-(void)setupVCard{
    // 获取本人的电子名片
    XMPPvCardTemp *myvCard = [WXXMPPTools sharedWXXMPPTools].vCardModule.myvCardTemp;

    if (nil == myvCard) {
        WXLog(@"未获取到本人电子名片数据");
        return;
    }
#warning 看PPT,查看有些数据是没有解析的
    if (myvCard.photo) {
        self.avatorImageV.image = [UIImage imageWithData:myvCard.photo];
        
       
        NSString *username = [WXUserInfo sharedWXUserInfo].loginUserName;
        self.weiXinHaoLabel.text = [NSString stringWithFormat:@"微信号:%@",username];
        
        self.nickNameLabel.text = myvCard.nickname;
    }
}

// 注销
- (IBAction)logoutBtnClick {
    
   // AppDelegate *app = [UIApplication sharedApplication].delegate;
    
    [[WXXMPPTools sharedWXXMPPTools] userLogout];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupVCard];
}
@end
