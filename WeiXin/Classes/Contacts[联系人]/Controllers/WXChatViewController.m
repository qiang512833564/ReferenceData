//
//  WXChatViewController.m
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-21.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import "WXChatViewController.h"
#import "WXInputView.h"

#define InputViewH 50 //输入框调度
#define FunctionViewH 200 //功能框高度

@interface WXChatViewController()<UITextViewDelegate>

@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,weak)WXInputView *inputView;
@end

@implementation WXChatViewController


-(void)viewDidLoad{
    [super viewDidLoad];
   
    self.title = @"xxx";
    [self setupView];
    
    // 键盘监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbFrmWillShow:) name:UIKeyboardWillShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbFrmWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)kbFrmWillShow:(NSNotification *)notifi{
    CGRect kbBounds = [notifi.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardH = kbBounds.size.height;
    
    // iphone
    if (iSiPhoneDevice) {
        // 默认就是ipone设置
    }else{
        if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)){
            keyboardH = kbBounds.size.height;
        }else{
            keyboardH = kbBounds.size.width;
        }
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.view.y = -keyboardH;
    }];
}

-(void)kbFrmWillHide:(NSNotification *)notifi{
    [UIView animateWithDuration:0.25 animations:^{
        self.view.y = 0;
    }];
}

-(void)setupView{
    // 表格

    UITableView *tableView = [[UITableView alloc] init];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    tableView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    // 输入框
    WXInputView *inputView = [WXInputView inputView] ;
    inputView.backgroundColor = [UIColor redColor];
    inputView.translatesAutoresizingMaskIntoConstraints = NO;
    inputView.msgTextView.delegate = self;
    [self.view addSubview:inputView];
    
  
    // 表情与功能选择
    UIView *functionView = [[UIView alloc] init];
    [self.view addSubview:functionView];
    
    NSDictionary *views = @{@"tableView":tableView,@"inputView":inputView,@"functionView":functionView};
    
    // 表格的的水平约束
    NSArray *tableViewHConst = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tableView]-0-|" options:0 metrics:nil views:views];
    [self.view addConstraints:tableViewHConst];
    
    // 输入框的水平约束
    NSArray *inputViewHConst = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[inputView]-0-|" options:0 metrics:nil views:views];
    [self.view addConstraints:inputViewHConst];
    
    // 垂直约束
    NSArray *vConst = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[tableView]-0-[inputView(50)]-0-|" options:0 metrics:nil views:views];
    [self.view addConstraints:vConst];
    
    
}

-(void)textViewDidChange:(UITextView *)textView{
    
    NSLog(@"%@",NSStringFromCGSize(textView.contentSize));
    textView.bounds = CGRectMake(0, 0, textView.contentSize.width, textView.contentSize.height);
    self.inputView.bounds = CGRectMake(0, 0, textView.contentSize.width, textView.contentSize.height + 10);
    [self.view layoutIfNeeded];
    // 换行
    if ([textView.text rangeOfString:@"\n"].length != 0) {
         //WXLog(@"--%d",[textView.text rangeOfString:@"\n"].location);
        
        // 去除换行
       NSString *msg = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
        // 发送
        [self sendMsg:msg];
        
        textView.text = nil;
        
    }
    
}



-(void)sendMsg:(NSString *)msg{
    WXLog(@"%@ %d",msg,msg.length);
}
@end
