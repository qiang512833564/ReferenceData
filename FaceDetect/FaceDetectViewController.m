//
//  FaceDetectViewController.m
//  FaceDetect
//
//  Created by iObitLXF on 5/16/13.
//  Copyright (c) 2013 iObitLXF. All rights reserved.
//

#import "FaceDetectViewController.h"

@interface FaceDetectViewController ()

@end

@implementation FaceDetectViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
//    [self.view setTransform:CGAffineTransformMakeScale(1, -1)];
    
    imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ian1.png"]];
    [self setImageViewFrame];
    [self.view addSubview:imageView];
    
    newImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:newImageView];
    
    [self faceDetect:imageView.image];
}
-(void)setImageViewFrame
{
    
    CGFloat scale = 1.;
    
    CGSize imgSize = imageView.image.size;
    CGRect vFrame = self.view.frame;
    CGRect imgVFrame = imageView.frame;
    if (imgSize.width/CGRectGetWidth(vFrame) > imgSize.height/CGRectGetHeight(vFrame)) {
        imgVFrame.size.width = CGRectGetWidth(vFrame);
        imgVFrame.size.height = imgSize.height * CGRectGetWidth(vFrame)/imgSize.width;
        
        scale = CGRectGetWidth(vFrame)/imgSize.width;
    }
    else{
        imgVFrame.size.height = CGRectGetHeight(vFrame);
        imgVFrame.size.width = imgSize.width * CGRectGetHeight(vFrame)/imgSize.height;
        
        scale = CGRectGetHeight(vFrame)/imgSize.height;
    }
    imageView.frame = imgVFrame;
    
    UIImage *newImg = [self scaleImage:imageView.image toScale:scale];//图片根据imgV的frame进行重新缩放生成
    imageView.image = newImg;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 人脸检测方法
- (CGRect)faceDetect:(UIImage *)aImage
{
    
    //Create a CIImage version of your photo
    CIImage* image = [CIImage imageWithCGImage:aImage.CGImage];
    
    [self setImageViewFrame];
    
    //create a face detector
    //此处是CIDetectorAccuracyHigh，若用于real-time的人脸检测，则用CIDetectorAccuracyLow，更快
    NSDictionary  *opts = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh
                                                      forKey:CIDetectorAccuracy];
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil
                                              options:opts];
    
    //Pull out the features of the face and loop through them
    NSArray* features = [detector featuresInImage:image];
    
    if ([features count]==0) {
        NSLog(@">>>>> 人脸监测【失败】啦 ～！！！");
        return CGRectZero;
    }
    
    NSLog(@">>>>> 人脸监测【成功】～！！！>>>>>> ");
    
    for (CIFaceFeature *f in features)
    {
        //旋转180，仅y
        CGRect aRect = f.bounds;
        aRect.origin.y = self.view.bounds.size.height - aRect.size.height - aRect.origin.y;//self.bounds.size
        
        UIView *vv = [[UIView alloc]initWithFrame:aRect];
        [vv setTransform:CGAffineTransformMakeScale(1, -1)];
        vv.backgroundColor = [UIColor redColor];
        vv.alpha = 0.6;
        [self.view addSubview:vv];
        [vv release];

        
        NSLog(@"%@",NSStringFromCGRect(f.bounds));
        if (f.hasLeftEyePosition){
            printf("Left eye %g %g\n", f.leftEyePosition.x, f.leftEyePosition.y);
           
            UIView *vv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
            //旋转180，仅y
            CGPoint newCenter =  f.leftEyePosition;
            newCenter.y = self.view.bounds.size.height-newCenter.y;
            vv.center = newCenter;
            
            vv.backgroundColor = [UIColor yellowColor];
             [vv setTransform:CGAffineTransformMakeScale(1, -1)];
            vv.alpha = 0.6;
            [self.view addSubview:vv];
            [vv release];
        }
        if (f.hasRightEyePosition)
        {
            printf("Right eye %g %g\n", f.rightEyePosition.x, f.rightEyePosition.y);
            
            UIView *vv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
            //旋转180，仅y
            CGPoint newCenter =  f.rightEyePosition;
            newCenter.y = self.view.bounds.size.height-newCenter.y;
            vv.center = newCenter;
            
            vv.backgroundColor = [UIColor blueColor];
             [vv setTransform:CGAffineTransformMakeScale(1, -1)];
            vv.alpha = 0.6;
            [self.view addSubview:vv];
            [vv release];
        }
        if (f.hasMouthPosition)
        {
            printf("Mouth %g %g\n", f.mouthPosition.x, f.mouthPosition.y);
           
            UIView *vv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
            //旋转180，仅y
            CGPoint newCenter =  f.mouthPosition;
            newCenter.y = self.view.bounds.size.height-newCenter.y;
            vv.center = newCenter;
            
            vv.backgroundColor = [UIColor greenColor];
             [vv setTransform:CGAffineTransformMakeScale(1, -1)];
            vv.alpha = 0.6;
            [self.view addSubview:vv];
            [vv release];
        
        }
    }
    return CGRectZero;
    
}

#pragma mark - ScaleImageSize
//将图片进行缩放重新生成
- (UIImage *) scaleImage:(UIImage *)image toScale:(float)scaleSize {
    if (image) {
        UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
        [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
        UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return scaledImage;
    }
    return nil;
}


- (void)showProgressIndicator:(NSString *)text {
	//[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	self.view.userInteractionEnabled = FALSE;
	if(!progressHUD) {
		CGFloat w = 160.0f, h = 120.0f;
		progressHUD = [[UIProgressHUD alloc] initWithFrame:CGRectMake((self.view.frame.size.width-w)/2, (self.view.frame.size.height-h)/2, w, h)];
		[progressHUD setText:text];
		[progressHUD showInView:self.view];
	}
}

- (void)hideProgressIndicator {
	//[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	self.view.userInteractionEnabled = TRUE;
	if(progressHUD) {
		[progressHUD hide];
		[progressHUD release];
		progressHUD = nil;
        
	}
}

@end
