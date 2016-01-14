//
//  UICopyLabel.m
//  粘贴复制
//
//  Created by lizhongqiang on 15/7/14.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "UICopyLabel.h"
#import "MenuController.h"


@implementation UICopyLabel

//UILabel默认是不接收事件的，我们需要自己添加touch事件
-(void)attachTapHandler{
    self.userInteractionEnabled = YES;  //用户交互的总开关
    UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    touch.numberOfTapsRequired = 2;
    [self addGestureRecognizer:touch];
}
-(void)handleTap:(UIGestureRecognizer*) recognizer{
    [self becomeFirstResponder];
    
    MenuController *menu = [MenuController sharedMenuController];//UIMenuController双击以后显示的粘贴栏、复制栏
    
    [menu setTargetRect:self.frame inView:self.superview];//设置编辑板的指向
   
    
    
    
    UIMenuItem *copyItem = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(copyAction)];
    
    UIMenuItem *shanchuItem = [[UIMenuItem alloc]initWithTitle:@"删除" action:@selector(deleteAction)];
    
    UIMenuItem *shareItem = [[UIMenuItem alloc]initWithTitle:@"分享" action:@selector(shareAction)];
    
    UIMenuItem *shareItem1 = [[UIMenuItem alloc]initWithTitle:@"在线" action:@selector(shareAction)];
    UIMenuItem *shareItem2 = [[UIMenuItem alloc]initWithTitle:@"share2" action:@selector(shareAction)];
    UIMenuItem *shareItem3 = [[UIMenuItem alloc]initWithTitle:@"share2" action:@selector(shareAction)];
    
    [menu setMenuItems:@[copyItem,shanchuItem,shareItem,shareItem1,shareItem2,shareItem3]];
    
    [menu setMenuVisible:YES animated:YES];
    
    [menu update];
}

- (void)copyAction
{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];//编辑板，复制，粘贴等
    pboard.string = self.text;
}
- (void)deleteAction
{
    
    
}
- (void)shareAction
{
    
}
//绑定事件
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self attachTapHandler];
       
    }
    return self;
}
//同上
-(void)awakeFromNib{
    [super awakeFromNib];
    [self attachTapHandler];
}




- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return (action == @selector(copyAction))||(action == @selector(deleteAction)||(action == @selector(shareAction)));
}

@end
