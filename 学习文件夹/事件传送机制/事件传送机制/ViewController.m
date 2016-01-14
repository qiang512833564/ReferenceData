//
//  ViewController.m
//  事件传送机制
//
//  Created by lizhongqiang on 15/12/11.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"
#import "SuperView.h"
#import "SubView.h"
#import "测试responder.h"
@interface ViewController ()
@property (nonatomic, strong)SuperView *superView;
@property (nonatomic, strong)UIButton *btn;
@property (nonatomic, strong)SubView *subView;
@property (nonatomic, strong)__responder* responder;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topAction)]];
    [self.view addSubview:self.btn];
    [self.view addSubview:self.superView];
    [self.superView addSubview:self.subView];
    [self.view addSubview:self.responder];
}
- (void)topAction{
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",[obj class]);
    }];
}
- (__responder *)responder{
    if(_responder == nil){
        _responder = [[__responder alloc]initWithFrame:CGRectMake(40, 300, 100, 100)];
        _responder.backgroundColor =[UIColor orangeColor];
    }
    return _responder;
}
- (UIButton *)btn{
    if(_btn == nil){
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(20, 40, 254, 250);
        _btn.backgroundColor = [UIColor yellowColor];
        [_btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}
- (SubView *)subView{
    if(_subView == nil){
        _subView = [[SubView alloc]init];
        _subView.frame = CGRectMake(60, 100, 100, 100);
        _subView.backgroundColor = [UIColor blueColor];
        _subView.userInteractionEnabled = NO;//UIView默认userInteractionEnabled为NO
    }
    return _subView;
}
- (SuperView *)superView
{
    if(_superView == nil){
        _superView = [[SuperView alloc]init];
        _superView.frame = CGRectMake(30, 60, 200, 200);
        _superView.backgroundColor = [UIColor purpleColor];
        _superView.userInteractionEnabled = YES;
        [_superView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)]];
    }
    return _superView;
}
- (void)btnAction:(UIButton*)btn{
    STLogResponderChain(btn);
}
- (void)tapAction:(UITapGestureRecognizer *)tap{
    NSLog(@"%s----",_cmd);//[_superView pointInside:[tap locationInView:_subView] withEvent:nil]
}
#pragma mark - 这样比较清晰，大家也会直观的看到nextResponder的查找过程。
void STLogResponderChain(UIResponder *responder) {
    NSLog(@"------------------The Responder Chain------------------");
    
    NSMutableString *spaces = [NSMutableString stringWithCapacity:4];
    while (responder) {
        NSLog(@"%@%@", spaces, responder.class);
        responder = responder.nextResponder;
        [spaces appendString:@"----"];
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
