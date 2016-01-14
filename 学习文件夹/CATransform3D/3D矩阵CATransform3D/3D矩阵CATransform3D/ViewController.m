//
//  ViewController.m
//  3D矩阵CATransform3D
//
//  Created by lizhongqiang on 15/10/29.
//  Copyright (c) 2015年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic,strong)UIImageView *imageView1;
@property (nonatomic,strong)UIImageView *imageView2;
@property (nonatomic,strong)UIImageView *imageView3;
@end

@implementation ViewController
- (IBAction)resetAction:(id)sender {
    _imageView.layer.transform = CATransform3DIdentity;
}
- (IBAction)xAction:(id)sender {
}
- (IBAction)yAction:(id)sender {
    CABasicAnimation *aniamtion = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    aniamtion.toValue = @(M_PI/6);
    aniamtion.duration = 1;
    aniamtion.removedOnCompletion = YES;
    aniamtion.delegate = self;
    aniamtion.fillMode=kCAFillModeBackwards ;
    [_imageView.layer addAnimation:aniamtion forKey:@"rotate"];
    //
    
    
}
- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"%s",__func__);
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{//使动画结束，动画的状态是真实状态
    //这里的x,y,z仅仅只是矢量，代表的只是方向，与数值无关
    CATransform3D transform = CATransform3DIdentity;//CATransform3DMakeAffineTransform(CGAffineTransformIdentity);
    transform.m34 = -1/2000;
    _imageView.layer.transform = CATransform3DConcat(transform, CATransform3DMakeRotation(M_PI/6, 0, 1, 0));
}
- (IBAction)zAction:(id)sender {
}
- (void)tapAction
{
    NSLog(@"%s",__func__);
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    _imageView1 = [[UIImageView alloc]initWithFrame:self.imageView.frame];
    _imageView1.backgroundColor = [UIColor redColor];
    [self.view addSubview:_imageView1];
    _imageView2 = [[UIImageView alloc]initWithFrame:self.imageView.frame];
    _imageView2.backgroundColor = [UIColor redColor];
    [self.view addSubview:_imageView2];
    _imageView3 = [[UIImageView alloc]initWithFrame:self.imageView.frame];
    _imageView3.backgroundColor = [UIColor redColor];
    [self.view addSubview:_imageView3];
    _imageView.userInteractionEnabled = YES;
    _imageView.layer.masksToBounds = YES;
    _imageView.backgroundColor = [UIColor redColor];
    [_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)]];
    // Do any additional setup after loading the view, typically from a nib.
    NSURL *url = [NSURL URLWithString:@"http://i6.topit.me/6/5d/45/1131907198420455d6o.jpg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        _imageView.image = [UIImage imageWithData:data];
#if 0
        CATransform3D rotate = CATransform3DMakeRotation(M_PI/6, 0, 1, 0);
        _imageView.layer.transform = CATransform3DPerspect(rotate, CGPointMake(-160, -80), 200);
#endif
        
    }];
}
CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ)
{
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;//disZ表示的是相机离z=0平面（也可以理解为屏幕）的距离。一般需要写在旋转layer之前
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}

CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ)
{
    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));//CATransform3DConcatCATransform3DConcat函数连接起来以构造更复杂的变换, 通过这些方法，可以组合出更多的效果来
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
