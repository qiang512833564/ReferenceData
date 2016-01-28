//
//  ViewController.m
//  IndicatorView
//
//  Created by Dinotech on 16/1/4.
//  Copyright © 2016年 Dinotech. All rights reserved.
//

#import "ViewController.h"
#import "RYSpotIndicatorView.h"
#define kRYBounceSpot2AnimationDuration 0.6

@interface ViewController ()
@property CALayer *spotLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self configAnimationAtLayer:self.view.layer withTintColor:[UIColor redColor] size:CGSizeMake(100, 100)];
    
    RYSpotIndicatorView * spot = [[RYSpotIndicatorView alloc]init];
    [spot setFrame:CGRectMake(10, 100,80 ,20)];
    spot.circleSize = CGSizeMake(40, 40);
    [self.view addSubview:spot];
    spot.backgroundColor = [UIColor greenColor];
    
    
    
    
    
  /*
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<6; i ++) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(100 +i *20, 100, 10, 10)];
        lab.tag = i;
        [lab.layer setBorderWidth:1];
        [lab.layer setMasksToBounds:YES];
        [lab.layer setCornerRadius:5];
        [array addObject:lab];
        [self.view addSubview:lab];
    }
    
   
[UIView animateKeyframesWithDuration:0.1 delay:0 options:UIViewKeyframeAnimationOptionAutoreverse animations:^{
    for (int i = 0 ; i <array.count;i ++) {
        UILabel *lab =array[i];
        if (i == num%6) {
            lab.backgroundColor = [UIColor redColor];
        }else{
            lab.backgroundColor = [UIColor clearColor];
        }
        num++;
    }
    
} completion:^(BOOL finished) {
    
}];
    [UIView animateWithDuration:3 animations:^{
        
       
        
    } completion:^(BOOL finished) {
        
    }];
    [UIView setAnimationRepeatCount:MAXFLOAT];
   */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
