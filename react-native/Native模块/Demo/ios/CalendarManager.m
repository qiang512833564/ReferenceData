//
//  CalendarManager.m
//  Demo
//
//  Created by lizhongqiang on 15/9/30.
//  Copyright (c) 2015年 Facebook. All rights reserved.
//

#import "CalendarManager.h"
#import "RCTConvert+StatusBarAnimation.h"

@implementation CalendarManager

@synthesize bridge=_bridge;

RCT_EXPORT_MODULE();
//date:(NSDate *)date
RCT_EXPORT_METHOD(addEventWithName:(NSString *)name location:(NSString *)location date:(NSDate *)date){
  //RCT_EXPORT_METHOD();
  //CalendarManager *manager = [[CalendarManager alloc]init];
  //[manager printfTest];
  RCTLogInfo(@"Rretending to create an event %@ at %@ at time%@",name,location,date);
}
- (void)printfTest{
  NSLog(@"这是一个测试");
}

RCT_EXPORT_METHOD(addEventWithDateFromString:(NSString *)ISO8601DateString)
{
  NSDate *date = [RCTConvert NSDate:ISO8601DateString];
  RCTLogInfo(@"stringToDate:%@",date);
}
RCT_EXPORT_METHOD(addEvent:(NSString *)name details:(NSDictionary *)details)
{
  RCTLogInfo(@"name:%@----dictionary:%@",name,details);
}

#pragma mark ------ 回调函数 ---------

RCT_EXPORT_METHOD(findEvents:(RCTResponseSenderBlock)callback)
{
  NSArray *events = @[@(1),@(2),@(3),@(4)];
/*
 这里的callback是block函数实现部分的调用
 */
  callback(@[[NSNull null],events]);//这个数据就是返回的值
  /*提示：
   callback仅仅只能被调用一次
   这里的callback可以不直接调用，
   可以先存储着，以后调用，例子：RCTAlertManager.h
   */
}

#pragma mark ---Threading
//methodQueue方法，当模块被初始化完成的时候，就会被调用。
#if 0
- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}
#endif
#if 0
//如果该模块，调用了该方法，则，该模块的代码操作执行，全部是在该方法返回的队列里执行
- (dispatch_queue_t)methodQueue
{
  return dispatch_queue_create("com.facebook.React.AsyncLocalStorageQueue", DISPATCH_QUEUE_SERIAL);
}
//如果，仅仅只需要一部分繁琐的代码在独立的线程执行，则不需要调用上面的methodQueue方法
#endif
RCT_EXPORT_METHOD(doSomethingExpensive:(NSString *)param callback:(RCTResponseSenderBlock)callback)
{
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    RCTLogInfo(@"%s",__func__);
  });
}

#pragma mark --- 向外暴露的参数
//注意：
/*
 下面的方法的参数，仅仅只在初始化的时候对外暴露
 因此，你如果想在运行的时候去改变这些参数，是不会起作用的
 */
#if 0
- (NSDictionary *)constantsToExport{
  return @{@"firstDayOfTheWeek":@"Monday"};
}
#endif

#pragma mark --- 枚举参数Enum Constants----注意要想把枚举类型暴露给js,必须在RCTConvert的类扩展文件里实现RCT_ENUM_CONVERTER方法
- (NSDictionary *)constantsToExport
{
  return @{@"statusBarAnimationNone":@(MyStatusBarAnimationNone),
           @"statusBarAnimationFade" : @(MyStatusBarAnimationFade),
           @"statusBarAnimationSlide" : @(MyStatusBarAnimationSlide)
           };
}
RCT_EXPORT_METHOD(updateStatusBarAnimation:(MyStatusBarAnimation)animation
                  completion:(RCTResponseSenderBlock)callback)
{
  RCTLogInfo(@"animation:%ld----",animation);
}
- (instancetype)init
{
  if(self = [super init])
  {
    NSLog(@"/n----初始化%s-----/n",__func__);
  }
  return self;
}
#pragma mark  ------   添加事件---------
RCT_EXPORT_METHOD(addEventDelay:(int)timer)
{
  //
  sleep(timer);
  [self eventAction];
}
- (void)eventAction
{
#pragma mark --- 相当于往事件中心发送消息
  [self.bridge.eventDispatcher sendAppEventWithName:@"Demo" body:@{@"name":@"lucy----"}];
}
@end
