//
//  My_CollectionViewCell.m
//  UICollectionView
//
//  Created by lizhongqiang on 16/1/23.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "My_CollectionViewCell.h"
@interface My_CollectionViewCell ()
@property (nonatomic, strong)UIButton *deleteBtn;
@end
@implementation My_CollectionViewCell
- (UIButton *)deleteBtn{
    if(_deleteBtn == nil){
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake(0, 0, 25, 25);
        [_deleteBtn setTitle:@"➖" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}
- (UILabel *)textLabel{
    if(_textLabel == nil){
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds), CGRectGetHeight(self.contentView.bounds))];
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}
- (void)deleteAction{
    [self.delegate deleteAction_Cell:self];
    //[self.delegate deleteAction_IndexPath:self.indexPath];
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.deleteBtn];
        [self.contentView addSubview:self.textLabel];
    }
    return self;
}
- (void)setEditing:(BOOL)editing{
    _editing = editing;
    
    self.deleteBtn.hidden = !editing;
}
@end
