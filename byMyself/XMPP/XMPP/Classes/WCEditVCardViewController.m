//
//  WCEditVCardViewController.m
//  XMPP
//
//  Created by lizhongqiang on 15/9/27.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "WCEditVCardViewController.h"

@interface WCEditVCardViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@end

@implementation WCEditVCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    self.title = self.cell.textLabel.text;
    
    self.textfield.text = self.cell.detailTextLabel.text;
}
- (IBAction)saveBtnClick:(id)sender {
    
    //1.把cell的detailTextLabel的值更改
    self.cell.detailTextLabel.text = self.textfield.text;
    //解决detailLabel返回的时候，不显示的BUG
    [self.cell layoutSubviews];
    
    //2.把当前控制器销毁
    [self.navigationController popViewControllerAnimated:YES];
    //3.报数据保存到服务器上去
    if([self.delegate respondsToSelector:@selector(editVCardViewController:didFinishedSave:)])
    {
        [self.delegate editVCardViewController:self didFinishedSave:sender];
    }
}
- (IBAction)cancelBtnClick:(id)sender {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
