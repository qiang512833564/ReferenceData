//
//  ViewController.m
//  Water-waves
//
//  Created by lizhongqiang on 15/12/8.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    int transitionStartTime;
}
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)CIFilter *filter;
@property (nonatomic, assign)double duration;
@property (nonatomic, strong)CIContext *context;
@end

@implementation ViewController

- (UIImageView *)imageView{
    if(_imageView == nil){
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, 80, 300, 400)];
        _imageView.image = [UIImage imageNamed:@"picture.jpg"];
        //_imageView.backgroundColor = [UIColor blueColor];
    }
    return _imageView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    transitionStartTime = CACurrentMediaTime();
    [self.view addSubview:self.imageView];
    // Do any additional setup after loading the view, typically from a nib.
    [self main];
}
- (void)main{
   // NSLog(@"%@",self.filter.outputImage);
    //self.imageView.image = [UIImage imageWithCIImage:self.filter.outputImage];
    
    [self rippleImage:duration];
    BOOL ret = NO;
//    do{
//        [[NSRunLoop currentRunLoop]runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//        [[NSRunLoop currentRunLoop]runMode:NSRunLoopCommonModes beforeDate:[NSDate distantFuture]];
//    }while (!ret);
}
double duration = 2.0;

- (void)rippleImage:(double) duration{
    self.duration = duration;
    
    transitionStartTime = CACurrentMediaTime();
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(timerFired:)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)timerFired:(CADisplayLink *)link{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        double progress = (CACurrentMediaTime()-transitionStartTime)/duration;
        //NSLog(@"%f----%@",progress,NSStringFromCGRect(self.filter.outputImage.extent));
        [self.filter setValue:@(progress) forKey:kCIInputTimeKey];
        //CIContext *context = [CIContext contextWithOptions:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:kCIContextUseSoftwareRenderer]];//kCIContextUseSoftwareRenderer对应的值设置为NO的时候，就是全部通过GPU来渲染
        //CIImage *myciimage = self.filter.outputImage;
       // CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        @autoreleasepool {
            UIImage *image = nil;
            //image = [UIImage imageWithCIImage:self.filter.outputImage];
           CGImageRef cgimage = [self.context createCGImage:self.filter.outputImage fromRect:self.filter.outputImage.extent];
            image = [UIImage imageWithCGImage:cgimage];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //self.imageView.image = nil;
            @autoreleasepool {
                //
                //NSLog(@"%@",cgimage);
                 self.imageView.image = image;////[UIImage imageWithCGImage:cgimage]
            }
           
            if(progress >= 2.0){
                transitionStartTime = CACurrentMediaTime();
                //self.imageView.image = [UIImage imageNamed:@"picture.jpg"];
                // [link invalidate];
            }
        });
}
    });
    
}
- (CIContext *)context{
    if(_context == nil){
        _context = [CIContext contextWithOptions:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:kCIContextUseSoftwareRenderer]];
    }
    return _context;
}

- (CIFilter *)filter{
    if(_filter == nil){
        UIImage *image = [UIImage imageNamed:@"picture.jpg"];
        //float w = 480.0;
        //float h = 360.0;
        CIImage *coreImage = [CIImage imageWithCGImage:image.CGImage];
        //NSString *path = [[NSBundle mainBundle]pathForResource:@"picture" ofType:@"jpg"];
        //CIImage *coreImage = [[CIImage alloc]initWithContentsOfURL:[NSURL URLWithString:path]];
        //NSLog(@"%@",[CIFilter filterNamesInCategory:kCICategoryBuiltIn]);
        CIFilter *rippleTransitionFilter = [CIFilter filterWithName:@"CIRippleTransition"];
        //[rippleTransitionFilter setDefaults];
        //[rippleTransitionFilter setValue:coreImage forKey:kCIInputShadingImageKey];
        //[rippleTransitionFilter setValue:[CIVector vectorWithX:w*0.5 Y:h*0.5] forKey:kCIInputCenterKey];
        //NSLog(@"%@",rippleTransitionFilter.attributes);
        [rippleTransitionFilter setValue:coreImage forKey:kCIInputImageKey];
        [rippleTransitionFilter setValue:coreImage forKey:kCIInputTargetImageKey];;
        [rippleTransitionFilter setValue:[[CIImage alloc]init] forKey:kCIInputShadingImageKey];
        _filter = rippleTransitionFilter;
        
        //CATransition *theTransition = [CATransition animation];
        //[theTransition setFilter:rippleTransitionFilter];
       // [theTransition setDuration:2.0];
        
        //[self.imageView.layer addAnimation:theTransition forKey:@"animation"];
    }
    return _filter;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
