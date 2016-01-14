//
//  SeriesViewController.m
//  rrmj个人主页
//
//  Created by lizhongqiang on 15/8/27.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "SeriesViewController.h"
#import "UIImageView+WebCache.h"
#import "StarsLine.h"
#import "IntroductionCell.h"
#import "ActorsCell.h"
#import "PicturesCell.h"
#import "NewJuPingCell.h"
#import "ToolView.h"

@interface SeriesViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong)UIImageView *headImageView;
@property (nonatomic, assign)BOOL showIntroduction;
@property (nonatomic, strong)ToolView *tool;
@end

@implementation SeriesViewController
static NSString *stl = @"Cyanogen成立于2009年，Cyanogen成立于2009年，先是由一家生物信息初创公司的首席工程师Steve Kondik（其论坛ID就是Cyanogen）发起，后来渐渐有一批拥有共同兴趣爱好的码农陆续加入形成Cyanogen团队。整个团队都是业余时间从事Cyanogen的开发工作，成员们都有自己的职业。甚至包括创始人Steve Kondik在内，他也曾经在开发CyanogenMod（简称CM系统）的过程中就职于三星电子任软件工程师。。";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor colorWithRed:245/255.f green:246/255.f blue:247/255.f alpha:1.0];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 21)];
    label.text = @"破产姐妹";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = label;
    
    self.navigationController.title = label.text;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorColor = [UIColor clearColor];
    
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    [self.view addSubview:_headImageView];
    _headImageView.layer.masksToBounds = YES;
    [self.view insertSubview:_headImageView belowSubview:self.tableView];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_headImageView setImageWithURL:[NSURL URLWithString:@"http://wenwen.soso.com/p/20100310/20100310203612-1213017499.jpg"]];
    
    [self addToolBar];
}
- (void)addToolBar
{
    _tool = [[ToolView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height - 50,CGRectGetWidth(self.view.frame), 50)];
    _tool.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tool];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 3)
    {
        return 3;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            
                if([IntroductionCell returnFromNSString:stl]>73&&!self.showIntroduction)
                {
                    return 97+28+73;
                }
                return 97+28+[IntroductionCell returnFromNSString:stl];
            
            
        }
            break;
        case 1:
            return 173.f;
            break;
        case 2:
            return 144.f;
            break;
            
        default:
            break;
    }
    if(indexPath.row == 0)
    {
        return 163;
    }
    return 133;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            IntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IntroductionCellId"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.title = stl;
            __weak IntroductionCell *weakCell = cell;
            __weak SeriesViewController *weakSelf = self;
            cell.updateContraints = ^(void)
            {
                if(_showIntroduction)
                {
                    _showIntroduction = NO;
                }
                else
                {
                    _showIntroduction = YES;
                }
                [weakCell updateConstraints];
                [weakSelf.tableView reloadData];
                //[_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:3];
            };
            return cell;
        }
            break;
        case 1:
        {
            ActorsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActorsCellId"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.index = 10;
            return cell;
        }
            break;
        case 2:
        {
            PicturesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PicturesCellId"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.number = 10;
            return cell;
        }
            break;
        case 3:
        {
            static NSString *cellId = @"NewJuPingCellId";
            NewJuPingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if(cell == nil)
            {
                cell = [[NSBundle mainBundle]loadNibNamed:@"NewJuPingCell" owner:self options:nil][0];
            }
            if(indexPath.row != 0)
            {
                cell.tipLabel.text = @"";
                cell.JupingHeight.constant = 3;
                [cell setNeedsUpdateConstraints];
            }
            return cell;
        }
        default:
            break;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 200)];
        view.backgroundColor = [UIColor clearColor];
        StarsLine *stars = [[StarsLine alloc]init];
        [view addSubview:stars];
        stars.center = CGPointMake(self.view.center.x, 31+37);
        stars.bounds = CGRectMake(0, 0, 145, 21);
        stars.score = 0;
        ;
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.layer.masksToBounds = YES;
        imageView.center = CGPointMake(self.view.center.x, CGRectGetMaxY(stars.frame)+6.7+125/2.f);
        imageView.bounds = CGRectMake(0, 0, 110, 125);
        [view addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [imageView setImageWithURL:[NSURL URLWithString:@"http://d.hiphotos.baidu.com/image/h%3D360/sign=646bc5e51b30e924d0a49a377c096e66/242dd42a2834349b6058b668cdea15ce37d3be85.jpg"]];
        imageView.backgroundColor = [UIColor blueColor];
        
        UIImageView *iconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_drama_play"]];
        iconImageView.center = CGPointMake(CGRectGetWidth(imageView.frame)/2.f, CGRectGetHeight(imageView.frame)/2.f);
        iconImageView.userInteractionEnabled = YES;
        [iconImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playAction:)]];
        //iconImageView.backgroundColor = [UIColor blueColor];
        iconImageView.bounds = CGRectMake(0, 0, 40, 40);
        [imageView addSubview:iconImageView];
        
        return view;
    }
    return nil;
}
- (void)playAction:(UITapGestureRecognizer *)tap
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 200;
    }
    return 0.00000000000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == 3)
    {
        return 47+50+14;
    }
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(section == 3)
    {
        UIView *view = [[UIView alloc]init];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10, 14, self.view.bounds.size.width-2*10, 47-2*8);
        [btn setTitle:@"查看全部剧评" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.layer.borderColor = [UIColor colorWithRed:222/255.f green:223/255.f blue:224/255.f alpha:1.0].CGColor;
        [btn addTarget:self action:@selector(showAllJuping) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.borderWidth = 0.4;
        [btn setTitleColor:[UIColor colorWithRed:96/255.f green:97/255.f blue:98/255.f alpha:1.0] forState:UIControlStateNormal];
        [view addSubview:btn];
        
        return view;
    }
    else
    {
        return nil;
    }
}
- (void)showAllJuping
{
    NSLog(@"查看所有剧评");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark "scrollViewDelegate方法"
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect headFrame = scrollView.frame;
    
    headFrame.size.height = 200-scrollView.contentOffset.y;
    
    _headImageView.frame = headFrame;
    
    //[_headView setNeedsUpdateConstraints];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
