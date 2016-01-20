//
//  UIImage+My_Image.h
//  头像背景模糊化处理
//
//  Created by lizhongqiang on 16/1/20.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (My_Image)
- (UIImage *)blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor;
- (UIImage *)blur;
@end
