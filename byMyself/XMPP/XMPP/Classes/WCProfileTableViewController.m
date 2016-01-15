//
//  WCProfileTableViewController.m
//  XMPP
//
//  Created by lizhongqiang on 15/9/27.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "WCProfileTableViewController.h"
#import "XMPPvCardTemp.h"
#import "WCEditVCardViewController.h"
@interface WCProfileTableViewController ()<WCEditVCardViewControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *wechatNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *orgNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *departmentLabel;//部门
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//职位
@property (weak, nonatomic) IBOutlet UILabel *telLabel;//电话
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@end

@implementation WCProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.它内部会去数据查找
    //为什么电子名片的模型是temp,因为解析电子名片的xml没有完善，有些节点并未解析，所以成为临时
    XMPPvCardTemp *myvCard = [WCXMPPTool sharedWCXMPPTool].vCard.myvCardTemp;
    
    //获取头像
    if(myvCard.photo){
        self.avatarImageView.image = [UIImage imageWithData:myvCard.photo];
    }
    
    //微信号(用户名)
    //为什么jid是空，原因使因为服务器返回的电子名片xmp数据没有JABBERJID的节点
    if(myvCard.jid){
        self.wechatNumLabel.text = myvCard.jid.user;
    }else{
        self.wechatNumLabel.text = [@"微信号:" stringByAppendingString:[WCAccount shareAccount].loginUser];
    }
    
    self.nicknameLabel.text = myvCard.nickname;
    
    self.orgNameLabel.text = myvCard.orgName;
    if(myvCard.orgUnits.count>0)
    {
     self.departmentLabel.text = myvCard.orgUnits[0];
    }
    self.titleLabel.text = myvCard.title;
    self.telLabel.text = myvCard.note;
    self.emailLabel.text = myvCard.mailer;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    switch (selectedCell.tag) {
        case 0:
            WCLog(@"换头像");
            [self chooseImage];
            break;
        case 1:
            WCLog(@"进入下一个控制器");
            [self performSegueWithIdentifier:@"toEditVCSegue" sender:selectedCell];
            break;
        case 2:
            WCLog(@"不做任何操作")
            break;
        default:
            break;
    }
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    WCLog(@"");
    //获取目标控制器
    id destVC= segue.destinationViewController;
    if([destVC isKindOfClass:[WCEditVCardViewController class]])
    {
        WCEditVCardViewController *editVC  = (WCEditVCardViewController *)destVC;
        editVC.cell = (UITableViewCell *)sender;
        //设置代理
        editVC.delegate = self;
    }
    //设置编辑电子名片控制器的cell属性
    
}
#pragma mark ---- 选择图片
- (void)chooseImage
{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"照相" otherButtonTitles:@"图片库", nil];
    [sheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 2)
    {
        return;
    }
    //图片选择器
    UIImagePickerController *imgPC = [[UIImagePickerController alloc]init];
    imgPC.delegate = self;
    imgPC.allowsEditing = YES;//允许编辑图片
    
    if(buttonIndex == 0){//照相
        imgPC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{//图片库
        imgPC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imgPC animated:YES completion:^{
        
    }];
}
#pragma mark --- 图片选择成功后的代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    WCLog(@"%@",info);
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    self.avatarImageView.image = editedImage;
    
    //移除图片选择的服务器
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //把新的图片保存到服务器
    [self editVCardViewController:nil didFinishedSave:nil];
}
#pragma mark --- 编辑电子名片控制器的代理
- (void)editVCardViewController:(WCEditVCardViewController *)editVC didFinishedSave:(id)sender
{
    WCLog(@"开始保存");
    //获取当前电子名片
    XMPPvCardTemp *myCard = [WCXMPPTool sharedWCXMPPTool].vCard.myvCardTemp;
    
    //重新设置头像
    myCard.photo = UIImageJPEGRepresentation(self.avatarImageView.image, 1.00);
    
    //重新设置myVcard里面的属性
    myCard.nickname = self.nicknameLabel.text;
    myCard.orgName = self.orgNameLabel.text;
    if(self.departmentLabel.text!=nil)
    {
        myCard.orgUnits = @[self.departmentLabel.text];
    }
    myCard.title=self.titleLabel.text;
    myCard.note = self.telLabel.text;
    myCard.mailer = self.emailLabel.text;
    //把数据保存到服务器
    [[WCXMPPTool sharedWCXMPPTool].vCard updateMyvCardTemp:myCard];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/




@end
