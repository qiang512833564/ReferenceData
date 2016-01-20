//
//  UIView+Screen.m
//  头像背景模糊化处理
//
//  Created by lizhongqiang on 16/1/20.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "UIView+Screen.h"

@implementation UIView (Screen)

- (UIImage *)convertViewToImage{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
