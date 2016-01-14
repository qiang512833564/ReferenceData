//
//  HomeViewCell.m
//  thinklion
//
//  Created by user on 15/12/5.
//  Copyright (c) 2015年 user. All rights reserved.
//   本人也是iOS开发者 一枚，酷爱技术 这是我的官方交流群  519797474

#import "HomeViewCell.h"
#import "HomeModel.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//头像的高度
#define iconH  80
#define iconW 100
//间距
#define  marginW 10

@interface HomeViewCell ()

@property (nonatomic,weak) UIImageView *icon;  //头像
@property (nonatomic,weak) UILabel *content; //显示文本的label
@property (nonatomic,weak) UIImageView *line;  //下划线

//定义一个contentLabel文本高度的属性
@property (nonatomic,assign) CGFloat contentLabelH;

@end

@implementation HomeViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        //1.添加子控件
        [self setupUI];
        
    }
    return self;
}

#pragma mark 添加子控件
-(void)setupUI
{
    //1.添加图片
    UIImageView *icon=[UIImageView new];
    icon.contentMode=UIViewContentModeScaleAspectFill;
    icon.clipsToBounds=YES;
    [self.contentView addSubview:icon];
    self.icon=icon;
    //2.添加label
    UILabel *content=[UILabel new];
    content.numberOfLines=0; //多行显示
    content.font=[UIFont systemFontOfSize:16];
    [self.contentView addSubview:content];
     self.content=content;
    //3.底部添加一条线
    UIImageView *line=[UIImageView new];
    line.backgroundColor=[UIColor grayColor];
    [self.contentView addSubview:line];
    self.line=line;
    
    //设置约束
     __weak __typeof(&*self)weakSelf = self;
    //1.设置图片的大小
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(iconH);  //头像的高度
        make.width.mas_equalTo(iconW); //头像的宽度
        make.top.equalTo(weakSelf.mas_top).offset(marginW) ; //距离顶部10的距离
        make.centerX.equalTo(weakSelf.mas_centerX); //头像的中心x和cell的中心x一样
        
       // make.centerY.equalTo(self.mas_centerY);  头像的中心y和cell的中心y一样
    }];
    //2.设置contentLabel
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.icon.mas_bottom).offset(marginW); //文本距离头像底部10个间距
        make.left.equalTo(weakSelf.mas_left).offset(marginW);  //文本距离左边的距离
        make.right.equalTo(weakSelf.mas_right).offset(-marginW);  //文本距离右边的距离
        
        //文本高度 我们再得到模型的时候 在传递
    }];
    
    
    //3.设置下划线的大小
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.left.equalTo(weakSelf.mas_left).offset(0);
        make.right.equalTo(weakSelf.mas_right).offset(0);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-marginW); //下划线距离底部10的距离
    }];
    
}

//传递数据模型
-(void)setHomeModel:(HomeModel *)homeModel
{
    _homeModel=homeModel;
   
    self.icon.image=[UIImage imageNamed:homeModel.icon];  //头像
    self.content.text=homeModel.content; //文本内容
}

//在表格cell中 计算出高度
-(CGFloat)rowHeightWithCellModel:(HomeModel *)homeModel
{
    _homeModel=homeModel;
    __weak __typeof(&*self)weakSelf = self;
    //设置标签的高度
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        // weakSelf.contentLabelH  这个会调用下面的懒加载方法
        make.height.mas_equalTo(weakSelf.contentLabelH);
    }];
    
    // 2. 更新约束
    [self layoutIfNeeded];
    
    //3.  视图的最大 Y 值
    CGFloat h= CGRectGetMaxY(self.content.frame);
   
    return h+marginW; //最大的高度+10
}

/*
 *  懒加载的方法返回contentLabel的高度  (只会调用一次)
 */
-(CGFloat)contentLabelH
{
    if(!_contentLabelH){
        CGFloat h=[self.homeModel.content boundingRectWithSize:CGSizeMake(([UIScreen mainScreen].bounds.size.width)-2*marginW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height;
        
        _contentLabelH=h+marginW;  //内容距离底部下划线10的距离
    }
    return _contentLabelH;
}



@end
