//
//  CustomCell.h
//  Cell-autoLayout
//
//  Created by lizhongqiang on 15/12/28.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *myTitle;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
- (CGFloat)getCellHeight:(NSIndexPath *)indexPath forTable:(UITableView *)tableView;
@end
