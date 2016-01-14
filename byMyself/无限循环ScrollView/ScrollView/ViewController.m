//
//  ViewController.m
//  ScrollView
//
//  Created by lizhongqiang on 15/7/8.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"

#import "JCTopic.h"

#import "MyScrollView.h"

@interface ViewController ()<JCTopicDelegate,UIScrollViewDelegate>

@property (nonatomic, strong)JCTopic *Topic;

@property (nonatomic, assign)BOOL flag;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
#if  1
    //实例化
    _Topic = [[JCTopic alloc]initWithFrame:CGRectMake(40, 100, 320, 165)];
    //代理
//    _Topic.JCdelegate = self;
    //创建数据
    NSMutableArray * tempArray = [[NSMutableArray alloc]init];
    //网络图片
    //***********************//
    //key pic = 地址 NSString
    //key title = 显示的标题 NSString
    //key isLoc = 是否本地图片 Bool
    //key placeholderImage = 网络图片加载失败时显示的图片 UIImage
    
    UIImage * PlaceholderImage = [UIImage imageNamed:@"Icon-50.png"];
    
    NSDictionary *dic = @{@"pic":@"http://d.hiphotos.baidu.com/image/pic/item/8601a18b87d6277ffda1a8ed2c381f30e824fcb0.jpg",@"title":@"biaoti",@"isLoc":@(NO),@"placeholderImage":PlaceholderImage};
    
    [tempArray addObject:dic];
    
    [tempArray addObject:[NSDictionary dictionaryWithObjects:@[@"http://b.hiphotos.baidu.com/image/pic/item/9e3df8dcd100baa1dcabdd6e4310b912c9fc2e5b.jpg",@"dadada",@NO,PlaceholderImage] forKeys:@[@"pic",@"title",@"isLoc",@"placeholderImage"]]];
    [tempArray addObject:[NSDictionary dictionaryWithObjects:@[@"http://a.hiphotos.baidu.com/image/pic/item/64380cd7912397dd199d02d15d82b2b7d1a2877b.jpg" ,@"qweeqeqeqeq",@NO,PlaceholderImage] forKeys:@[@"pic",@"title",@"isLoc",@"placeholderImage"]]];
    [tempArray addObject:[NSDictionary dictionaryWithObjects:@[@"http://f.hiphotos.baidu.com/image/pic/item/adaf2edda3cc7cd9480fb10c3d01213fb90e91c1.jpg" ,@"ddwqeqeqeq",@NO,PlaceholderImage] forKeys:@[@"pic",@"title",@"isLoc",@"placeholderImage"]]];
    [tempArray addObject:[NSDictionary dictionaryWithObjects:@[@"http://h.hiphotos.baidu.com/image/pic/item/a8773912b31bb051afa529fd327adab44bede066.jpg" ,@"dadaderrwr",@NO,PlaceholderImage] forKeys:@[@"pic",@"title",@"isLoc",@"placeholderImage"]]];
    //加入数据
    _Topic.pics = tempArray;
    
    _Topic.titleColor = [UIColor colorWithRed:0.22 green:0.15 blue:0.05 alpha:1.0];
    
     _Topic.width = 14;
    
    //更新
    [_Topic upDate];
    
    [self.view addSubview:_Topic];
    
#endif
#if 1
    MyScrollView *scrollview = [[MyScrollView alloc]initWithFrame:CGRectMake(40, 300, 300, 150)];
    
    scrollview.delegate = self;
    
    scrollview.pagingEnabled = YES;
    
    [self.view addSubview:scrollview];
#endif
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat Width = scrollView.frame.size.width;
    
   
    
    if (scrollView.contentOffset.x <= 0) {
        
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width*(7-2), 0) animated:NO];
        
    }else if (scrollView.contentOffset.x >= Width*(7-1)) {
        
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0) animated:NO];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
