//
//  WXInputView.m
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-22.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import "WXInputView.h"

@interface WXInputView()



@end

@implementation WXInputView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)inputView{
    return [[[NSBundle mainBundle] loadNibNamed:@"WXInputView" owner:nil options:nil] lastObject];
}

-(void)awakeFromNib{
    
}
@end
