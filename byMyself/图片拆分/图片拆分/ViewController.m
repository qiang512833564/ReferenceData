//
//  ViewController.m
//  图片拆分
//
//  Created by lizhongqiang on 15/7/9.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong)UIImage *image;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://h.hiphotos.baidu.com/image/h%3D300/sign=696acdf2f2246b60640eb474dbf91a35/b90e7bec54e736d1f84d1fa99f504fc2d5626931.jpg"]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        _image = [UIImage imageWithData:data];
        
        self.view.backgroundColor = [UIColor blackColor];
        
        
        //_image = [UIImage imageNamed:@"example.png"];
        
       // [self drawImage:_image];
        
    }];
}

- (void)drawImage:(UIImage *)image height:(CGFloat)height
{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300)];
    
    imageView.backgroundColor = [UIColor blackColor];
    
    imageView.layer.masksToBounds = YES;
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    imageView.image = image;
    
    
    [self.view addSubview:imageView];
    
    //----------------------------------------------

    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, YES, 0);
    
    [[self.view layer]renderInContext:UIGraphicsGetCurrentContext()];;
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
  //  NSLog(@"%@--%zu",NSStringFromCGSize(viewImage.size),CGImageGetWidth(viewImage.CGImage));
    
    
    CGImageRef imageRef = viewImage.CGImage;
    
    CGImageRef newImage = CGImageCreateWithImageInRect(imageRef, CGRectMake(0, 0, imageView.frame.size.width*2, height*2));
    
//    
    
    imageView.image = [UIImage imageWithCGImage:newImage];
    
    [imageView removeFromSuperview];
    
//
#if 0
    UIImage *img = [UIImage imageWithCGImage:newImage];
    
    UIImageWriteToSavedPhotosAlbum(img, self, nil, nil);
    
    NSFileManager *filemanger = [NSFileManager defaultManager];
    
    NSString *filePath = @"/users/Desktop/photo.png";
    
    [filemanger createFileAtPath:filePath contents:UIImagePNGRepresentation(img) attributes:nil];
#endif
//
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
