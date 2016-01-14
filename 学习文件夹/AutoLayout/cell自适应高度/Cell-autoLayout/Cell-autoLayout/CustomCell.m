//
//  CustomCell.m
//  Cell-autoLayout
//
//  Created by lizhongqiang on 15/12/28.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib {
    // Initialization code
    self.myImageView.backgroundColor = [UIColor yellowColor];
}
- (CGFloat)getCellHeight:(NSIndexPath *)indexPath forTable:(UITableView *)tableView{
    
    
    NSString *cellId=nil;
    
    if (indexPath.row/2==0){
        cellId = @"CellId2";
    }else{
        cellId = @"CellId2";
    }
    //    [mycell layoutIfNeeded];
    //    [mycell updateConstraintsIfNeeded];
    
    NSLayoutConstraint *constraint = nil;
    //if(indexPath.row/2==0){
    constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:300];
    //[cell addConstraint:constraint];
    self.myTitle.text = @"打打篮球温控器去哪里去玩的郊区到去年擦肩那块";
    UIImage *image =[UIImage imageNamed:@"picture.jpg"];
    self.myImageView.image = image;
    
            [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://pic2.ooopic.com/01/03/51/25b1OOOPIC19.jpg"]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                self.myImageView.image = [UIImage imageWithData:data];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [tableView reloadData];
                });
    
            }];
    
    

    CGFloat height = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    if(constraint){
        [self removeConstraint:constraint];
    }
    return height;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
