//
//  My_CollectionViewCell.h
//  UICollectionView
//
//  Created by lizhongqiang on 16/1/23.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class My_CollectionViewCell;
@protocol My_CollectionViewCellDelegate<NSObject>
- (void)deleteAction_Cell:(My_CollectionViewCell *)cell;
- (void)deleteAction_IndexPath:(NSIndexPath *)indexPath;
@end
@interface My_CollectionViewCell : UICollectionViewCell
@property (nonatomic, assign)BOOL editing;
@property (nonatomic, strong)UILabel *textLabel;
@property (nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic, assign)id<My_CollectionViewCellDelegate> delegate;
@end
