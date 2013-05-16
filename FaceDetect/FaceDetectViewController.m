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
	
    imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ian1.png"]];
    [imageView setFrame:CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.height)];
//    [imageView setTransform:CGAffineTransformMakeScale(1, -1)];
    [self setImageViewFrame];
    [self.view addSubview:imageView];
    
    newImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
//    [newImageView setTransform:CGAffineTransformMakeScale(1, -1)];
    [self.view addSubview:newImageView];
    
    [self faceDetect:imageView.image];
}
-(void)setImageViewFrame
{
//    CGSize imgSize = imageView.image.size;
//    CGRect vFrame = self.view.frame;
//    CGRect imgVFrame = imageView.frame;
//    if (imgSize.width/CGRectGetWidth(vFrame) > imgSize.height/CGRectGetHeight(vFrame)) {
//        imgVFrame.size.width = CGRectGetWidth(vFrame);
//        imgVFrame.size.height = imgSize.height * CGRectGetWidth(vFrame)/imgSize.width;
//    }
//    else{
//        imgVFrame.size.height = CGRectGetHeight(vFrame);
//        imgVFrame.size.width = imgSize.width * CGRectGetHeight(vFrame)/imgSize.height;
//    }
//    
//    imageView.frame = imgVFrame;
    
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
    
    [imageView setTransform:CGAffineTransformMakeScale(1, -1)];
    [self.view setTransform:CGAffineTransformMakeScale(1, -1)];
    [imageView setFrame:CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.height)];
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
        NSLog(@">>>>> 啊啊啊啊啊啊 ～！！！");
        return CGRectZero;
    }
    
    NSLog(@">>>>> 哈哈哈哈哈～！！！>>>>>> ");
    
    for (CIFaceFeature *f in features)
    {
        //旋转180，仅y
        CGRect aRect = f.bounds;
        //        aRect.origin.y = self.view.bounds.size.height - aRect.size.height - aRect.origin.y;//self.bounds.size
        
        UIView *vv = [[UIView alloc]initWithFrame:aRect];
        //        [vv setTransform:CGAffineTransformMakeScale(1, -1)];
        vv.backgroundColor = [UIColor redColor];
        vv.alpha = 0.6;
        [self.view addSubview:vv];
        [vv release];

        
        NSLog(@"%@",NSStringFromCGRect(f.bounds));
        if (f.hasLeftEyePosition){
            printf("Left eye %g %g\n", f.leftEyePosition.x, f.leftEyePosition.y);
           
            UIView *vv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
            vv.center = f.leftEyePosition;
            vv.backgroundColor = [UIColor yellowColor];
            vv.alpha = 0.6;
            [self.view addSubview:vv];
            [vv release];
        }
        if (f.hasRightEyePosition)
        {
            printf("Right eye %g %g\n", f.rightEyePosition.x, f.rightEyePosition.y);
            
            UIView *vv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
            vv.center = f.rightEyePosition;
            vv.backgroundColor = [UIColor blueColor];
            vv.alpha = 0.6;
            [self.view addSubview:vv];
            [vv release];
        }
        if (f.hasMouthPosition)
        {
            printf("Mouth %g %g\n", f.mouthPosition.x, f.mouthPosition.y);
           
            UIView *vv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
            vv.center = f.mouthPosition;
            vv.backgroundColor = [UIColor greenColor];
            vv.alpha = 0.6;
            [self.view addSubview:vv];
            [vv release];
        
        }
    }
    
//    for(CIFaceFeature* feature in features)
//    {
//        
//        //旋转180，仅y
//        CGRect aRect = feature.bounds;
////        aRect.origin.y = self.view.bounds.size.height - aRect.size.height - aRect.origin.y;//self.bounds.size
//        
//        UIView *vv = [[UIView alloc]initWithFrame:aRect];
////        [vv setTransform:CGAffineTransformMakeScale(1, -1)];
//        vv.backgroundColor = [UIColor redColor];
//        vv.alpha = 0.6;
//        [self.view addSubview:vv];
//        [vv release];
//        
////        return aRect;
//        
//    }
    return CGRectZero;
    
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
