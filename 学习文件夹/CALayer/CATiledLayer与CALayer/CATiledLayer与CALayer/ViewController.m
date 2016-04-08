//
//  ViewController.m
//  CATiledLayer与CALayer
//
//  Created by lizhongqiang on 16/4/6.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"
#import "CATiledLayer_test.h"
#import "CALayer_drawsAsynchronously.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "Asynchronously.h"

static void *RACSubclassAssociationKey = &RACSubclassAssociationKey;


@interface ViewController ()
@property (nonatomic, strong) CALayer *drawsAsynchronously;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CATiledLayer_test *test1 = [[CATiledLayer_test alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:test1];
    test1.backgroundColor = [UIColor yellowColor];
    
    CALayer_drawsAsynchronously *test2 = [[CALayer_drawsAsynchronously alloc]initWithFrame:CGRectMake(0, 300, 100, 100)];
    [self.view addSubview:test2];
    test2.backgroundColor = [UIColor redColor];
    
    CATiledLayer *tileLayer = [CATiledLayer layer];
    tileLayer.frame = CGRectMake(200, 0, 100, 100);
    tileLayer.delegate = self;
    [self.view.layer addSublayer:tileLayer];
    
    [tileLayer setNeedsDisplay];
    
    [self.view.layer addSublayer:self.drawsAsynchronously];
}
- (CALayer *)drawsAsynchronously{
    if (_drawsAsynchronously == nil) {
        _drawsAsynchronously = [CALayer layer];
        _drawsAsynchronously.frame = CGRectMake(200, 300, 100, 100);
        _drawsAsynchronously.drawsAsynchronously = YES;
        /*当你设置 drawsAsynchronously = YES 后，-drawRect: 和 -drawInContext: 函数依然实在主线程调用的。但是所有的Core Graphics函数（包括UIKit的绘制API，最后其实还是Core Graphics的调用）不会做任何事情，而是所有的绘制命令会被在后台线程处理。
         这种方式就是先记录绘制命令，然后在后台线程执行。为了实现这个过程，更多的事情不得不做，更多的内存开销。最后只是把一些工作从主线程移动出来。这个过程是需要权衡，测试的。
         
         这个可能是代价最昂贵的的提高绘制性能的方法，也不会节省很多资源
        */
        _drawsAsynchronously.delegate = self;
        _drawsAsynchronously.backgroundColor = [UIColor purpleColor].CGColor;
        [_drawsAsynchronously setNeedsDisplay];
        
        
        
        unsigned int count = 0;
        Method *method = class_copyMethodList([Asynchronously class], &count);
        for (int i = 0 ; i < count; i++) {
            Method nowMethod = method[i];
            SEL sel = method_getName(nowMethod);
            class_replaceMethod([Asynchronously class], sel, _objc_msgForward, "v@:");
        }
        
    }
    return _drawsAsynchronously;
}
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    if (layer == self.drawsAsynchronously) {
        NSLog(@"%@",[NSThread currentThread]);
        
        Asynchronously *test = [[Asynchronously alloc]init];
        [test test_Asynchronously];
    }
    //viewController = <NSThread: 0x7f9213407970>{number = 10, name = (null)}
    NSLog(@"viewController = %@",[NSThread currentThread]);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
