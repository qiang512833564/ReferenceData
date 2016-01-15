//
//  MyLabel.h
//  图文混排Test
//
//  Created by lizhongqiang on 16/1/13.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLabel : UIView
@property (nonatomic, strong)NSMutableAttributedString *attributedString;
@property (nonatomic, strong)UIColor *textColor;
@property (nonatomic, strong)UIColor *highlightColor;
@property (nonatomic, strong)UIColor *linkColor;
@property (nonatomic, strong)UIFont *font;
@property (nonatomic, assign)NSInteger numberOfLines;
@property (nonatomic, assign)CTLineBreakMode lineBreakMode;
@property (nonatomic,assign)    CTTextAlignment textAlignment;  //文字排版样式
@property (nonatomic,assign)    BOOL    underLineForLink;       //链接是否带下划线
@property (nonatomic,assign)    BOOL    autoDetectLinks;        //自动检测
@property (nonatomic,assign)    CGFloat lineSpacing;            //行间距
@property (nonatomic,assign)    CGFloat paragraphSpacing;       //段间距
//- (void)appendText:(NSString *)text;
@end
