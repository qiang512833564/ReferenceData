//
//  SearchViewController.m
//  MapByMyself
//
//  Created by lizhongqiang on 15/7/27.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<BMKSuggestionSearchDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITextField *textfield;
@property (nonatomic, strong)BMKSuggestionSearch *pioSearch;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *resultArray;
@property (nonatomic, strong)NSMutableArray *cityArray;
@end

@implementation SearchViewController

static NSString *cellId = @"cellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView =  self.textfield;
    [self.view addSubview:self.tableView];
}
- (NSMutableArray *)resultArray
{
    if(_resultArray == nil)
    {
        _resultArray = [NSMutableArray array];
    }
    return _resultArray;
}
- (NSMutableArray *)cityArray
{
    if(_cityArray == nil)
    {
        _cityArray = [NSMutableArray array];
    }
    return _cityArray;
}
- (UITableView *)tableView
{
    if(_tableView == nil)
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
        
    }
    return _tableView;
}
- (UITextField *)textfield
{
    if(_textfield == nil)
    {
        _textfield = [[UITextField alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 32, 200, 32)];
        _textfield.borderStyle = UITextBorderStyleRoundedRect;
        _textfield.bk_didBeginEditingBlock = ^(UITextField *textfield)
        {
            
        };
        [_textfield addTarget:self action:@selector(changeContent:) forControlEvents:UIControlEventEditingChanged];
 
    }
    
    return _textfield;
}
- (BMKSuggestionSearch *)pioSearch
{
    if(_pioSearch == nil)
    {
        _pioSearch = [[BMKSuggestionSearch alloc]init];
        _pioSearch.delegate = self;
        
    }
    return _pioSearch;
}
- (void)changeContent:(UITextField *)textfield
{
    BMKSuggestionSearchOption *optionSearch = [[BMKSuggestionSearchOption alloc]init];
    optionSearch.cityname = nil;//如果这里传NULL，则会进行全国搜索
    optionSearch.keyword = textfield.text;
    if([self.pioSearch suggestionSearch:optionSearch])
    {
        NSLog(@"检索发送成功");
    }
    else
    {
        NSLog(@"检索发送失败");
    }
}
- (void)onGetSuggestionResult:(BMKSuggestionSearch *)searcher result:(BMKSuggestionResult *)result errorCode:(BMKSearchErrorCode)error
{

    if(error == BMK_SEARCH_NO_ERROR)
    {
        [self.resultArray removeAllObjects];
        [self.cityArray removeAllObjects];
        [self.cityArray addObjectsFromArray:result.cityList];
        [self.resultArray addObjectsFromArray:result.keyList];
        [self.tableView reloadData];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _resultArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    cell.textLabel.text = self.resultArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMKPlanNode *loaction = [[BMKPlanNode alloc]init];
    loaction.name = self.resultArray[indexPath.row];
    loaction.cityName = self.cityArray[indexPath.row];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"searchLocation" object:loaction];
    [self.navigationController popToRootViewControllerAnimated:YES];
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
