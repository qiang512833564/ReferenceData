//
//  Head_bgView.m
//  头像背景模糊化处理
//
//  Created by lizhongqiang on 16/1/20.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "Head_bgView.h"
#import "UIView+Screen.h"
#import "UIImage+My_Image.h"
@implementation Head_bgView
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        UIImage *image = [UIImage imageNamed:@"background.jpg"];
        image = [image blurredImageWithRadius:10 iterations:10 tintColor:[UIColor blackColor]];
        self.image = image;
    }
    return self;
}
@end
