//
//  DetailViewController.h
//  MyPrograme
//
//  Created by lizhongqiang on 16/1/5.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (nonatomic, assign)NSInteger indexRow;
@end

