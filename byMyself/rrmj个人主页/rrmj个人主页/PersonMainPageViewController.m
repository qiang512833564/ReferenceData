//
//  PersonMainPageViewController.m
//  rrmj个人主页
//
//  Created by lizhongqiang on 15/8/26.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "PersonMainPageViewController.h"
#import "CertificationInfoCell.h"
#import "SimpleIntroductionCell.h"
#import "HeadView.h"
#import "UIImageView+WebCache.h"
#import "RepresentCell.h"
#import "MorePictureCell.h"
#import "DynamicTableViewCell.h"
#import "PersonView.h"

@interface PersonMainPageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign)BOOL needShowIntroduction;
@property (nonatomic, strong)HeadView *headView;
@end

@implementation PersonMainPageViewController

static NSString *certificationCellId = @"CertificationInfoCellId";
static NSString *introductionCellId = @"SimpleIntroductionCellId";
static NSString *dynamicCellId = @"DynamicTableViewCellId";
static NSString *customTitle = @"命令指出，几十年来，该连历代官兵面对恶劣自然环境和复杂边防斗争，大力发扬我军光荣传统和优良作风，靠团结友爱凝聚士气、靠生死与共强化担当，忠诚履行卫国戍边神圣使命。连队2次被军区表彰为边防执勤先进单位，年年被评为军事训练一级单位和基层建设标兵单位。1998年以来荣立一等功2次、二等功4次、三等功3次，被表彰为首届全军践行强军目标标兵单位大力发扬我军光荣传统和优良作风，靠团结友爱凝聚士气、靠生死与共强化担当，忠诚履行卫国戍边神圣使命。连队2次被军区表彰为边防执勤先进单位，年年被评为军事训练一级单位和基层建设标兵单位。1998年以来荣立一等功2次、二等功4次、三等功3次，被表彰为首届全军践行强军目标标兵单位。";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor colorWithRed:245/255.f green:246/255.f blue:247/255.f alpha:1];
    
    _headView = [[HeadView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    [self.view addSubview:_headView];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorColor = [UIColor clearColor];
    
    [self.view insertSubview:_headView belowSubview:self.tableView];
    
    //_headView.backgroundColor = [UIColor blueColor];
    //self.tableView.backgroundColor = [UIColor redColor];
    [_headView.bgImageView setImageWithURL:[NSURL URLWithString:@"http://d.hiphotos.baidu.com/image/h%3D360/sign=44532e8a9816fdfac76cc0e8848e8cea/cc11728b4710b9122b40235fc6fdfc039345228a.jpg"]];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DynamicTableViewCell" bundle:nil] forCellReuseIdentifier:dynamicCellId];
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        CertificationInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:certificationCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if(indexPath.section == 1)
    {
        SimpleIntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:introductionCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        __unsafe_unretained PersonMainPageViewController *weakSelf = self;
        __unsafe_unretained SimpleIntroductionCell *weakCell = cell;
        cell.updateContraints = ^(void)
        {
            switch (weakCell.pullBtn.selected) {
                case 0:
                {
                    [weakSelf.tableView setNeedsUpdateConstraints];
                    //                [self.tableView setNeedsLayout];
                    //                [self.tableView layoutIfNeeded];
                    
                    weakSelf.needShowIntroduction = YES;
                    
                    [weakSelf.tableView reloadData];
//                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
//                    [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    break;
                }
                    
                default:
                {
                    [weakSelf.tableView setNeedsUpdateConstraints];
                    //                [self.tableView setNeedsLayout];
                    //                [self.tableView layoutIfNeeded];
                    
                    weakSelf.needShowIntroduction = NO;
                    
                    [weakSelf.tableView reloadData];
//                    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:0 inSection:1];
//                    [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath1] withRowAnimation:UITableViewRowAnimationNone];
                
                    break;
                }
            }
            
        };
        [cell config:customTitle];//
        return cell;
    }
    if(indexPath.section == 2)
    {
        RepresentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RepresentCellId"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell config:10];
        return cell;
    }
    if(indexPath.section == 3)
    {
        MorePictureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MorePictureCellId"];
        [cell config:11];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if(indexPath.section == 4)
    {
        DynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dynamicCellId];
        if(cell == nil)
        {
            cell = [[DynamicTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dynamicCellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        if(cell == nil)
//        {
//            cell = [[NSBundle mainBundle]loadNibNamed:@"DynamicTableViewCell" owner:self options:nil][0];
//        }
        NSString *text1 = @"艾米利亚0克莱克";
        NSString *text2 = @"后青团";
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",text1,text2]];
        [attriString addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(0, text1.length)];
        [attriString addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(text1.length+1, text2.length)];
        //NSMutableParagraphStyle
        cell.nameLabel.attributedText = attriString;
        
        cell.PartLabel.text = @"圣神的游戏 饰 美女";
        cell.PartLabel.textColor = [UIColor grayColor];
        [cell config:0];
        return cell;
    }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 200;
    }
    return 0.000000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 50;
            break;
        case 1:
        {
            if(self.needShowIntroduction)
            {
                return [SimpleIntroductionCell returnFromNSString:customTitle]+52;
            }
            else
            {
            CGFloat height = [SimpleIntroductionCell returnFromNSString:customTitle];
            if(height < 73)
            {
                return [SimpleIntroductionCell returnFromNSString:customTitle]+52;
            }
            else
            {
                return 73+52;
            }
            }
        }
            
//            if()
//            {
//                
//            }
//            if(self.needShowIntroduction) return ;
//            return [SimpleIntroductionCell returnFromNSString:@"命令指出，几十年来，该连历代官兵面对恶劣自然环境和复杂边防斗争"]+52;
            break;
        case 2:
            return 145;
        case 3:
            return 142;
        default:
            break;
    }
    int number = 0;
    if(number == 0)
    {
        return 259-67;
    }else
    {
        return 259;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        PersonView *view = [[PersonView alloc]init];
        view.backgroundColor = [UIColor clearColor];        
        
        return view;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 4) {
        return 47;
    }
    else
    {
        return 0;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(section ==4)
    {
        UIView *view = [[UIView alloc]init];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10, 8, self.view.bounds.size.width-2*10, 47-2*8);
        [btn setTitle:@"查看全部动态" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.layer.borderColor = [UIColor colorWithRed:222/255.f green:223/255.f blue:224/255.f alpha:1.0].CGColor;
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
#pragma mark "scrollViewDelegate方法"
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect headFrame = scrollView.frame;
    
    headFrame.size.height = 200-scrollView.contentOffset.y;
    
    _headView.frame = headFrame;
    
    //[_headView setNeedsUpdateConstraints];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
