//
//  RootViewController.h
//  SpecialCellDemo
//
//  Created by hw500029 on 15/12/28.
//  Copyright © 2015年 MYP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end
