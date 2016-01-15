//
//  WXContactsViewController.m
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-21.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import "WXContactsViewController.h"
#import "AppDelegate.h"
#import "WXChatViewController.h"
#import "WXContactCell.h"

@interface WXContactsViewController ()<NSFetchedResultsControllerDelegate>{
    NSFetchedResultsController *_resultsContrl;
}

@end

@implementation WXContactsViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self loadFriends];
}

-(void)loadFriends{
    if ([WXXMPPTools sharedWXXMPPTools].rosterStorage == nil) {
        return;
    }
    NSManagedObjectContext *context = [WXXMPPTools sharedWXXMPPTools].rosterStorage.mainThreadManagedObjectContext;
    
    // 创建查询请求【要查哪张表】
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPUserCoreDataStorageObject"];
    
    // 设置过滤条件，找谁的好友，有可能多个用户登录
    NSString *userJid = [WXUserInfo sharedWXUserInfo].userJid;
    //WXLog(@"%@",userJid);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@ AND (subscription contains %@)",userJid,@"both"];
   // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"subscription contains %@",@"both"];
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@",userJid];
    request.predicate = predicate;
    
    // 设置排序
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"nickname" ascending:YES];
    NSSortDescriptor *sectionNumSort = [NSSortDescriptor sortDescriptorWithKey:@"sectionNum" ascending:YES];
    request.sortDescriptors = @[sectionNumSort,sort];
    
    _resultsContrl = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    _resultsContrl.delegate = self;
    
    // 执行查询
    NSError *error = nil;
    [_resultsContrl performFetch:&error];
    if (error) {
        WXLog(@"%@",error);
    }
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    NSLog(@"%s",__FUNCTION__);
    [self.tableView reloadData];
}
-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    NSLog(@"%s",__FUNCTION__);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _resultsContrl.fetchedObjects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    WXContactCell *cell = [WXContactCell contactCellWithTableView:tableView];
    
    XMPPUserCoreDataStorageObject *friend = _resultsContrl.fetchedObjects[indexPath.row];
    cell.mFriend = friend;
    if (friend.photo) {
        cell.headView.image = friend.photo;
    }else{
        NSData *data = [[WXXMPPTools sharedWXXMPPTools].vCardAvatarModule photoDataForJID:friend.jid];
        if (data) {
            cell.headView.image = [UIImage imageWithData:data];
        }else{
            cell.headView.image = [UIImage imageNamed:@"login_defaultAvatar"];
        }
    }
    return cell;
}

#pragma mark 删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 删除好友
        XMPPUserCoreDataStorageObject *friend = _resultsContrl.fetchedObjects[indexPath.row];
        [[WXXMPPTools sharedWXXMPPTools].roster removeUser:friend.jid];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WXChatViewController *chatVc = [[WXChatViewController alloc] init];
    XMPPUserCoreDataStorageObject *friend = _resultsContrl.fetchedObjects[indexPath.row];
    // 传递好友的jid
    chatVc.friendJid = friend.jid;
    
    
    [self.navigationController pushViewController:chatVc animated:YES];
}



@end
