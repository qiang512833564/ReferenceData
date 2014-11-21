//
//  WXProfileViewController.m
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-21.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import "WXProfileViewController.h"
#import "AppDelegate.h"
#import "XMPPvCardTemp.h"

@interface WXProfileViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *orgNameLabel;//公司名
@property (weak, nonatomic) IBOutlet UILabel *orgUnitsLabel;//部门
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//职位
@property (weak, nonatomic) IBOutlet UILabel *telLabel;//电话
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;//邮箱
@end

@implementation WXProfileViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    // 设置头像圆角 + 边框
    self.headView.layer.cornerRadius = 6;
    self.headView.layer.masksToBounds = YES;
    self.headView.layer.borderColor = [UIColor blackColor].CGColor;
    self.headView.layer.borderWidth = 0.2;
    
    [self setupVCard];
}

-(void)setupVCard{
    // 获取本人的电子名片
    XMPPvCardTemp *myvCard = xmppDelegate.vCardModule.myvCardTemp;
    
    if (nil == myvCard) {
        WXLog(@"未获取到本人电子名片数据");
        return;
    }
#warning 看PPT,查看有些数据是没有解析的
    if (myvCard.photo) {
        self.headView.image = [UIImage imageWithData:myvCard.photo];
    }
    // 昵称
    self.nickNameLabel.text = myvCard.nickname;
    // 微信号即用户名
    self.usernameLabel.text = [WXUserInfo sharedWXUserInfo].loginUserName;
    
    // 公司
    self.orgNameLabel.text = myvCard.orgName;
    
    // 部门
    if (myvCard.orgUnits.count > 0) {
        self.orgUnitsLabel.text = myvCard.orgUnits[0];
    }
    
    // 职位
    self.titleLabel.text = myvCard.title;
    
    // 电话
    //因为myCard.telecomsAddresses这个get方法，没有实现xml的数据解析，所以用note字段充当电话
    self.telLabel.text = myvCard.note;
    
    // 邮箱
    //因为myCard.emailAddresses这个get方法，没有实现xml的数据解析，所以用mailer字段充当邮箱
    self.emailLabel.text = myvCard.mailer;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    int tag = [tableView cellForRowAtIndexPath:indexPath].tag;
    if (tag == 2) return;//不处理
    
    if (tag == 0) {//图片选择
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从手机相册选择", nil];
        sheet.delegate = self;
        [sheet showInView:self.view];
    }else{//修改数据
        
    }
}

#pragma mark actionsheet的代理
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex > 1) return;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.delegate = self;
    if (buttonIndex == 0) {//照相
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else if(buttonIndex == 1){// 相册
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark 图片选择代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    WXLog(@"%@",info);
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.headView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
