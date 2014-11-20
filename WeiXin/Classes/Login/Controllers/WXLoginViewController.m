//
//  WXLoginViewController.m
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-18.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import "WXLoginViewController.h"
#import "CategoryWF.h"

@interface WXLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIView *loginContainer;


@end

@implementation WXLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置密码输入框的样式
    [self setupPwdFieldStyle];
   
}

-(void)setupPwdFieldStyle{
    // 设置输入框的背景图片
    self.pwdField.background = [UIImage stretchedImageWithName:@"operationbox_text"];
    
    // 密码输入框左边图片
    UIImageView *lockIv = [[UIImageView alloc] init];
    
    // 设置尺寸
    CGRect imageBound = self.pwdField.bounds;
    // 宽度高度一样
    imageBound.size.width = imageBound.size.height;
    lockIv.bounds = imageBound;

    // 设置图片
    lockIv.image = [UIImage imageNamed:@"Card_Lock"];
    
    // 设置图片居中显示
    lockIv.contentMode = UIViewContentModeCenter;
    
    // 添加TextFiled的左边视图
    self.pwdField.leftView = lockIv;
    
    // 设置TextField左边的总是显示
    self.pwdField.leftViewMode = UITextFieldViewModeAlways;
    
  

}

- (IBAction)textChange:(UITextField *)sender {
    
    //登录按钮的禁用
    self.loginBtn.enabled = (self.pwdField.text > 0);
    
}
- (IBAction)panView:(UIPanGestureRecognizer *)pan{
    
    if(pan.state == UIGestureRecognizerStateEnded ||
             pan.state == UIGestureRecognizerStateCancelled){
        [UIView animateWithDuration:0.25 animations:^{
            self.loginContainer.transform = CGAffineTransformIdentity;
        }];
    }else{
        CGFloat transY =  [pan translationInView:pan.view].y * 0.5;
        self.loginContainer.transform = CGAffineTransformTranslate(self.loginContainer.transform, 0, transY);
    }
    
    
    //清除
    [pan setTranslation:CGPointZero inView:pan.view];
    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)dealloc{
    WXLog(@"xx");
}

@end
