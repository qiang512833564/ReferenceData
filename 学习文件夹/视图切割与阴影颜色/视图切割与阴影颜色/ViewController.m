//
//  ViewController.m
//  视图切割与阴影颜色
//
//  Created by lizhongqiang on 15/11/5.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"
#import "Utility.h"
@interface ViewController ()
@property (nonatomic, strong)UIImageView *bgView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:imageview];
    imageview.image = [UIImage imageNamed:@"图片.jpg"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"界面刷新" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(200, 100, 60, 40);
    
    UIView *myview = [[UIView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:btn];
    _bgView = imageview;
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    myview.backgroundColor = [UIColor whiteColor];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        for(int i=0; i<4; i++){
            CGFloat offset = (CGRectGetWidth(self.view.frame)/4.f);
            BOOL left = !(i%2?YES:NO);
            CGSize size = self.view.frame.size;
            UIView *view = [Utility createSnapshotFromView:self.view afterUpdates:YES location:i*offset left:left];
            view.backgroundColor = [UIColor blackColor];
            //view.frame = CGRectOffset(view.frame, i*offset, 0);
            if(left){
                view.layer.position = CGPointMake(i*offset, size.height*0.5);
                /*
                 position、anchorPoint、origin三者之间分关系
                 frame.origin.x = position.x - anchorPoint.x * bounds.size.width/2.0;
                 frame.origin.y = position.y - anchorPoint.x * bounds.size.height/2.0;
                 */
            }else
            {
                view.layer.position = CGPointMake(i*offset+offset,size.height*0.5);
            }
            [imageview addSubview:view];
            [view.subviews[1] setAlpha:0.0];
            view.tag = 100+i;
        }
        [Utility startAnimation:imageview];
        //[self.view addSubview:myview];
    });
    
}
- (void)btnAction:(UIButton *)sender
{
    //self.bgView.image = nil;
    
    //for(int i=0; i<4; i++){
        CGFloat offset = (CGRectGetWidth(self.view.frame)/4.f);
        UIView *view = [Utility createSnapshotFromView:self.view afterUpdates:YES location:2*offset left:NO];
        NSLog(@"%@----%d",[view class],[view isKindOfClass:[UIImageView class]]);
        view.backgroundColor = [UIColor blackColor];
        view.frame = CGRectOffset(view.frame, 0*offset, 0);
        [self.view addSubview:view];
    //}
   // [self.view addSubview:myview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
