//
//  WXRegisterViewController.h
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-19.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WXRegisterViewControllerDelegate <NSObject>

// 注册完成
-(void)registerViewControllerDidfinishedRegister;

@end

@interface WXRegisterViewController : UIViewController

@property(nonatomic,weak)id<WXRegisterViewControllerDelegate> delegate;

@end
