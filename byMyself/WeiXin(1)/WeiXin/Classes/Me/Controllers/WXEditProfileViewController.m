//
//  WXEditProfileViewController.m
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-21.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import "WXEditProfileViewController.h"

@interface WXEditProfileViewController ()

@end

@implementation WXEditProfileViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    
    self.title = self.profileCell.textLabel.text;
    self.textField.text = self.profileCell.detailTextLabel.text;
}

- (IBAction)cancleBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}




- (IBAction)saveBtnClick:(id)sender {
    
    // 保存编辑
    if ([self.editProfileDelegate respondsToSelector:@selector(editProfileViewControllerDidFinishedSave)]) {
        
        // 更新cell的detailTextLabel的文字
        self.profileCell.detailTextLabel.text = self.textField.text;
        
        [self.profileCell layoutSubviews];
        [self.editProfileDelegate editProfileViewControllerDidFinishedSave];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
