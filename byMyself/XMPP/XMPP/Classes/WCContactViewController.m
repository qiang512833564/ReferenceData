//
//  WCContactViewController.m
//  XMPP
//
//  Created by lizhongqiang on 15/9/27.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "WCContactViewController.h"
#import "XMPPUserCoreDataStorageObject.h"
@interface WCContactViewController ()<NSFetchedResultsControllerDelegate>
{
    NSFetchedResultsController *_resultContrl;
}
//好友
@property (strong, nonatomic)NSArray *users;
@end

@implementation WCContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadUsers2];
}
- (void)loadUser1{
    //显示好友数据 （保存XMPPRoster.sqlite文件）
    //1.上下文 关联XMPPRoster.sqlite文件
    NSManagedObjectContext *rosterContext = [WCXMPPTool sharedWCXMPPTool].rosterStorage.mainThreadManagedObjectContext;
    
    //2.Request 请求查找哪张表
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPUserCoreDataStorageObject"];
    
    //设置排序
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"displayName" ascending:YES ];
    request.sortDescriptors = @[sort];
    
    //3.执行请求
    NSError *error = nil;
    NSArray *users = [rosterContext executeFetchRequest:request error:&error];
    WCLog(@"%@",users);
    _users = users;
}
#pragma mark 加载好友数据方法2
- (void)loadUsers2{
    //显示好友数据 （保存XMPPRoster.sqlite文件）
    //1.上下文 关联XMPPRoster.sqlite文件
    NSManagedObjectContext *rosterContext = [WCXMPPTool sharedWCXMPPTool].rosterStorage.mainThreadManagedObjectContext;
    
    //2.Request 请求查找哪张表
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPUserCoreDataStorageObject"];
    
    //设置排序
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"displayName" ascending:YES ];
    request.sortDescriptors = @[sort];
    
    //3.执行请求
    _resultContrl = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:rosterContext sectionNameKeyPath:nil cacheName:nil];
    _resultContrl.delegate = self;
    NSError *err = nil;
    //
    if([_resultContrl performFetch:&err])
    {
        
    }else
    {
        WCLog(@"%@",err);
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -NSFetchedResultsController代理方法
//数据库内容改变
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //return _users.count;
    return _resultContrl.fetchedObjects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"ContactCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // Configure the cell...
    //获取对应的好友
    XMPPUserCoreDataStorageObject *user = _resultContrl.fetchedObjects[indexPath.row];
    cell.textLabel.text = user.displayName;
    //1.通过KVO来监听用户状态
//    [user addObserver:self forKeyPath:@"sectionNum" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    //标识用户是否在线
    //0:在线 1:离开  2:离线
    WCLog(@"%@:在线状态%@",user.displayName,user.sectionNum);
    switch ([user.sectionNum integerValue]) {
        case 0:
            cell.detailTextLabel.text = @"在线";
            break;
        case 1:
            cell.detailTextLabel.text =@"离开";
            break;
        case 2:
            cell.detailTextLabel.text =@"离线";
            break;
        default:
            cell.detailTextLabel.text =@"未知";
            break;
    }
    return cell;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //之所以在这里可以直接刷新，是因为虽然_users数据源只赋值一次，但是它是指针，指向的地址里面存的值，是可以改变的
    [self.tableView reloadData];
//    XMPPUserCoreDataStorageObject *user = (XMPPUserCoreDataStorageObject *)object;
//    NSInteger num = [_users indexOfObject:user];
//    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:num inSection:0]];
//    NSLog(@"%@--%ld",user.sectionNum,num);
//    switch ([user.sectionNum integerValue]) {
//        case 0:
//            cell.detailTextLabel.text = @"在线";
//            break;
//        case 1:
//            cell.detailTextLabel.text =@"离开";
//            break;
//        case 2:
//            cell.detailTextLabel.text =@"离线";
//            break;
//        default:
//            cell.detailTextLabel.text =@"未知";
//            break;
//    }
//    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:num inSection:0]] withRowAnimation:UITableViewRowAnimationMiddle];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
