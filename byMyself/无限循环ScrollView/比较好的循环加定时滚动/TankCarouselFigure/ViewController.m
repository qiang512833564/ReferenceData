//
//  ViewController.m
//  TankCarouselFigure
//
//  Created by yanwb on 15/12/23.
//  Copyright © 2015年 JINMARONG. All rights reserved.
//

#import "ViewController.h"
#import "TankCycleScrollView.h"
#import "TankCycleImageModel.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *mainTableView;

@property (nonatomic, weak) TankCycleScrollView *cycleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout =  UIRectEdgeNone;
    }

    TankCycleScrollView *cycleView = [[TankCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200) animationDuration:2];
//    cycleView.cycleScrollPageControlAliment = TankCyclePageContolAlimentCenter;
    self.cycleView = cycleView;
    cycleView.enbleStretch = YES;
    cycleView.TapActionBlock = ^(NSInteger pageIndex, id model){
        NSLog(@"%d ,%@",pageIndex,[(TankCycleImageModel *)model attractionId]);
    };

#pragma mark - 本地图片
//    NSMutableArray *imageArray = [NSMutableArray array];
//    for (int i =1 ;i < 3; i++) {
//        NSString *imageName = [NSString stringWithFormat:@"h%d.jpg",i];
//        UIImage *image = [UIImage imageNamed:imageName];
//        [imageArray addObject:image];
//    }
  

//    NSArray *imageArray = [NSArray array];
#pragma mark - 网络图片
    NSArray *imageArray =@[
                                    @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                    @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                    @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                    ];
    cycleView.cycleImageUrlArray = imageArray;
    
#pragma mark - 模型数组
//    NSMutableArray *cycleImageModelArray = [NSMutableArray array];
//    for (int i = 0; i < imageArray.count; i++) {
//        TankCycleImageModel *cycleImageModel = [[TankCycleImageModel alloc] init];
//        cycleImageModel.attractionId = [NSString stringWithFormat:@"%d",i];
//        cycleImageModel.imageUrl = imageArray[i];
//        cycleImageModel.linkUrl = imageArray[i];
//        cycleImageModel.title = [NSString stringWithFormat:@"%d",i];
//        cycleImageModel.jumpType = @"HTML";
//        [cycleImageModelArray addObject:cycleImageModel];
//    }
//    
//    //既可以不传自己再block操作 也可以传递获取model  model自己定义
//    cycleView.modelArray = cycleImageModelArray;
  
    
    
    
    
//     [self.view addSubview:cycleView];
    
    UITableView *mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    self.mainTableView = mainTableView;
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.bounces = YES;
    [self.view addSubview:mainTableView];

    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    self.mainTableView.tableHeaderView = headerView;
    headerView.userInteractionEnabled = YES;
    [self.mainTableView.tableHeaderView addSubview:cycleView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < 0) {
        // 添加上这个限制出现类似微博那种拉伸一半
//        if (offsetY > -100) {
            [self.cycleView cycleScrollViewStretchingWithOffset:offsetY];
//        }
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = @"234567890";
    return cell;
}

@end
