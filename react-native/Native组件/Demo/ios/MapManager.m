//
//  MapManager.m
//  Demo
//
//  Created by lizhongqiang on 15/9/30.
//  Copyright (c) 2015年 Facebook. All rights reserved.
//

#import "MapManager.h"
#import <RCTMap.h>


/*
 native视图的创建和操作是由RCTViewManager子类实现的，就相当于viewController(它是由bridge创建的)
 这些RCTViewManager子类向RCTUIManager展示视图
 RCTUIManager的代理向RCTViewManager子类返回properties，去设置和更新视图
 RCTViewManagers向JS发送事件，是通过bridge实现的
 */
@implementation MapManager
RCT_EXPORT_MODULE()
//直接把视图的属性名字设置在这里作为对外的属性
RCT_EXPORT_VIEW_PROPERTY(pitchEnabled, BOOL)
RCT_EXPORT_VIEW_PROPERTY(zoomEnabled, BOOL)

//下面这个：可以在属性传过来的时候，自定义一些方法，使得属性设置的效果更明显等
RCT_CUSTOM_VIEW_PROPERTY(region, MKCoordinateRegion,RCTMap)//(name, type, viewClass)
{
  [view setRegion:json ? [RCTConvert MKCoordinateRegion:json] : defaultView.region animated:YES];
}
- (UIView *)view
{
  NSLog(@"初始化--%s--",__FUNCTION__);
  return [[RCTMap alloc]init];
}
- (UIView *)viewWithProps:(NSDictionary *)props
{
  NSLog(@"传参数----%@----",props);
  return [super viewWithProps:props];
}

@end
#if 0
@implementation RCTConvert (CoreLocation)
RCT_CONVERTER(CLLocationDegrees, CLLocationDegrees, doubleValue);//RCT_CONVERTER(type(目标类型), name(方法名称), getter(方法名称-如果名称是个doubleValue就也可代表该方法返回的是doubleValue类型))
RCT_CONVERTER(CLLocationDistance, CLLocationDistance, doubleValue);

+ (CLLocationCoordinate2D)CLLocationCoordinate2D:(id)json
{
  json = [self NSDictionary:json];
  return (CLLocationCoordinate2D){
    [self CLLocationDegrees:json[@"latitude"]],
    [self CLLocationDegrees:json[@"longitude"]]
  };
}

@end
#endif