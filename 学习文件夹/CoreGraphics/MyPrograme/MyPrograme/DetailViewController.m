//
//  DetailViewController.m
//  MyPrograme
//
//  Created by lizhongqiang on 16/1/5.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "DetailViewController.h"
#import "MyView.h"
#import "CGContextClip.h"
#import "CGContextEOClip.h"
@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item
- (void)loadView{
    [super loadView];

    self.view.backgroundColor = [UIColor whiteColor];
    
//    MyView *view = [[MyView alloc]initWithFrame:];
//    view.center = self.view.center;
//    view.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:view];
    
    
}
- (void)setIndexRow:(NSInteger)indexRow{
    CGRect frame = CGRectMake(50, 100, 300, 300);
    switch (indexRow) {
        case 0:
        {
            My_CGContextClip *view = [[My_CGContextClip alloc]initWithFrame:frame];
            [self.view addSubview:view];
        }
            break;
        case 1:
        {
            My_CGContextEOClip *view = [[My_CGContextEOClip alloc]initWithFrame:frame];
            [self.view addSubview:view];
        }
        case 2:
        {
            MyView *view = [[MyView alloc]initWithFrame:frame];
            view.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:view];
        }
            break;
            
        default:
            break;
    }
}
- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
