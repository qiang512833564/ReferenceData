//
//  StarsLine.m
//  rrmj个人主页
//
//  Created by lizhongqiang on 15/8/27.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "StarsLine.h"
#define lineWidth (120)
@interface StarsLine ()
@property (nonatomic, strong)NSMutableArray *starsArray;
@property (nonatomic, strong)UILabel *scoreLabel;
@property (nonatomic, strong)UILabel *small;
@end
@implementation StarsLine

- (instancetype)init
{
    if(self = [super init])
    {//self.backgroundColor = [UIColor redColor];
        _starsArray = [NSMutableArray array];
        
        _scoreLabel = [[UILabel alloc]init];
        _small = [[UILabel alloc]init];
        _scoreLabel.font = [UIFont systemFontOfSize:60/3.f];
        _scoreLabel.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        _small.font = [UIFont systemFontOfSize:48/3.f];
        _small.textColor = _scoreLabel.textColor;
        for(int i=0; i<5; i++)
        {
            UIImageView *star = [[UIImageView alloc]init];
            [self addSubview:star];
            star.contentMode = UIViewContentModeScaleAspectFit;
            star.image = [UIImage imageNamed:@"icon_drama_star_blank"];
            star.layer.masksToBounds = YES;
            [_starsArray addObject:star];
        }
        [self addSubview:_scoreLabel];
        [self addSubview:_small];
    }
    return self;
}
- (void)layoutSubviews
{
    for(int i=0; i<5; i++)
    {
        UIImageView *star = _starsArray[i];
        CGFloat spaceX = 8;
        if(_type == CommtentTyper)
        {
            spaceX = 11;
        }
        star.frame = CGRectMake(i*(CGRectGetHeight(self.frame)+spaceX), 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame));
//        if([_scoreLabel.text isEqualToString:@"0"])
//        {
//            CGRect frame = star.frame;
//            frame.origin.x += 4;
//        }
        [self addSubview:star];
        if(i == 4)
        {
            
        }
        if(i == 4)
        {
            _scoreLabel.frame = CGRectMake(CGRectGetMaxX(star.frame)+8, 3, 60, 16);
           if(_type == CommtentTyper)
           {
               _scoreLabel.center = CGPointMake(_scoreLabel.center.x+5, star.center.y+3);
               _scoreLabel.bounds = CGRectMake(0, 0, 60, CGRectGetHeight(star.frame));
           }
            
            _small.frame = CGRectMake(CGRectGetMaxX(star.frame)+20, 3, 60, 16);
            
        }
    }
}
- (void)setType:(StarStype)type
{
    if(type == CommtentTyper)
    {
        [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
           if([obj isKindOfClass:[UIImageView class]])
           {
               UIImageView *imageView = (UIImageView *)obj;
               imageView.image = [UIImage imageNamed:@"icon_score_star_blank"];
           }
        }];
    }
    _type = type;
}

- (void)setScore:(CGFloat)score
{
    
    _scoreLabel.text = [NSString stringWithFormat:@"%.1f",score];
    
    
    NSMutableAttributedString *mutableAttr = [[NSMutableAttributedString alloc]initWithString:[_scoreLabel.text substringToIndex:2]];
    
    UIColor *textColor = _scoreLabel.textColor;;
    
    switch (self.type) {
        case CommtentTyper:
        {
            textColor = [UIColor blackColor];
            mutableAttr = [[NSMutableAttributedString alloc]initWithString:_scoreLabel.text];
            _small.hidden = YES;
            
    
        }
            break;
            
        default:
            break;
    }
    
    [mutableAttr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:(self.type == CommtentTyper?67/3.f:60/3.f)],NSForegroundColorAttributeName:textColor} range:NSMakeRange(0, mutableAttr.length)];

    _scoreLabel.attributedText = mutableAttr;
    _small.text = [[NSString stringWithFormat:@"%.1f",score] substringFromIndex:2];
    
    int globeNumber = (int)score/2;
    for(int i=0; i<globeNumber; i++)
    {
        UIImageView *imageView = _starsArray[i];
        [imageView setImage:[UIImage imageNamed:(self.type == CommtentTyper?@"icon_score_star_full":@"icon_drama_star_full")]];//icon_drama_star_full
    }
    if(score - globeNumber != 0)
    {
        UIImageView *imageView = _starsArray[globeNumber];
        [imageView setImage:[UIImage imageNamed:(self.type == CommtentTyper?@"icon_score_star_haff":@"icon_drama_star_haff")]];
    }
    [self setNeedsDisplay];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(! _usered) return;
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self];

    
    [self config:currentPosition];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(! _usered) return;
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self];
    
    [self config:currentPosition];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(! _usered) return;
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self];
    
    [self config:currentPosition];
}
- (void)config:(CGPoint)currentPosition
{
    
    
    if(currentPosition.x > CGRectGetMaxX([[_starsArray lastObject] frame]))
    {
        return;
    }
    ;
    [_starsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIImageView *imageView = (UIImageView *)obj;
        
        if(CGRectContainsPoint(imageView.frame, currentPosition))
        {
            imageView.image = [UIImage imageNamed:(currentPosition.x<=(CGRectGetMaxX(imageView.frame) - CGRectGetHeight(imageView.frame)/2.f))?@"icon_score_star_haff":@"icon_score_star_full"];
            NSString *score = nil;
            if(currentPosition.x<=(CGRectGetMaxX(imageView.frame) - CGRectGetHeight(imageView.frame)/2.f))
            {
                score = [NSString stringWithFormat:@"%lu.5",(idx)*2+1];
            }
            else
            {
                score = [NSString stringWithFormat:@"%lu.0",(idx+1)*2];
            }
            _scoreLabel.text= score;
            NSMutableAttributedString* mutableAttr = [[NSMutableAttributedString alloc]initWithString:_scoreLabel.text];
            [mutableAttr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:(self.type == CommtentTyper?67/3.f:60/3.f)],NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, mutableAttr.length)];
            _scoreLabel.attributedText = mutableAttr;
        }
        else
        {
            if(CGRectGetMaxX(imageView.frame)<currentPosition.x)
            {
                imageView.image = [UIImage imageNamed:@"icon_score_star_full"];
            }
            else
            {
                imageView.image = [UIImage imageNamed:@"icon_score_star_blank"];
            }
        }
    }];
    
    if(self.showScoreState)
    {
        self.showScoreState(_scoreLabel.text);
    }
}
@end
