//
//  RootViewController.m
//  SpecialCellDemo
//
//  Created by hw500029 on 15/12/28.
//  Copyright © 2015年 MYP. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
{
    NSMutableArray *dataArray;
}
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArray = [NSMutableArray new];
    for (int i = 0; i < 20; i++)
    {
        NSString *name = [NSString stringWithFormat:@"name%d",i];
        [dataArray addObject:name];
    }
    
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    //_mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    MGSwipeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[MGSwipeTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
    cell.leftButtons = @[[MGSwipeButton buttonWithTitle:[NSString stringWithFormat:@"Btn%ld",(long)indexPath.row] backgroundColor:[UIColor  orangeColor]],[MGSwipeButton buttonWithTitle:[NSString stringWithFormat:@"Btn%ld",(long)indexPath.row] backgroundColor:[UIColor  grayColor]],[MGSwipeButton buttonWithTitle:[NSString stringWithFormat:@"Btn%ld",(long)indexPath.row] backgroundColor:[UIColor  greenColor]]];
    cell.leftSwipeSettings.transition = MGSwipeTransitionRotate3D;
    
    cell.rightButtons = @[[MGSwipeButton buttonWithTitle:[NSString stringWithFormat:@"Btn%ld",(long)indexPath.row] backgroundColor:[UIColor  purpleColor]],[MGSwipeButton buttonWithTitle:[NSString stringWithFormat:@"Btn%ld",(long)indexPath.row] backgroundColor:[UIColor  cyanColor]],[MGSwipeButton buttonWithTitle:[NSString stringWithFormat:@"Btn%ld",(long)indexPath.row] backgroundColor:[UIColor  redColor]]];
    cell.leftSwipeSettings.transition = MGSwipeTransitionRotate3D;
    cell.leftSwipeSettings.transition = MGSwipeTransitionStatic;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
