//
//  ViewController.m
//  Cell-autoLayout
//
//  Created by lizhongqiang on 15/12/28.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId2"];
    return [cell getCellHeight:indexPath forTable:tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellId";
    static NSString *cellId2 = @"CellId2";
    //if(indexPath.row/2==0)
    {
        CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        cell.myTitle.text = @"打打篮球温控器去哪里去玩的郊区到去年擦肩那块";
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    return  cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
