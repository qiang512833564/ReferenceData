//
//  WCEditVCardViewController.h
//  XMPP
//
//  Created by lizhongqiang on 15/9/27.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WCEditVCardViewController;
@protocol WCEditVCardViewControllerDelegate <NSObject>

- (void)editVCardViewController:(WCEditVCardViewController *)editVC didFinishedSave:(id)sender;

@end
@interface WCEditVCardViewController : UITableViewController
@property (nonatomic, strong)UITableViewCell *cell;
@property (weak,nonatomic)id<WCEditVCardViewControllerDelegate>delegate;
@end
