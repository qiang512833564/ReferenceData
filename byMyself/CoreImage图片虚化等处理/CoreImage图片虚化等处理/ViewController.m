//
//  ViewController.m
//  CoreImage图片虚化等处理
//
//  Created by lizhongqiang on 15/9/7.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"
#import "NextDrawWithImage.h"
#import "QRCodeViewController.h"
@interface ViewController ()
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UIImage *image;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 100, CGRectGetWidth([UIScreen mainScreen].bounds)-2*10, 300)];
    _imageView.backgroundColor = [UIColor blackColor];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/h%3D360/sign=a8d78a2978d98d1069d40a37113eb807/838ba61ea8d3fd1fc73ebeef344e251f95ca5f2b.jpg"]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        _image = [UIImage imageWithData:data];
        //_imageView.image = _image;
        [self dealWithImage:_image];
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 60, 60, 20);
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(turnToNextVC) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *codebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    codebtn.frame = CGRectMake(300, 70, 60, 20);
    [codebtn setTitle:@"二维码" forState:UIControlStateNormal];
    [self.view addSubview:codebtn];
    [codebtn addTarget:self action:@selector(turnToCodeVC) forControlEvents:UIControlEventTouchUpInside];
    [codebtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}
- (void)turnToCodeVC
{
    QRCodeViewController *vc = [[QRCodeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)turnToNextVC
{
    NextDrawWithImage *vc = [[NextDrawWithImage alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)coreImageBlur
{
    CIImage *ciImage = [[CIImage alloc]initWithImage:_image];
    CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [blurFilter setValue:@(5) forKey:@"inputRadius"];
    [blurFilter setValue:ciImage forKey:kCIInputImageKey];
    
    CIImage *outCiImage = [blurFilter valueForKey:kCIOutputImageKey];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef outCGImage = [context createCGImage:outCiImage fromRect:[outCiImage extent]];
    
    UIImage *blurImage = [UIImage imageWithCGImage:outCGImage];
    
    CGImageRelease(outCGImage);
    
    
    _imageView.image = blurImage;
}
- (void)dealWithImage:(UIImage *)image
{
#pragma mark -----图片模糊滤镜
    [self coreImageBlur];
    return;
#pragma mark -----图片复古画与人脸部处理
    __block UIImage *weakImage  = image;
    //dispatch_queue_t *queue = dispatch_queue_create(<#const char *label#>, <#dispatch_queue_attr_t attr#>)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CIImage *beginImage = [[CIImage alloc]initWithImage:image];
        CIContext *context = [CIContext contextWithOptions:nil];
        //NSLog(@"%@",[CIFilter filterNamesInCategory:kCICategoryBuiltIn]);////搜索属于 kCICategoryBuiltIn类别的所有滤镜名字，返回一个数组；
        [self logAllFilters];
        CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"];
        [filter setValue:beginImage forKey:kCIInputImageKey];
        [filter setValue:[NSNumber numberWithFloat:0.5] forKey:@"inputIntensity"];//缺省为1--max为1,min为0
        
        CIImage *outputImage = [filter outputImage];
        CGImageRef newImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
        weakImage = [[UIImage alloc]initWithCGImage:newImage];
#if 0
        CIFilter *filter1 = [CIFilter filterWithName:@"CIAffineTransform"];
        [filter1 setValue:outputImage forKey:kCIInputImageKey];
        [filter1 setValue:[NSValue valueWithCGAffineTransform:CGAffineTransformMake(0.7, 0.5, 0.3, 1, 0, 0)] forKey:@"inputTransform"];
        outputImage = [filter1 outputImage];
        newImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
        weakImage = [[UIImage alloc]initWithCGImage:newImage];
#endif
        dispatch_sync(dispatch_get_main_queue(), ^{
           _imageView.image = weakImage;
        });
    });
    
}
//所有可用的CoreImag的效果及其参数
- (void)logAllFilters
{
    NSArray *filterNames = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    
    for (NSString *filterName in filterNames) {
        //if([filterName isEqualToString:@"CIAffineTransform"]||[filterName isEqualToString:@"CISepiaTone"])
        //if([filterName containsString:@"Blur"])
        if([filterName containsString:@"face"])
        {
            CIFilter *filter = [CIFilter filterWithName:filterName];
            NSLog(@"%@", [filter attributes]);
        }
        
    }
    [self leftEyePositionsWithImage:_image];
}
#pragma mark ------  人面部识别----------------------
//CoreImage类中提供了一个CIDectetor类来给我们提供两种类型的检测器
- (BOOL)hasFace:(UIImage *)image
{
    NSArray *features = [self featuresWithImage:image];
    return features.count?YES:NO;
}

- (NSArray *)featuresWithImage:(UIImage *)image
{
    CIDetector *faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace
                                                  context:nil
                                                  options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    //创建检测器时传入Type参数指定为面部即可，options中可以传入一个检测精度。
    CIImage *ciimg = [CIImage imageWithCGImage:image.CGImage];
    NSArray *features = [faceDetector featuresInImage:ciimg];
    return features;
}
//左眼
- (NSArray *)leftEyePositionsWithImage:(UIImage *)image
{
    if (![self hasFace:image]) return nil;
    
    NSArray *features = [self featuresWithImage:image];
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:features.count];
    for (CIFaceFeature *f in features) {
        if (f.hasLeftEyePosition) [arrM addObject:[NSValue valueWithCGPoint:f.leftEyePosition]];
    }
    return arrM;
}
//右眼
- (NSArray *)rightEyePositionsWithImage:(UIImage *)image
{
    if (![self hasFace:image]) return nil;
    
    NSArray *features = [self featuresWithImage:image];
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:features.count];
    for (CIFaceFeature *f in features) {
        if (f.hasRightEyePosition) [arrM addObject:[NSValue valueWithCGPoint:f.rightEyePosition]];
    }
    return arrM;
}
//嘴部
- (NSArray *)mouthPositionsWithImage:(UIImage *)image
{
    if (![self hasFace:image]) return nil;
    
    NSArray *features = [self featuresWithImage:image];
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:features.count];
    for (CIFaceFeature *f in features) {
        if (f.hasMouthPosition) [arrM addObject:[NSValue valueWithCGPoint:f.mouthPosition]];
    }
    return arrM;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
