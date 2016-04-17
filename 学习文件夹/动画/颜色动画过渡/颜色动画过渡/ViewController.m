//
//  ViewController.m
//  颜色动画过渡
//
//  Created by lizhongqiang on 16/4/17.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *needAnimationView;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation ViewController
- (IBAction)changeValue:(UISlider *)sender {
    self.needAnimationView.layer.timeOffset = sender.value;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.slider.value = 0;
    // Do any additional setup after loading the view, typically from a nib.
    CABasicAnimation *changeColor =
    [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    changeColor.fromValue = (id)[UIColor orangeColor].CGColor;
    changeColor.toValue   = (id)[UIColor blueColor].CGColor;
    changeColor.duration  = 1.0; // For convenience
    
    [self.needAnimationView.layer addAnimation:changeColor
                        forKey:@"Change color"];
    
    self.needAnimationView.layer.speed = 0.0; // Pause the animation
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
