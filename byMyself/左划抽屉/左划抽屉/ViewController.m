//
//  ViewController.m
//  左划抽屉
//
//  Created by lizhongqiang on 15/7/13.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    
}


- (void)show
{
    
    
    
    CGAffineTransform transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -100, 0);
    
    [UIView animateWithDuration:0.5f animations:^{
        self.view.transform = transform;
        
    }completion:^(BOOL finished) {
        
    }];
#if 0
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.toValue = @(-100);
    animation.duration = .5f;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];//  这样子做不行，因为transform.translation.x并没有实际改变位置
    
    [self.view.layer addAnimation:animation forKey:@"transform.translation.x"];
#endif
}
- (void)hide
{
    [UIView animateWithDuration:0.5f animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //if(_isShowingToolBar)
    {
      
        
        if(self.delegate&&[self.delegate respondsToSelector:@selector(hideRightToolBar)])
        {
            [self.delegate hideRightToolBar];
            
            [self  hide];
            
            
            
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
