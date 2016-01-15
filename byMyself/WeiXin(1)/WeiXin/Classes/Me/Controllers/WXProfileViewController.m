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
#import "WXEditProfileViewController.h"
#import "WXNavigationController.h"

@interface WXProfileViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,WXEditProfileViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *orgNameLabel;//公司名
@property (weak, nonatomic) IBOutlet UILabel *orgUnitsLabel;//部门
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//职位
@property (weak, nonatomic) IBOutlet UILabel *telLabel;//电话
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;//邮箱

@property(nonatomic,strong)NSIndexPath *selectedIndexPath;

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
    XMPPvCardTemp *myvCard = [WXXMPPTools sharedWXXMPPTools].vCardModule.myvCardTemp;
    
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
    //self.emailLabel.text = myvCard.mailer;
    if (myvCard.emailAddresses.count > 0) {
        self.emailLabel.text = myvCard.emailAddresses[0];
    }

    
    WXLog(@"%@",myvCard.emailAddresses);
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedIndexPath = indexPath;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.tag == 2) return;//不处理
    
    if (cell.tag == 0) {//图片选择
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从手机相册选择", nil];
        sheet.delegate = self;
        [sheet showInView:self.view];
    }else{//修改数据
        [self performSegueWithIdentifier:@"editProfileSegue" sender:cell];
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
        WXLog(@"......");
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
    
    // 保存头像到服务器
    [self editProfileViewControllerDidFinishedSave];
    
    // 在ipad上，选择图片后，导航栏主题会变黑
    [WXNavigationController setupTheme];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
   
    if ([segue.destinationViewController isKindOfClass:[WXEditProfileViewController class]]) {
        // 获取目标控制器
        WXEditProfileViewController *editProfileVc = segue.destinationViewController;
        editProfileVc.editProfileDelegate = self;
        editProfileVc.profileCell = sender;
        
    }
    
}


-(void)editProfileViewControllerDidFinishedSave{
    
    XMPPvCardTemp *myVCard = [WXXMPPTools sharedWXXMPPTools].vCardModule.myvCardTemp;
    
    // 设置头像
    NSData *headData = UIImagePNGRepresentation(self.headView.image);
    myVCard.photo = headData;
    
    //昵称
    myVCard.nickname = self.nickNameLabel.text;
    //公司
    myVCard.orgName = self.orgNameLabel.text;
    //部门
    if(self.orgUnitsLabel.text.length != 0){
        myVCard.orgUnits = @[self.orgUnitsLabel.text];
    }
    
    //职位
    myVCard.title = self.titleLabel.text;
    //电话
    myVCard.note = self.telLabel.text;
    // 邮箱
    myVCard.mailer = self.emailLabel.text;
    myVCard.emailAddresses = @[self.emailLabel.text];
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 更新保存到服务器
        [[WXXMPPTools sharedWXXMPPTools].vCardModule updateMyvCardTemp:myVCard];
    });
    
}


@end
