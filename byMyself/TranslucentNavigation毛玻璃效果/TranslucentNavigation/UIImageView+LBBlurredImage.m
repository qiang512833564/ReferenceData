//
//  UIImageView+LBBlurredImage.m
//  LBBlurredImage
//
//  Created by Luca Bernardi on 11/11/12.
//  Copyright (c) 2012 Luca Bernardi. All rights reserved.
//

#import "UIImageView+LBBlurredImage.h"
#import <CoreImage/CoreImage.h>


NSString *const kLBBlurredImageErrorDomain          = @"com.lucabernardi.blurred_image_additions";
CGFloat const   kLBBlurredImageDefaultBlurRadius    = 20.0;


@implementation UIImageView (LBBlurredImage)

#pragma mark - LBBlurredImage Additions

- (void)setImageToBlur: (UIImage *)image
            blurRadius: (CGFloat)blurRadius
       completionBlock: (LBBlurredImageCompletionBlock) completion

{
    CIContext *context   = [CIContext contextWithOptions:nil];
    CIImage *sourceImage = [CIImage imageWithCGImage:image.CGImage];
    
    // Apply clamp filter:
    // this is needed because the CIGaussianBlur when applied makes
    // a trasparent border around the image
    /*
     CISepiaTone 滤镜只能选两个值： KCIInputImageKey (一个CIImage) 和 @”inputIntensity”。 后者是一个封装成NSNumber (用新的文字型语法)的浮点小数，取值在0和1 之间。大部分的滤镜有默认值，只有CIImage是个例外
     */
     
    NSString *clampFilterName = @"CIAffineClamp";
    CIFilter *clamp = [CIFilter filterWithName:clampFilterName];
    
    if (!clamp) {
        
        NSError *error = [self errorForNotExistingFilterWithName:clampFilterName];
        if (completion) {
            completion(error);
        }
        return;
    }
    
    [clamp setValue:sourceImage
             forKey:kCIInputImageKey];
    NSLog(@"%@",[clamp attributes]);
   [clamp setValue:[NSValue valueWithCGAffineTransform:CGAffineTransformMake(1.0, .0, 0, 1, 0, 0)]forKey:@"inputTransform"];
    
    CIImage *clampResult = [clamp valueForKey:kCIOutputImageKey];
    

    
#if 1
    // Apply Gaussian Blur filter
    
    NSString *gaussianBlurFilterName = @"CIGaussianBlur";
    CIFilter *gaussianBlur           = [CIFilter filterWithName:gaussianBlurFilterName];
    
    if (!gaussianBlur) {
        
        NSError *error = [self errorForNotExistingFilterWithName:gaussianBlurFilterName];
        if (completion) {
            completion(error);
        }
        return;
    }
    [gaussianBlur setDefaults];
    
    [gaussianBlur setValue:clampResult
                    forKey:kCIInputImageKey];
    [gaussianBlur setValue:[NSNumber numberWithFloat:blurRadius]
                    forKey:@"inputRadius"];//@"inputRadius"不能随便设置的
    
    CIImage *gaussianBlurResult = [gaussianBlur valueForKey:kCIOutputImageKey];
    
    //self.image = [UIImage imageWithCIImage:gaussianBlurResult];
    
#if 1
    __weak UIImageView *selfWeak = self;
    
    //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        CGImageRef cgImage = [context createCGImage:gaussianBlurResult
                                           fromRect:[sourceImage extent]];
        
        UIImage *blurredImage = [UIImage imageWithCGImage:cgImage];
        
        CGImageRelease(cgImage);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            selfWeak.image = blurredImage;
            if (completion){
                completion(nil);
            }
        });
   // });
#endif
    
#endif
}

/**
 Internal method for generate an NSError if the provided CIFilter name doesn't exists
 */
- (NSError *)errorForNotExistingFilterWithName:(NSString *)filterName
{
    NSString *errorDescription = [NSString stringWithFormat:@"The CIFilter named %@ doesn't exist",filterName];
    NSError *error             = [NSError errorWithDomain:kLBBlurredImageErrorDomain
                                                     code:LBBlurredImageErrorFilterNotAvailable
                                                 userInfo:@{NSLocalizedDescriptionKey : errorDescription}];
    return error;
}

@end
