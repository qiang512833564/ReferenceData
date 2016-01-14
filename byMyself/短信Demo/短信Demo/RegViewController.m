//
//  RegViewController.m
//  短信Demo
//
//  Created by lizhongqiang on 15/7/28.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "RegViewController.h"

@interface RegViewController ()
@property (nonatomic, strong)UILabel *leftAreaNumber;
@property (nonatomic, strong)UITextField *telephoneNumber;
@property (nonatomic, strong)UIView *bgView;
@end

@implementation RegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSetup];
}
- (void)initSetup
{
    [self.view addSubview:self.bgView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textfieldChange:) name:UIKeyboardWillShowNotification  object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textfieldChange:) name:UIKeyboardWillHideNotification  object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textfieldChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
//    //UIKeyboardDidChangeFrameNotification
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textfieldChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)textfieldChange:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCure;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCure];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]getValue:&keyboardEndFrame];
#if 0
  
#endif
  //  self.bgView.layer.frame = CGRectMake(0, keyboardEndFrame.origin.y - _bgView.frame.size.height, _bgView.bounds.size.width, _bgView.bounds.size.height);
#if 1
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCure];
    
    //adjust ChatTableView's height
    
    
    [self.view layoutIfNeeded];
    
    //adjust UUInputFunctionView's originPoint
    CGRect newFrame = _bgView.frame;
     newFrame.origin.y = keyboardEndFrame.origin.y - newFrame.size.height;
    _bgView.frame = newFrame;
    
    [UIView commitAnimations];
#endif
}
- (UIView *)bgView
{
    if(_bgView == nil)
    {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 49, [UIScreen mainScreen].bounds.size.width, 49)];
        _bgView.backgroundColor = [UIColor grayColor];
        [_bgView addSubview:self.leftAreaNumber];
        [_bgView addSubview:self.telephoneNumber];
    }
    return _bgView;
}
- (UILabel *)leftAreaNumber
{
    if(_leftAreaNumber == nil)
    {
        _leftAreaNumber = [[UILabel alloc]initWithFrame:CGRectMake(10, 4.5, 70, 40)];
        _leftAreaNumber.text = @"+86";
    }
    return _leftAreaNumber;
}
- (UITextField *)telephoneNumber
{
    if(_telephoneNumber == nil)
    {
        _telephoneNumber = [[UITextField alloc]initWithFrame:CGRectMake(90, 4.5, 150, 40)];
        _telephoneNumber.borderStyle = UITextBorderStyleRoundedRect;
        
    }
    return _telephoneNumber;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
