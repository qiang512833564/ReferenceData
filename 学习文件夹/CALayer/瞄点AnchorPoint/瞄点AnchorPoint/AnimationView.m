//
//  AnimationView.m
//  AnchorPoint瞄点
//
//  Created by lizhongqiang on 15/11/3.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "AnimationView.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface AnimationView ()
@property (nonatomic, strong)NSArray *imageArray;
@property (nonatomic, strong)UIImageView *bgImageView1;
@property (nonatomic, strong)UIImageView *bgImageView2;
@property (nonatomic, strong)UIImageView *flipImageView;
@property (nonatomic, assign)BOOL firstPage;
@property (nonatomic, assign) BOOL upscalingAllowed;
@end
#pragma mark --- anchorPoint与position两者互补相关
@implementation AnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        
        self.imageArray = [self generateImagesFromImage:[UIImage imageNamed:@"Launch.jpg"]];
        
        _bgImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)/2.f)];
        _bgImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_bgImageView1.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)/2.f)];
        _flipImageView = [[UIImageView alloc]init];
        _flipImageView.frame = (CGRect){CGPointZero,CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)/2.f)};
        [self addSubview:_bgImageView1];
        [self addSubview:_bgImageView2];
        [self addSubview:_flipImageView];
        _flipImageView.hidden = YES;
        
        _bgImageView1.image = _imageArray[0];
        _bgImageView2.image = _imageArray[1];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self runAnimation];
        });
    }
    return self;
}
- (CGSize)sizeThatFits:(CGSize)aSize;
{
    if (!self.bgImageView1.image) return aSize;
    
    CGSize imageSize = self.bgImageView1.image.size;
    
    CGFloat ratioW     = aSize.width/aSize.height;
    CGFloat origRatioW = imageSize.width/(imageSize.height*2);
    CGFloat origRatioH = (imageSize.height*2)/imageSize.width;
    
    if (ratioW>origRatioW) {
        aSize.width = aSize.height*origRatioW;
    } else {
        aSize.height = aSize.width*origRatioH;
    }
    
    if (!self.upscalingAllowed) {
        aSize = [self sizeWithMaximumSize:aSize];
    }
    
    return aSize;
}

- (CGSize)sizeWithMaximumSize:(CGSize)size;
{
    if (!self.bgImageView1.image) return size;
    
    CGSize imageSize = self.bgImageView1.image.size;
    
    size.width  = MIN(size.width, imageSize.width);
    size.height = MIN(size.height, imageSize.height*2);
    return size;
}
- (void)setFrame:(CGRect)rect;
{
    rect.size = [self sizeThatFits:rect.size];
    [super setFrame:rect];
    
    // update imageView frames
    rect.origin = CGPointMake(0, 0);
    rect.size.height /= 2.0;
    self.bgImageView1.frame = rect;
    rect.origin.y += rect.size.height;
    self.bgImageView2.frame = rect;
    
    // update flip imageView frame
    [self updateFlipViewFrame];
    
    // reset Z distance
    [self setZDistance:self.frame.size.height*3];
}

- (void)setZDistance:(NSUInteger)zDistance;
{
    _zDistance = zDistance;
    
    // setup 3d transform
    CATransform3D aTransform = CATransform3DIdentity;
    aTransform.m34 = -1.0 / zDistance;
    self.layer.sublayerTransform = aTransform;
}
- (void)runAnimation{
    _firstPage = _firstPage==YES?NO:YES;
    [self updateFlipViewFrame];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.delegate = self;
    animation.duration = 2;
    if(_firstPage)
    {
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0.0, 1, 0, 0)];
        animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-M_PI_2, 1, 0, 0)];
        
    }else
    {
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 1, 0, 0)];
        animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0.0, 1, 0, 0)];
        
    }
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    _flipImageView.image = _imageArray[0];
    _flipImageView.backgroundColor = [UIColor blueColor];
    [_flipImageView.layer addAnimation:animation forKey:@"animation"];
    //
     _flipImageView.hidden = NO;
}
- (void)animationDidStart:(CAAnimation *)anim
{
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(_firstPage){
        [self runAnimation];
    }
}
#pragma mark ------ anchorPoint与frame要有先后顺序的，否则实现不了效果
- (void)updateFlipViewFrame{
    if(_firstPage)
    {
#if 0
//实现1
        _flipImageView.layer.anchorPoint = CGPointMake(0.5, 1);
        self.flipImageView.frame = self.bgImageView1.frame;//CGRectOffset(self.bgImageView1.frame, 0, CGRectGetHeight(self.bgImageView1.frame)/2.f);
        
#endif
       
#if 1
//实现2
         _flipImageView.layer.anchorPoint = CGPointMake(0.5, 1);
        //NSLog(@"%@",NSStringFromCGPoint(_flipImageView.layer.position));
        _flipImageView.layer.position = CGPointMake(187.5, 166.75*2);//实现1与实现2效果是一样的，这是因为
        /*
         layer的默认anchorPoint为(0.5,0.5),居中，此时layer的position为(187.5,166.75)；anchorPoint修改为(0.5,1)后，position的值保持不变，但相对位置转移到anchorPoint设置的点，要修改为原来的位置，把layer的position设置为(187.5, 166.75*2)即可,相当于把视图向下移动166.75个像素。
         
         另外我们也可以通过在设置完anchorPoint以后，通过设置frame的方式，来重新恢复position的位置
        */
#endif
        
    }else{
#if 1
        _flipImageView.layer.anchorPoint = CGPointMake(0.5, 0);
         self.flipImageView.frame = self.bgImageView2.frame;
#endif
#if 0
        self.flipImageView.frame = self.bgImageView2.frame;
        _flipImageView.layer.anchorPoint = CGPointMake(0.5, 0);
        NSLog(@"%@",NSStringFromCGPoint(_flipImageView.layer.position));
        _flipImageView.layer.position = CGPointMake(187.5, 667-2*166.75);
#endif
    }
}
+(UIImage *)cutFromView:(UIView *)view{
    
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0f);
    
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //在新建的图形上下文中渲染view的layer
    [view.layer renderInContext:context];
    
    [[UIColor clearColor] setFill];
    
    //获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}
- (NSArray*)generateImagesFromImage:(UIImage*)image;
{
    NSMutableArray *images = [NSMutableArray array];
    
    for (int i=0; i<2; i++) {
        CGSize size = CGSizeMake(image.size.width, image.size.height/2);
        CGFloat yPoint = (i==0) ? 0 : -size.height;
        // draw half of the image in a new image
        UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
        [image drawAtPoint:CGPointMake(0,yPoint)];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // save image
        [images addObject:image];
    }
    
    return images;
}
@end
