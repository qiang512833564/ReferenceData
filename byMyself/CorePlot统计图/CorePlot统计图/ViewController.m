//
//  ViewController.m
//  CorePlot统计图
//
//  Created by lizhongqiang on 15/9/6.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"
#import <CorePlot-CocoaTouch.h>
@interface ViewController ()<CPTScatterPlotDataSource,CPTAxisDelegate>
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSMutableArray *dataForPlot;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    _dataArray = [NSMutableArray array];
    for(int i=0; i<10; i++)
    {
        [_dataArray addObject:[NSNumber numberWithInt:random()%20]];
    }
    
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    
    CGRect frame = CGRectMake(10, 50, 600, 300);
    //图形要放在一个 CPTGraphHostingView 中，CPTGraphHostingView 继承自 UIView
    CPTGraphHostingView *hostView = [[CPTGraphHostingView alloc]initWithFrame:frame];
    hostView.backgroundColor = [UIColor redColor];
    //hostView.collapsesLayers = YES;
    //scatterPlot.backgroundColor = [UIColor clearColor].CGColor;目前，发现两个都可以使scatterPlot变透明
    //把 CPTGraphHostingView 加到你自己的 View 中
    [self.view addSubview:hostView];

    //在 CPTGraph 中画图，这里的 CPTXYGraph 是个曲线图
    //要指定 CPTGraphHostingView 的 hostedGraph 属性来关联
    CPTXYGraph *graph = [[CPTXYGraph alloc]initWithFrame:frame];
    hostView.hostedGraph = graph;
    /*
     四边不留白
     */
    graph.paddingLeft = 0.f;
    graph.paddingRight = 0.f;
    graph.paddingTop = 0.f;
    graph.paddingBottom = 0.f;
    /*
     CPTPlotAreaFrame绘图区域设置
     下面是设置该区域距离边界多少空间
     坐标轴也是通过该方式显示
     */
    graph.plotAreaFrame.paddingLeft = CPTFloat(30);
    graph.plotAreaFrame.paddingRight = CPTFloat(25);
    graph.plotAreaFrame.paddingTop = CPTFloat(10);
    graph.plotAreaFrame.paddingBottom = CPTFloat(20);
    //边框样式设置，默认值：nil
    graph.plotAreaFrame.borderLineStyle = nil;
    
    graph.title = @"title";//设置标题
    //设置主题
    CPTTheme *theme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    /*
kCPTDarkGradientTheme, kCPTPlainBlackTheme, kCPTPlainWhiteTheme, kCPTSlateTheme,kCPTStocksTheme, 最后一种股票主题效果见上面的效果图
     */
   [graph applyTheme:theme];
#pragma mark ----- 设置字体样式
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.color = [CPTColor grayColor];
    textStyle.fontSize = 16.0f;
    
    //CPTScatterPlot是提供数据的类
    CPTScatterPlot *scatterPlot = [[CPTScatterPlot alloc]initWithFrame:CGRectMake(20, 20, CGRectGetWidth(graph.bounds)-2*20, CGRectGetHeight(graph.bounds)-2*20)];
    scatterPlot.plotArea.frame = CGRectMake(20, 20, CGRectGetWidth(graph.bounds)-2*20, CGRectGetHeight(graph.bounds)-2*20);
    [graph addPlot:scatterPlot];
    scatterPlot.backgroundColor = [UIColor clearColor].CGColor;
    scatterPlot.dataSource = self;
    graph.titleTextStyle = textStyle;
    graph.titleDisplacement = CGPointMake(0.0f, -20.0f);
    graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    
    
    
    // 设置一屏内可显示的x,y量度范围
    //location 值表示坐标起始值，一般可以设置元素中的最小值
    //length 值表示从起始值上浮多少，一般可以用最大值减去最小值的结果
    //其实我倒觉得，CPTPlotRange:(NSRange) range 好理解些，可以表示值从 0 到 20
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)scatterPlot.plotSpace;
    plotSpace.allowsUserInteraction = YES;//开启用户，是否允许
    [plotSpace setAllowsMomentumX:YES];
    plotSpace.allowsMomentumX = YES;
    plotSpace.allowsMomentumY = YES;
    plotSpace.allowsMomentum = YES;
    /*
     调整x,y的显示范围
     */
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromCGFloat(-3) length:CPTDecimalFromCGFloat([_dataArray count]-1)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromCGFloat(-10) length:CPTDecimalFromCGFloat(20)];
    /*
     设置最大显示范围
     */
    plotSpace.globalXRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromCGFloat(-3) length:CPTDecimalFromCGFloat([_dataArray count]-1)];
    plotSpace.globalYRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromCGFloat(-10) length:CPTDecimalFromCGFloat(20)];
    // 轴线样式
    CPTMutableLineStyle *axisLineStyle = [[CPTMutableLineStyle alloc] init];
    axisLineStyle.lineWidth = CPTFloat(1);
    axisLineStyle.miterLimit = 1;
    axisLineStyle.lineColor = [CPTColor redColor];
    //坐标系
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    axisSet.borderLineStyle = axisLineStyle;/////坐标系边框
    
    lineStyle.miterLimit = 1.0f;
    lineStyle.lineWidth = 2.0f;
    lineStyle.lineColor = [CPTColor blueColor];
    
    CPTXYAxis *x = axisSet.xAxis;
    x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
    x.majorIntervalLength = CPTDecimalFromString(@"2");//大刻度
    x.minorTicksPerInterval = 3;//两个大刻度之间的小刻度个数
    x.minorTickLineStyle = lineStyle;//小刻度样式
    lineStyle.lineColor = [CPTColor greenColor];
    //x.majorGridLineStyle = lineStyle;//-----设置分隔大刻度坐标的线---当不设置的时候不显示
    x.axisLineStyle = axisLineStyle;// 轴线设置
    x.majorTickLineStyle = axisLineStyle;//设置大标签的样式
    x.title = @"X轴";
    CPTMutableTextStyle *titelStyle = [CPTMutableTextStyle textStyle];
    titelStyle.color = [CPTColor redColor];
    titelStyle.fontSize = CPTFloat(20);
    x.titleTextStyle = titelStyle;
    x.titleLocation = CPTDecimalFromFloat(2);
    x.titleDirection = CPTSignNegative;
    titelStyle.fontSize = CPTFloat(11);
    x.labelTextStyle = titelStyle;
    x.timeOffset = CPTFloat(25);
    /*
     设置边框颜色
     */
    x.borderColor = [UIColor orangeColor].CGColor;
    x.borderWidth = 3.0f;
    x.cornerRadius = 0;
#if 0
    NSArray *exclusionRanges = [NSArray arrayWithObjects:[CPTPlotRange plotRangeWithLocation:CPTDecimalFromCGFloat(0.99) length:CPTDecimalFromCGFloat(0.02)],[CPTPlotRange plotRangeWithLocation:CPTDecimalFromCGFloat(2.99) length:CPTDecimalFromCGFloat(0.02)], nil];
    x.labelExclusionRanges = exclusionRanges;//------这个是去掉哪几个横坐标
#endif
    CPTXYAxis * y = axisSet.yAxis;
    y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0"); // 原点的 y 位置
    y.majorIntervalLength = CPTDecimalFromString(@"2");   // y轴主刻度：显示数字标签的量度间隔
    y.minorTicksPerInterval = 2;    // y轴细分刻度：每一个主刻度范围内显示细分刻度的个数
    y.minorTickLineStyle = lineStyle;
#if 0
    exclusionRanges = [NSArray arrayWithObjects:
                       [CPTPlotRange plotRangeWithLocation:CPTDecimalFromCGFloat(1.99) length:CPTDecimalFromCGFloat(0.02)],
                       [CPTPlotRange plotRangeWithLocation:CPTDecimalFromCGFloat(2.99) length:CPTDecimalFromCGFloat(0.02)],
                       nil];
    y.labelExclusionRanges = exclusionRanges;
#endif
    y.delegate = self;
    
    
    // Create a red-blue plot area
    //
    //lineStyle.miterLimit        = 100.0f;
    lineStyle.lineWidth         = 3.0f;
    lineStyle.lineColor         = [CPTColor blueColor];
#pragma mark ------------// 创建折线图CPTScatterPlot ----------
    CPTScatterPlot * boundLinePlot  = [[CPTScatterPlot alloc] init];
    boundLinePlot.dataLineStyle = nil;
    boundLinePlot.interpolation = CPTScatterPlotInterpolationCurved;
    boundLinePlot.identifier    = @"BLUE_PLOT_IDENTIFIER";
    boundLinePlot.dataSource    = self;
    
    // Do a red-blue gradient: 渐变色区域
    //
    CPTColor * blueColor        = [CPTColor colorWithComponentRed:0.3 green:0.3 blue:1.0 alpha:0.8];
    CPTColor * redColor         = [CPTColor colorWithComponentRed:1.0 green:0.3 blue:0.3 alpha:0.8];
    CPTGradient * areaGradient1 = [CPTGradient gradientWithBeginningColor:blueColor
                                                              endingColor:redColor];
    //渐变角度：垂直90度（逆时针）---表示从开始颜色到结束颜色，变化的方向
    areaGradient1.angle = -90.0f;//表示垂直向下渐变
    CPTFill * areaGradientFill  = [CPTFill fillWithGradient:areaGradient1];
    boundLinePlot.areaFill      = areaGradientFill;
    boundLinePlot.areaBaseValue = [[NSDecimalNumber numberWithFloat:0.0] decimalValue]; // 渐变色的起点位置(这里指的是Y坐标的位置)
    
    // Add plot symbols: 表示数值的符号的形状
    //
    CPTMutableLineStyle * symbolLineStyle = [CPTMutableLineStyle lineStyle];
    symbolLineStyle.lineColor = [CPTColor purpleColor];
    symbolLineStyle.lineWidth = 2.0;
    
    CPTPlotSymbol * plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    plotSymbol.fill          = [CPTFill fillWithColor:[CPTColor redColor]];
    plotSymbol.lineStyle     = symbolLineStyle;
    plotSymbol.size          = CGSizeMake(10.0, 10.0);
    boundLinePlot.plotSymbol = plotSymbol;
    
    [graph addPlot:boundLinePlot];
    
#pragma mark ----------- 画破折线-----
    /*
     这个lineStyle在下面是设置破折线的样式
     */
    lineStyle                = [CPTMutableLineStyle lineStyle];
    lineStyle.lineWidth      = 3.f;
    lineStyle.lineColor      = [CPTColor greenColor];
    lineStyle.dashPattern    = [NSArray arrayWithObjects:[NSNumber numberWithFloat:40.0f],[NSNumber numberWithFloat:10.0f],[NSNumber numberWithFloat:200.0f], nil];//---第一个number是线的长度，第二个是两个之间的距离--再往后加的话，第三个是线的长度，第四个线的距离，依次往下
    
    CPTScatterPlot * dataSourceLinePlot = [[CPTScatterPlot alloc] init];
    dataSourceLinePlot.dataLineStyle = lineStyle;
    dataSourceLinePlot.identifier = @"GREEN_PLOT_IDENTIFIER";
    dataSourceLinePlot.dataSource = self;
    
    // Put an area gradient under the plot above
    //
    CPTColor * areaColor            = [CPTColor colorWithComponentRed:0.3 green:1.0 blue:0.3 alpha:0.8];
    CPTGradient * areaGradient      = [CPTGradient gradientWithBeginningColor:areaColor
                                                                  endingColor:[CPTColor clearColor]];
    areaGradient.angle              = -90.0f;
    areaGradientFill                = [CPTFill fillWithGradient:areaGradient];
    dataSourceLinePlot.areaFill     = areaGradientFill;
    dataSourceLinePlot.areaBaseValue= CPTDecimalFromString(@"1.75");
    
    // Animate in the new plot: 淡入动画
    dataSourceLinePlot.opacity = 0.0f;
    
    CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeInAnimation.duration            = 5.0f;
    fadeInAnimation.removedOnCompletion = NO;
    fadeInAnimation.fillMode            = kCAFillModeForwards;
    fadeInAnimation.toValue             = [NSNumber numberWithFloat:1.0];
    [dataSourceLinePlot addAnimation:fadeInAnimation forKey:@"animateOpacity"];
    
    [graph addPlot:dataSourceLinePlot];
    
    _dataForPlot = [NSMutableArray arrayWithCapacity:10];
    NSUInteger i;
    for ( i = 0; i < 10; i++ ) {
        id x = [NSNumber numberWithFloat:0 + i];
        id y = [NSNumber numberWithInt:random()%20];
        [_dataForPlot addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:x, @"x", y, @"y", nil]];
    }

}
////询问有多少个数据，在 CPTPlotDataSource 中声明的
- (NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    if([plot.identifier isEqual:@"GREEN_PLOT_IDENTIFIER"]) return _dataForPlot.count;
    return _dataArray.count;
}
////询问一个个数据值，在 CPTPlotDataSource 中声明的
- (id)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)idx
{
    if([plot.identifier isEqual:@"GREEN_PLOT_IDENTIFIER"])
    {
        NSString * key = (fieldEnum == CPTScatterPlotFieldX ? @"x" : @"y");
        NSNumber * num = [[_dataForPlot objectAtIndex:idx] valueForKey:key];
        
        // Green plot gets shifted above the blu
            if (fieldEnum == CPTScatterPlotFieldY) {
                num = [NSNumber numberWithDouble:[num doubleValue] + 1.0];
            }
        
        return num;
    }
    if(fieldEnum == CPTScatterPlotFieldY)
    {
        return [_dataArray objectAtIndex:idx];
    }else
    {
        return [NSNumber numberWithInteger:idx];
    }
    
}
//想要用不同的颜色对 y 轴方向大于等于0和小于0的刻度标签进行区分，因此需要实现该协议方法：axis:shouldUpdateAxisLabelsAtLocations:。
//这里没有判断是x轴还是y轴，是因为仅仅设置了y的delegate而未设置x的delegate
//这里返回值是NO，因为这里的y轴是自定义的
- (BOOL)axis:(CPTAxis *)axis shouldUpdateAxisLabelsAtLocations:(NSSet *)locations
{
    static CPTTextStyle * positiveStyle = nil;
    static CPTTextStyle * negativeStyle = nil;
    
    NSNumberFormatter * formatter   = axis.labelFormatter;
    CGFloat labelOffset             = axis.labelOffset;
    NSDecimalNumber * zero          = [NSDecimalNumber zero];
    
    NSMutableSet * newLabels        = [NSMutableSet set];
    
    for (NSDecimalNumber * tickLocation in locations) {
        CPTTextStyle *theLabelTextStyle;
        
        if ([tickLocation isGreaterThanOrEqualTo:zero]) {
            if (!positiveStyle) {
                CPTMutableTextStyle * newStyle = [axis.labelTextStyle mutableCopy];
                newStyle.color = [CPTColor greenColor];
                positiveStyle  = newStyle;
            }
            
            theLabelTextStyle = positiveStyle;
        }
        else {
            if (!negativeStyle) {
                CPTMutableTextStyle * newStyle = [axis.labelTextStyle mutableCopy];
                newStyle.color = [CPTColor redColor];
                negativeStyle  = newStyle;
            }
            
            theLabelTextStyle = negativeStyle;
        }
        
        NSString * labelString      = [formatter stringForObjectValue:tickLocation];
        CPTTextLayer * newLabelLayer= [[CPTTextLayer alloc] initWithText:labelString style:theLabelTextStyle];
        CPTLayer *layer = [[CPTLayer alloc]initWithFrame:CGRectMake(0, 0, 20, 10)];
        layer.backgroundColor = [UIColor redColor].CGColor;
        CPTAxisLabel * newLabel     = [[CPTAxisLabel alloc] initWithContentLayer:newLabelLayer];
        newLabel.tickLocation       = tickLocation.decimalValue;
        newLabel.offset             = labelOffset;
        
        [newLabels addObject:newLabel];
    }
    
    axis.axisLabels = newLabels;
    
    return NO;
}
#pragma mark ----  标注节点上显示的文字------------
-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index
{
    if([plot.identifier isEqual:@"GREEN_PLOT_IDENTIFIER"]) return nil;
    CPTTextLayer *layer = [[CPTTextLayer alloc]initWithText:[NSString stringWithFormat:@"%@",_dataArray[index]]];
    
    return layer;
}
- (BOOL)shouldAutorotate
{
    return YES;
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
