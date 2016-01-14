//
//  AppDelegate.m
//  CoreData数据库
//
//  Created by lizhongqiang on 15/9/2.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "Person.h"
#import "Card.h"
#import "SubCard.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

/*
 关系 (Relationships)----y也就是所谓的表之间的关系（一个对象就是一个表）
 实体间的关系应该总是被定义成双向的。这给予了 Core Data 足够的信息为我们全面管理类图。尽管定义双向的关系不是一个硬性要求，但我还是强烈建议这么去做。
 
 如果你对实体之间的关系很了解，你也能将实体定义成单向的关系，Core Data 不会有任何警告。但是一旦这么做了，你就必须承担很多正常情况理应由 Core Data 管理的一些职责，包括确认图形对象的一致性，变化跟踪和撤销管理。举一个简单的例子，我们有“书”和“作者”两个实体，并设置了一个书到作者的单项关系。当我们删除了“作者”的时候，和这个“作者”有关联的“书”将无法收到这个“作者”被删除的消息。此后，我们仍旧可以使用这本书“作者”的关系，只是我们将会得到一个指向空的错误。
 
 很明显单向关系带来的弊端绝对不会是你想要的。双向关系化可以让你摆脱这些不必要的麻烦。
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 从应用程序包中加载模型文件
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    // 传入模型对象，初始化NSPersistentStoreCoordinator
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    // 构建SQLite数据库文件的路径
    NSString *docs = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents"];
    NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"person.data"]];
    NSError *error = nil;
#if 0
    NSArray *contents = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:docs error:&error];
    //获取目录Documents下所有的文件名称
    [contents enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [[NSFileManager defaultManager]removeItemAtPath:[docs stringByAppendingPathComponent:obj] error:nil];
    }];//对所有文件进行删除操作
#endif
    // 添加持久化存储库，这里使用SQLite作为存储库
    
    NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if(store == nil)
    {
        [NSException raise:@"添加数据库失败" format:@"%@",[error localizedDescription]];
    }else
    {
        NSLog(@"添加数据库成功");
    }
    // 初始化上下文，设置persistentStoreCoordinator属性
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc]init];
    context.persistentStoreCoordinator = psc;
    
#pragma mark --- 添加数据到数据库
    NSManagedObject *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
    
    [person setValue:@"MJ" forKey:@"name"];
    [person setValue:[NSNumber numberWithInt:27] forKey:@"age"];
    
    NSManagedObject *card = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:context];
    [card setValue:@"444444444444" forKey:@"no"];
    
    
    NSManagedObject *subCard = [NSEntityDescription insertNewObjectForEntityForName:@"SubCard" inManagedObjectContext:context];
    [subCard setValue:@"123456789" forKey:@"number"];
    [card  setValue:subCard forKey:@"subCard"];
    [person setValue:card forKey:@"card"];
    NSError *insertError = nil;
    BOOL success = [context save:&error];
    
    if(!success)
    {
        [NSException raise:@"访问数据库错误" format:@"%@",[insertError localizedDescription]];
    }else
    {
//        [NSException raise:@"访问数据成功" format:@""];
        NSLog(@"访问数据库成功");
    }
#if 1
#pragma mark  从数据库中查询数据
    NSFetchRequest *request = [[NSFetchRequest alloc]init];//请求数据
    request.entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
    request.sortDescriptors = [NSArray arrayWithObject:sort];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@",@"MJ"];
    request.predicate = predicate;
    
    NSError *findError = nil;
    NSArray *objs = [context executeFetchRequest:request error:&findError];
    if(findError)
    {
        [NSException raise:@"查询错误" format:@"%@",[error localizedDescription]];
    }
    // 遍历数据
    for (NSManagedObject *obj in objs)
    {
        NSLog(@"name=%@", [[obj valueForKey:@"card"]subCard]);
    }
#pragma mark -----从person对象中查询子对象card
    predicate = [NSPredicate predicateWithFormat:@"(name like %@)AND(card.no like %@)",@"MJ",@"444444444444"];
    NSError *finderError = nil;
    NSArray *array = [context executeFetchRequest:request error:&finderError];
    if(finderError)
    {
        [NSException raise:@"查询错误" format:@"%@",[error localizedDescription]];
    }
    // 遍历数据
    for (NSManagedObject *obj in array)
    {
        NSLog(@"no=%@", [[obj valueForKey:@"card"] no]);
    }
#pragma mark ----从person对象中的card对象查询子对象（三阶关系）
    predicate = [NSPredicate predicateWithFormat:@"(name like %@)AND(card.subCard.number like %@)",@"mj",@"123456789"];
    request.predicate = predicate;
    NSError *threeFinderError = nil;
    NSArray *arr = [context executeFetchRequest:request error:&threeFinderError];
    if(threeFinderError)
    {
        [NSException raise:@"三阶查询出错" format:@"%@",[threeFinderError localizedDescription]];
    }
    for (NSManagedObject *obj in arr) {
        NSLog(@"subCard = %@",[[[obj valueForKey:@"card"] subCard]number]);
    }
#endif
#if 0
#pragma mark "删除数据库中的数据"----一般是先从数据库中查询是否存在该数据，然后查询之后获得NSManagedObject对象，再对其进行删除---从而达到删除数据的目的
    // 传入上下文，创建一个Person实体对象
    [objs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [context deleteObject:obj];
        NSError *deleteError = nil;
        [context save:&deleteError];
        if(deleteError)
        {
            [NSException raise:@"删除错误" format:@"%@",[deleteError localizedDescription]];
        }
        else
        {
            NSLog(@"删除数据成功");
        }
    }];
//    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
//    [managedObject setValue:@"MJ" forKey:@"name"];
//    [managedObject setValue:[NSNumber numberWithInt:27] forKey:@"age"];
#endif

#if 1
#pragma mark ----更新数据
    NSPredicate *updatePredicate = [NSPredicate predicateWithFormat:@"name like %@",@"MJ"];
    request.entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    request.predicate = updatePredicate;
    
    NSError *updateError = nil;
    NSArray *updateResult = [context executeFetchRequest:request error:&error];
    for(Person *new in updateResult)
    {
        new.name = @"mj";
    }
    //保存
    if ([context save:&updateError]) {
        //更新成功
        NSLog(@"更新成功");
    }

    
#pragma mark  从数据库中查询数据
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name like %@",@"mj"];
    request.predicate = pre;
    objs = [context executeFetchRequest:request error:&findError];
    if(findError)
    {
        [NSException raise:@"查询错误" format:@"%@",[error localizedDescription]];
    }
    // 遍历数据
    for (NSManagedObject *obj in objs)
    {
        NSLog(@"name=%@", [obj valueForKey:@"name"]);
    }
#endif
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
