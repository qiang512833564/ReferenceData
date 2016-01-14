//
//  ViewController.m
//  TranslucentNavigation
//
//  Created by lizhongqiang on 15/7/9.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"

#import "UIImageView+LBBlurredImage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 300 - 64)];
    imageView2.layer.masksToBounds = YES;
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    imageView2.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.view addSubview:imageView];
    [self.view addSubview:imageView2];
    
    UILabel *titleView = [[UILabel alloc]init];
    
    titleView.bounds = CGRectMake(0, 0, 100, 49);
    
    titleView.textAlignment = NSTextAlignmentCenter;
    
    titleView.text = @"好屋中国";
    
    titleView.textColor = [UIColor blackColor];
    
    self.navigationItem.titleView = titleView;
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [leftBtn setTitle:@"上海" forState:UIControlStateNormal];
    
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    leftBtn.frame = CGRectMake(0, 0, 100, 49);
    
    leftBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    //leftBtn.backgroundColor = [UIColor blackColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    
    NSArray *array = [self drawImage:[UIImage imageNamed:@"backImage"] height:64];
    
    [imageView setImageToBlur:array[0] blurRadius:1 completionBlock:^(NSError *error) {}];
    
    imageView2.image = array[1];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/pic/item/11385343fbf2b211ff3d44a9ce8065380dd78ec2.jpg"]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //imageView.image = [self drawImage:[UIImage imageWithData:data] height:64];
        
       
        
        
        
    }];
    //imageView.image = [UIImage imageNamed:@"backImage"];
    //[imageView setImageToBlur:[self drawImage:[UIImage imageNamed:@"backImage"] height:64] blurRadius:2 completionBlock:^(NSError *error) {}];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//设置状态栏样式
}

- (NSArray *)drawImage:(UIImage *)image height:(CGFloat)height
{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300)];
    
    imageView.backgroundColor = [UIColor blackColor];
    
    imageView.layer.masksToBounds = YES;
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    imageView.image = image;
    
    
    [self.view addSubview:imageView];
    
    

    //-------------------------截屏---------------------
    
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, YES, 0);
    
    [[self.view layer]renderInContext:UIGraphicsGetCurrentContext()];;
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    //  NSLog(@"%@--%zu",NSStringFromCGSize(viewImage.size),CGImageGetWidth(viewImage.CGImage));
    
    
    CGImageRef imageRef = viewImage.CGImage;
    
    CGImageRef newImage = CGImageCreateWithImageInRect(imageRef, CGRectMake(0, 0, imageView.frame.size.width*2, height*2));
    
    CGImageRef newImage2 = CGImageCreateWithImageInRect(imageRef, CGRectMake(0, height*2, imageView.frame.size.width*2, imageView.frame.size.height*2 - height*2));
    
    //
    
    
    [imageView removeFromSuperview];
    
    
#if 0
    //

    UIImage *img = [UIImage imageWithCGImage:newImage];
    
    UIImageWriteToSavedPhotosAlbum(img, self, nil, nil);
    
    NSFileManager *filemanger = [NSFileManager defaultManager];
    
    NSString *filePath = @"/users/Desktop/photo.png";
    
    [filemanger createFileAtPath:filePath contents:UIImagePNGRepresentation(img) attributes:nil];
#endif
    //
    return @[[UIImage imageWithCGImage:newImage],[UIImage imageWithCGImage:newImage2]];
    
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
