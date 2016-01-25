//
//  HeadView.m
//  模仿“什么都值得买”app我的头视图
//
//  Created by lizhongqiang on 16/1/21.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "HeadView.h"
@interface HeadView ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    CGFloat _headY;
    CGFloat _speedHead;
    CGFloat _redY;
    CGFloat _speedRed;
}
@property (nonatomic, strong)UITableView *bgScrollView;
@property (nonatomic, strong)PersonalAvatar *person;
@property (nonatomic, strong)UIView *segmentCtrl;
@property (nonatomic ,strong)UIView *redLayer;
@end
@implementation HeadView
- (UITableView *)bgScrollView{
    if (_bgScrollView == nil) {
        _bgScrollView = [[UITableView alloc]initWithFrame:self.bounds];
        _bgScrollView.backgroundColor =  [UIColor clearColor];//;
        _bgScrollView.bounces = YES;
        _bgScrollView.dataSource = self;
        _bgScrollView.delegate = self;
        _bgScrollView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _bgScrollView.contentSize = _bgScrollView.bounds.size;
    }
    return _bgScrollView;
}
- (UIView *)segmentCtrl{
    if(_segmentCtrl == nil){
        _segmentCtrl = [[UIView alloc]initWithFrame:CGRectMake(0, 448/1.5, [UIScreen mainScreen].bounds.size.width, 439/2)];
        _segmentCtrl.backgroundColor = [UIColor whiteColor];
    }
    return _segmentCtrl;
}
- (UIView *)redLayer{
    if(_redLayer == nil){
        _redLayer = [UIView new];
        _redLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 133/1.6+45);
        _redLayer.backgroundColor = [UIColor colorWithRed:229/255.0 green:55/255.0 blue:62/255.0f alpha:1.0];
        _redY = CGRectGetHeight(_redLayer.frame);
    }
    return _redLayer;
}
- (PersonalAvatar *)person{
    if(_person == nil){
        _person = [[PersonalAvatar alloc]initWithFrame:CGRectZero];
    }
    return _person;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.person.frame = CGRectMake(0, _headY-_speedHead*scrollView.contentOffset.y, self.person.frame.size.width, self.person.frame.size.height);
    CGRect frame = self.redLayer.frame;
    frame.size.height = _redY - _speedRed*scrollView.contentOffset.y;
    self.redLayer.frame = frame;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
        [self addSubview:self.redLayer];
        [self addSubview:self.bgScrollView];
        //UIView *headView = [[UIView alloc]init];
        [self addSubview:self.person];
        //headView.backgroundColor = [UIColor yellowColor];
        //headView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CGRectGetMaxY(self.person.frame));
        //self.bgScrollView.tableHeaderView = headView;
        //[self.bgScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        _headY = CGRectGetMinY(self.person.frame);
        _speedHead = 0.25;
        _speedRed = 0.2;
    }
    return self;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    UIScrollView *scrollView = (UIScrollView *)object;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellId = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
@end
@interface PersonalAvatar()<UIGestureRecognizerDelegate>

@end
@implementation PersonalAvatar
- (UIImageView *)headImageView{
    if(_headImageView == nil){
        CGFloat width = CGRectGetWidth(self.frame);
        CGFloat radius = 45;
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(width/2.0-radius, 0, radius*2, radius*2)];
        _headImageView.backgroundColor = [UIColor blackColor];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.image = [UIImage imageNamed:@"head12"];
        _headImageView.layer.cornerRadius = radius;
        _headImageView.layer.masksToBounds = YES;
        _headImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hitHeadImageViewAction)];
        tap.delegate = self;
        [_headImageView addGestureRecognizer:tap];
    }
    return _headImageView;
}
- (void)hitHeadImageViewAction{
    NSLog(@"%s",__func__);
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 133/1.6, [UIScreen mainScreen].bounds.size.width, 200);
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = getPath(self.frame).CGPath;
        //shapeLayer.backgroundColor = [UIColor purpleColor].CGColor;
        shapeLayer.strokeColor = [UIColor yellowColor].CGColor;
        shapeLayer.lineWidth = 2;
        //[self.layer addSublayer:shapeLayer];
        self.layer.mask = shapeLayer;
        
        [self addSubview:self.headImageView];
    }
    return self;
}
UIBezierPath* getPath(CGRect frame){
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat width = CGRectGetWidth(frame);
    CGFloat height = CGRectGetHeight(frame);
    CGFloat radius = 45;
    CGPoint startPoint = CGPointMake(width/2.0, radius);
    [path moveToPoint:startPoint];
    [path addArcWithCenter:startPoint radius:radius startAngle:0 endAngle:M_PI clockwise:NO];
    [path addLineToPoint:CGPointMake(0, radius)];
    [path addLineToPoint:CGPointMake(0, height)];
    [path addLineToPoint:CGPointMake(width, height)];
    [path addLineToPoint:CGPointMake(width, radius)];
    [path addLineToPoint:CGPointMake(width/2.0+radius, radius)];
    return path;
}
#pragma mark - touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"B - touchesBeagan..");
    
    // 把事件传递下去给父View或包含他的ViewController
    [self.nextResponder touchesBegan:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"B - touchesCancelled..");
    // 把事件传递下去给父View或包含他的ViewController
    [self.nextResponder touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"B - touchesEnded..");
    // 把事件传递下去给父View或包含他的ViewController
    [self.nextResponder touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"B - touchesMoved..");
    // 把事件传递下去给父View或包含他的ViewController
    if ([self.nextResponder isKindOfClass:[HeadView class]]) {
        HeadView *view = (HeadView *)self.nextResponder;
        [self resignFirstResponder];
        //[self.nextResponder becomeFirstResponder];
        [view.bgScrollView becomeFirstResponder];
//
//        //[view.bgScrollView touchesBegan:touches withEvent:event];
//       // [view.bgScrollView touchesMoved:touches withEvent:event];
//       BOOL success =  [self resignFirstResponder];
//        BOOL first = [self.nextResponder becomeFirstResponder];
//        NSLog(@"%d-----%d",success,first);
       // view.bgScrollView.becomeFirstResponder = YES;
    }
    //[self.nextResponder touchesBegan:touches withEvent:event];
    
}
#if 1
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    //NSLog(@"%s\n%@",__func__,event);
    return [super pointInside:point withEvent:event];
}
#pragma mark ----- 这里消息的传递过程
//视图先调用，- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)even方法，然后再在hitTest方法内部去调用- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event方法，判断事件是否发生在其内部，不是则- - (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)even返回nil,
//若所有子视图的hitTest:withEvent:方法都返回nil，则当前视图的hitTest:withEvent:方法返回当前视图自身(self)
#pragma mark ----- 消息的处理过程则是：
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *eventView = [super hitTest:point withEvent:event];
    
    //NSLog(@"%@---envent-----%@",NSStringFromClass([eventView class]),event);
    if ([eventView isKindOfClass:[UIImageView class]]) {
            return eventView;
    }
    HeadView *headView = (HeadView *)self.superview;
    return headView.bgScrollView;
}
#endif
@end