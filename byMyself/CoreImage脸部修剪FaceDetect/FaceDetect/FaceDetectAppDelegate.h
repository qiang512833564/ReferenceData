//
//  FaceDetectAppDelegate.h
//  FaceDetect
//
//  Created by iObitLXF on 12/10/12.
//  Copyright (c) 2012 iObitLXF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>
#import "FaceDetectViewController.h"

@interface FaceDetectAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FaceDetectViewController *controller;
@end
