//
//  ViewController.m
//  model_layer_and_presentation_tree
//
//  Created by lizhongqiang on 16/4/7.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"
#import "View.h"

@interface ViewController ()<ViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (nonatomic, strong) View *test_view;
@end

@implementation ViewController
#if 0
- (void)loadView{
    View * view = [[View alloc]init];
    view.delegate = self;
    view.backgroundColor = [UIColor whiteColor];
    [view addSubview:self.redView];
    [view addSubview:self.greenView];
    [view addSubview:self.blueView];
    self.view = view;
}
#endif
- (void)touchAction:(CGPoint)point{
    NSLog(@"%@",NSStringFromCGPoint(point));
    NSLog(@"%@",[self.test_view.layer.presentationLayer hitTest:point]);
    if ([self.test_view.layer.presentationLayer hitTest:point]) {
        
        self.test_view.backgroundColor = [UIColor yellowColor];
    }else{
        
        //self.test_view.layer.position = point;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.test_view = [[View alloc]init];
//    self.test_view.userInteractionEnabled = NO;
    self.test_view.frame = CGRectMake(0, 0, 100, 100);
    self.test_view.center = CGPointZero;
    self.test_view.backgroundColor = [UIColor redColor];
    [self.view addSubview:_test_view];
    NSLog(@"%@----%@",self.test_view.layer,self.test_view.layer.presentationLayer);
    [UIView animateWithDuration:5.0f animations:^{
        self.test_view.center = CGPointMake(200, 400);
    }];
    //CADisplayLink *displaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(show)];
    //displaylink.frameInterval = 60;
    //[displaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject]locationInView:self.view];
    //NSLog(@"%@----%@----bool=%d",self.test_view.layer,self.test_view.layer.presentationLayer,self.test_view.layer == self.test_view.layer.presentationLayer);
    NSLog(@"%@",[self.test_view.layer.presentationLayer hitTest:point]);
    if ([self.test_view.layer.presentationLayer hitTest:point]) {
        
        self.test_view.backgroundColor = [UIColor yellowColor];
    }else{
        
        //self.test_view.layer.position = point;
    }
}
- (void)show{
    
    
    CALayer *layer = self.test_view.layer.presentationLayer;
    
    NSLog(@"layer = %@, presentationlayer = %@",layer,self.test_view.layer.presentationLayer);
    
   // NSLog(@"model:%@, presentLayer:%@",NSStringFromCGPoint(self.test_view.layer.position),NSStringFromCGPoint(layer.position));
    /*
     输出结果
     model:{200, 400}, presentLayer:{0.00032681411994417431, 0.00065362823988834862}
     model:{200, 400}, presentLayer:{20.856837928295135, 41.713675856590271}
     model:{200, 400}, presentLayer:{74.557501077651978, 149.11500215530396}
     model:{200, 400}, presentLayer:{141.53085947036743, 283.06171894073486}
     model:{200, 400}, presentLayer:{187.63104677200317, 375.26209354400635}
     model:{200, 400}, presentLayer:{200, 400}
     可以看出：
     model Layer tree中的Layer是我们通常意义说的Layer。当我们修改layer中的属性时，就会立刻修改model layer tree。
     presentation tree是Layer在屏幕中的真实位置。(是表示当前视图在屏幕的真实位置(渲染位置))
     */
}
- (IBAction)beginAnimation:(UIButton *)sender {
    
    NSLog(@"%@",NSStringFromCGRect(self.blueView.frame));
    CGPoint red_startPoint = self.redView.center;
    CGPoint blue_startPoint = self.blueView.center;
    [CATransaction begin];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.5 :0 :.5 :1]];
    if(sender.selected == NO){
        
        self.redView.center = CGPointMake(red_startPoint.x, 88);
        [UIView animateWithDuration:5.0  delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.redView.center = CGPointMake(red_startPoint.x, 500);
        } completion:^(BOOL finished) {
            
        }];
        
    }else{
        [UIView animateWithDuration:5.0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.redView.center = CGPointMake(red_startPoint.x, 88);
        } completion:^(BOOL finished) {
            
        }];
    }
    [CATransaction commit];
    //

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.duration = 5.0;
        //animation.byValue =
    NSNumber *fromValue = @500;
    NSNumber *toValue = @88;
    NSNumber *endValue = toValue;
   
    if(!sender.selected){
        animation.fromValue = @([fromValue intValue] - [toValue intValue]);
    }else{
        animation.fromValue = @([toValue intValue] - [fromValue intValue]);
        endValue = fromValue;
    }
    //[NSValue valueWithCGPoint:CGPointMake(blue_startPoint.x, 150)];
    animation.toValue = @(0);//[NSValue valueWithCGPoint:CGPointMake(blue_startPoint.x, 550)];
    animation.additive = YES;
    /*
     设置 additive 属性为 YES 使 Core Animation 无需提前知道它们的位置,其动画fromValue、toValue位置，是相对于layer.position的模型层position。(这个属性，在制作 shaking 类型动画，是极为方便的)
     */
    
    static NSUInteger number = 0;
    self.blueView.layer.position = CGPointMake(self.blueView.layer.position.x, [endValue integerValue]);
    animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:.5 :0 :.5 :1];
    //这里之所以用不同的 key 作为 forKey 的值，是为了不删掉之前的动画 Animation1，而是添加一个新的动画  Animation2,使得整个 layer 的整个运动运城了2个动画的合成
    //注意动画过成中，layer 的 presentationlayer 的位置，是由两个动画根据自己的时间函数生成与时间相对应的位移位置运算得到的
    [self.blueView.layer addAnimation:animation forKey:[NSString stringWithFormat:@"aniamtion_%ld",number++]];
    
    sender.selected = !sender.selected;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
