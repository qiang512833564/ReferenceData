//
//  WXEditProfileViewController.h
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-21.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WXEditProfileViewControllerDelegate <NSObject>

-(void)editProfileViewControllerDidFinishedSave;

@end

@interface WXEditProfileViewController : UITableViewController



@property(nonatomic,strong)UITableViewCell *profileCell;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property(nonatomic,weak)id<WXEditProfileViewControllerDelegate> editProfileDelegate ;

@end
