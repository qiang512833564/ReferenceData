//
//  UIView+WF.m
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-18.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import "UIView+WF.h"

@implementation UIView (WF)

-(void)setH:(float)h{
    CGRect frm = self.frame;
    frm.size.height = h;
    self.frame = frm;
}

-(float)h{
    return self.frame.size.height;
}

@end
