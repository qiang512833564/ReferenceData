//
//  ViewController.m
//  SDWebImage源代码分析
//
//  Created by lizhongqiang on 16/4/13.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"
#import <UIImageView+WebCache.h>
#import <libkern/OSAtomic.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //
    //http://172.16.10.13//hoss-web/hoss/sys/fileDownload/download.do?id=111100496956378
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://172.16.10.13//hoss-web/hoss/sys/fileDownload/download.do?id=111100496956386"] placeholderImage:nil options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        NSLog(@"加载完成 block 回调");
    }];
    [self start];
}
- (void)start
{
    __block int32_t timeOutCount=10;
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        OSAtomicDecrement32(&timeOutCount);
        if (timeOutCount == 0) {
            NSLog(@"timersource cancel");
            dispatch_source_cancel(timer);
        }
    });
    
    dispatch_source_set_cancel_handler(timer, ^{
        NSLog(@"timersource cancel handle block");
    });
    
    dispatch_resume(timer);
}
- (void)timerTick{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
