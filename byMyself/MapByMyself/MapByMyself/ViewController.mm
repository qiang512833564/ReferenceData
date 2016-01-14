//
//  ViewController.m
//  MapByMyself
//
//  Created by lizhongqiang on 15/7/24.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"
#import "SearchViewController.h"

@interface RouteAnnotation : BMKPointAnnotation
{
    int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
    int _degree;
}

@property (nonatomic) int type;
@property (nonatomic) int degree;
@end

@implementation RouteAnnotation

@synthesize type = _type;
@synthesize degree = _degree;
@end


@interface ViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKRouteSearchDelegate,BMKPoiSearchDelegate>
@property (nonatomic, strong)BMKMapView *mapView;
@property (nonatomic, strong)BMKLocationService *locService;
@property (nonatomic, strong)BMKRouteSearch *routeSearch;
@property (nonatomic ,strong)BMKPoiSearch *poiSearch;//检索地点-----检索周边BMKNearbySearchOption
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyBest];
    [BMKLocationService setLocationDistanceFilter:10.f];//指定定位的最小更新距离(米)
    
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    
    [_locService startUserLocationService];
    
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    
    UIButton *roadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [roadBtn setTitle:@"路线" forState:UIControlStateNormal];
    roadBtn.backgroundColor = [UIColor blueColor];
    [roadBtn addTarget:self action:@selector(searchRoad:) forControlEvents:UIControlEventTouchUpInside];
    roadBtn.frame = CGRectMake(37, [UIScreen mainScreen].bounds.size.height - 67, 53, 20);
    [self.view addSubview:roadBtn];
    
    UIButton *searchTextfield = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchTextfield setTitle:@"搜索" forState:UIControlStateNormal];
    [self.view addSubview:searchTextfield];
    searchTextfield.backgroundColor = [UIColor redColor];
    [searchTextfield addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    searchTextfield.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 53 - 37, roadBtn.frame.origin.y, 53, 20);
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(searchLocation:) name:@"searchLocation" object:nil];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)searchLocation:(NSNotification *)notification
{
    BMKPlanNode *planNode = (BMKPlanNode *)notification.object;
    
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.city = planNode.cityName;
    citySearchOption.keyword = planNode.name;
    
    [self.poiSearch poiSearchInCity:citySearchOption];
}
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode
{
    BMKPoiInfo *info = (BMKPoiInfo *)poiResult.poiInfoList[0];
    
    RouteAnnotation* item = [[RouteAnnotation alloc]init];
    item.coordinate = [poiResult.poiInfoList[0] pt];
    item.title = [info address];
    item.type = 1;
    [_mapView addAnnotation:item]; // 添加起点标注

    _mapView.centerCoordinate = item.coordinate;
}
- (BMKPoiSearch *)poiSearch
{
    if(_poiSearch == nil)
    {
        _poiSearch = [[BMKPoiSearch alloc]init];
        _poiSearch.delegate = self;
    }
    return _poiSearch;
}
- (void)searchAction
{
    [self.navigationController pushViewController:[[SearchViewController alloc]init] animated:YES];
}
- (void)searchRoad:(UIButton *)btn
{
    _routeSearch = [[BMKRouteSearch alloc]init];
    _routeSearch.delegate = self;
    
    BMKPlanNode *start = [[BMKPlanNode alloc]init];
    start.name = @"三林路";
    BMKPlanNode *end = [[BMKPlanNode alloc]init];
    end.name = @"宝山区博济智汇园";
    
    BMKTransitRoutePlanOption *transitRouteSearchOption = [[BMKTransitRoutePlanOption alloc]init];
    transitRouteSearchOption.city = @"上海";
    transitRouteSearchOption.from = start;
    transitRouteSearchOption.to = end;
    BOOL flag = [_routeSearch transitSearch:transitRouteSearchOption];
    
    if(flag)
    {
        NSLog(@"检索发送成功");
        
        
    }else
    {
        NSLog(@"检索发送失败");
    }
}

//要想画出路线，必须实现下面的代理方法
//BMKMapViewDelegate
- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}
- (void)onGetTransitRouteResult:(BMKRouteSearch *)searcher result:(BMKTransitRouteResult *)result errorCode:(BMKSearchErrorCode)error
{
#if 1
    NSLog(@"%@",result);
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if(error == BMK_SEARCH_NO_ERROR)
    {
        BMKTransitRouteLine *plan = (BMKTransitRouteLine *)[result.routes objectAtIndex:0];
        int size = (int)[plan.steps count];
        int planPointCounts = 0;
        for(int i=0; i<size; i++)
        {
            BMKTransitStep *transitStep = [plan.steps objectAtIndex:i];
            if(i == 0)
            {
                RouteAnnotation *item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item];
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            RouteAnnotation *item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.instruction;
            item.type = 3;
            [_mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        
        //路线轨迹点
        BMKMapPoint *temppoints = new BMKMapPoint[planPointCounts];
        int i=0;
        for(int j=0 ; j<size; j++)
        {
            BMKTransitStep *transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0; k<transitStep.pointsCount; k++)
            {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
        }
        BMKPolyline *polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine];//添加路线覆盖
        
        delete [] temppoints;
        
        [self mapViewFitPolyLine:polyLine];
    }
#endif
   

}
//根据polyline设置地图范围,让路线尽可能的显示全在地图上
- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
    CGFloat ltX, ltY, rbX, rbY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        if (pt.x < ltX) {
            ltX = pt.x;
        }
        if (pt.x > rbX) {
            rbX = pt.x;
        }
        if (pt.y > ltY) {
            ltY = pt.y;
        }
        if (pt.y < rbY) {
            rbY = pt.y;
        }
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(ltX , ltY);
    rect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    [_mapView setVisibleMapRect:rect];
    _mapView.zoomLevel = _mapView.zoomLevel - 0.3;
}
- (void)loadView
{
    [super loadView];
    _mapView = [[BMKMapView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.view addSubview: _mapView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = userLocation.location.coordinate.latitude;
    coor.longitude = userLocation.location.coordinate.longitude;
    annotation.coordinate = coor;
    annotation.title =  @"这里是上海";
   [_mapView addAnnotation:annotation];
    
    
    BMKCoordinateRegion region = BMKCoordinateRegionMake(coor, BMKCoordinateSpanMake(0, 0));
    [_mapView updateLocationData:userLocation];//需要调用该代码，才能调出定位图标
    //_mapView.region = region;//该属性是，确定当前地图显示的范围//[_mapView regionThatFits:region];
    [_mapView setRegion:region animated:YES];//动态显示，会从大到小缩放到位置
    _mapView.centerCoordinate = coor;
    //[_mapView setCenterCoordinate:coor animated:YES];
    _mapView.zoomLevel = 13;//地图比例尺级别，也可以当做设置缩放比例，
    _mapView.showMapScaleBar = YES;//显示比例尺
    [_mapView mapForceRefresh];//强制刷新
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
//        BMKAnnotationView *anno = [[BMKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
//        anno.frame = CGRectMake(0, 0, 100, 100);
//        anno.alpha = 0.2;
//        anno.backgroundColor = [UIColor redColor];
//        return anno;
        
        AnnotationView *newAnnotationView = [[AnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        
       [newAnnotationView setSelected:YES];
        newAnnotationView.paopaoView.hidden = NO;
        //UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
       // newAnnotationView.paopaoView = [[BMKActionPaopaoView alloc]initWithCustomView:label];
        //label.text = @"text";
        //newAnnotationView.canShowCallout = NO;
        //newAnnotationView.enabled = YES;
        //newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        //newAnnotationView.animatesDrop = YES;//从上方垂直落下的动画,设置该标注点动画显示
        newAnnotationView.title =  @"welcome to beijing";
        
        return newAnnotationView;
        
    }
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
