//
//  ViewController.h
//  HelloGL
//
//  Created by lizhongqiang on 15/10/26.
//  Copyright (c) 2015年 lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
@interface ViewController : GLKViewController
@property (strong,nonatomic)EAGLContext *context;
@property (strong, nonatomic)GLKBaseEffect *effect;

@end

