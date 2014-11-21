//
//  WXContactsViewController.m
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-21.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import "WXContactsViewController.h"
#import "AppDelegate.h"

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
    NSManagedObjectContext *context = xmppDelegate.rosterStorage.mainThreadManagedObjectContext;
    
    // 创建查询请求【要查哪张表】
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPUserCoreDataStorageObject"];
    
    // 设置过滤条件，找谁的好友，有可能多个用户登录
    NSString *userJid = [WXUserInfo sharedWXUserInfo].userJid;
    //WXLog(@"%@",userJid);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@",userJid];
    request.predicate = predicate;
    
    // 设置排序
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"nickname" ascending:YES];
    request.sortDescriptors = @[sort];
    
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
    
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _resultsContrl.fetchedObjects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"Friend";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    XMPPUserCoreDataStorageObject *friend = _resultsContrl.fetchedObjects[indexPath.row];
    // 有昵称用昵称，没有使用账号
    if (friend.nickname) {
        cell.textLabel.text = friend.nickname;
    }else{
        cell.textLabel.text = friend.jid.user;
    }
    
    
    return cell;
}

@end
