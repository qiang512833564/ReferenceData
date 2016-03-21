//
//  TwoViewController.m
//  ReactiveCocoa框架使用
//
//  Created by lizhongqiang on 16/1/23.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "TwoViewController.h"
#import "NSObject+RACKVOWrapper.h"
#import <RACReturnSignal.h>
@interface TwoViewController()
@property (nonatomic, strong)RACCommand *command;
@property (nonatomic, strong)UIButton *btn;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, strong)UITextField *textField;
@end
@implementation TwoViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送消息" forState:UIControlStateNormal];
    btn.frame = CGRectMake(20, 100, 100, 30);
    btn.backgroundColor = [UIColor purpleColor];
    [btn sizeToFit];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(notice) forControlEvents:UIControlEventTouchUpInside];
    
    /*
     rac_signalForSelector中创建了一个subject(一个可以手动控制进行sendNext的信号), 做了很复杂的swizzling, 其中和发送信号相关的是RACSwizzleForwardInvocation, 这个方法改写了原本的forwardInvocation. 然后将自己的对应selector的方法替换成forwardInvocation，这个forwardInvocation里面会调用[subject sendNext:]发送信号给subscriber.
     
     一句话概括：rac_textSignal会”劫持” UITextView.delegate的textViewDidChange:方法，然后在这个方法调用时，把这个方法传入的参数发送给subscriber。这个劫持过程的实现是由[NSObject rac_signalForSelector:]方法完成的。
     */
    //通过objc_setAssociatedObject，class_getInstanceMethod---runtime去实现，方法的调用
    [[self.view rac_signalForSelector:@selector(notice)]subscribeNext:^(id x) {
        NSLog(@"红色按钮");
    }];
    
    // 2.KVO
    // 把监听redV的center属性改变转换成信号，只要值改变就会发送信号
    // observer:可以传入nil
    [[self.view rac_valuesAndChangesForKeyPath:@"center" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
        
    }];
    
    RACSignal *signal = [[[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@1];
        return [RACDisposable disposableWithBlock:^{
             NSLog(@"信号被销毁");
        }];
    }]map:^id(id value) {
        /*
         [self subscribeNext:^(id x) {
         BOOL stop = NO;
         id signal = bindingBlock(x, &stop);
         }];
         */
        //为什么map可以获取到发送的信号值，
        //是因为其函数内部对信号流进行了订阅，并且把订阅后获取到的信号值，作为参数，并调用这里的block
        //map这个函数，代表映射。map能做的事情就是把监听的对象所返回的值，替换成跟return后面的一致。
        NSLog(@"%@",value);
        return @100;
    }]startWith:@(100)]distinctUntilChanged];//startWith也就是最开始的意思，看以上代码 startWith:@"123"等同于[subscriber sendNext:@"123"] 也就是第一个发送，主要是位置.
    //distinctUntilChanged 表示两个消息相同的时候，只会发送一个请求
    [signal subscribeNext:^(id x) {
        NSLog(@"第一次订阅消息%@",x);
    }];
    
    //// reduceEach的作用是传入多个参数，返回单个参数，是基于`map`的一种实现
    //一般用于服务器响应等
    
    //1.创建命令
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"请求数据"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    self.command = command;
    
    RACSignal * signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"a"];
            [subscriber sendCompleted];
        });
        
        return nil;
    }];
    
    RACSignal * signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           
            [subscriber sendNext:@"b"];
            [subscriber sendCompleted];
        });
        
        return nil;
    }];
    
    [[RACSignal merge:@[signalA, signalB]]subscribeNext:^(id x) {
        //merge方法合并了A和B,信号订阅后的，调用方法block
        //简单的说就是A和B的打印方法用的是同一个。他们之间关系是独立的，如果A发送失败，B依然会执行。
        NSLog(@"dadadada");
    }];
    
    
    [RACSignal combineLatest:@[signalB,signalA] reduce:^(NSString *word){
        NSLog(@"%@",word);
        return @"word";
    }];
//    [[RACSignal concat:@[signalB,signalA]]subscribe:^(id x) {
//        NSLog(@"")
//    }];
    
    //[command.executionSignals subscribeNext:<#^(id x)nextBlock#>];
    
#pragma mark ------ 
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"基本用法" forState:UIControlStateNormal];
    btn2.frame = CGRectMake(20, 200, 100, 30);
    btn2.backgroundColor = [UIColor purpleColor];
    [btn2 sizeToFit];
    [self.view addSubview:btn2];
    self.btn = btn2;
    [self event];
    
    // 6.处理当界面有多次请求时，需要都获取到数据时，才能展示界面
    RACSignal *requestHot = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"请求最热商品");
        [subscriber sendNext:@"获取最热商品1"];
        return nil;
    }];
    
    RACSignal *requestNew = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"请求最新商品");
        [subscriber sendNext:@"获取最热商品2"];
        //        [subscriber sendNext:@"获取最新商品"];
        return nil;
    }];
    
    // Selector调用:当所有信号都发送数据的时候调用
    // 数组存放信号
    // Selector注意点:参数根据数组元素决定
    // Selector方法参数类型,就是信号传递出来数据
    [self rac_liftSelector:@selector(updateUI:data2:) withSignalsFromArray:@[requestHot,requestNew]];
    
    [self.view addSubview:self.textField];
    [self rac_textSignal];
    
    [self notication];
    
    [self KVO];
    
    [self delegate];
}
// 只要两个请求都请求完成的时候才会调用
- (void)updateUI:(NSString *)data1 data2:(NSString *)data2
{
    NSLog(@"%@ %@",data1,data2);
}

- (void)event{
    // 3.监听事件
    //  只要按钮产生这个事件,就会产生一个信号
    [[_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"按钮被点击%@",x);
    }];
    _btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"按钮点击");
        return [RACSignal empty];
    }];
    
}
- (UITextField *)textField{
    if (_textField == nil) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(50, 300, 100, 44)];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _textField;
}
- (void)rac_textSignal
{
    // 5.监听文本框
    //方式一
    [_textField.rac_textSignal subscribeNext:^(id x) {
        // x:文本框的文字
        NSLog(@"%@",x);
    }];
    
    //方式二
    /*
     RAC宏第一个参数是target，也就是需要绑定的对象；
          第二个参数是keyPath, 也就是对象中需要绑定的属性名。
     RAC实际上是创建了一个RACSubscriptingAssignmentTrampoline对象，
     并调用其setObject:forKeyedSubscript:方法
     */
    //用于给某个对象的某个属性绑定
    //这是把textfield的文本编辑信息，转成RAC的信号，然后，通过RAC宏，去对该信号进行订阅
    RAC(self,name) = _textField.rac_textSignal;
    
    //方式三
    /*
     底层实现：
     1.源信号调用bind,会重新创建一个绑定信号
     2.当绑定信号被订阅，就会调用绑定信号中的didSubscribe,生成一个bindingBlock(并对源信号进行订阅)
     3.当源信号有内容发出，，就会通过订阅调用，把内容传递到bindingBlock处理，调用bindingBlock(value,stop)
     4.调用bindingBlock(value,stop),会返回一个内容处理完成的信号(RACReturnSignl)
     5.订阅RACReturnSignal,就会拿到绑定信号的订阅者，把处理完成的信号内容发送出来
     （处理的信号内容，会以源信号发送信号的方式sendNext传送出来，然后在最初对绑定信号的subscribeNext订阅，展现出来）
     */
    [[_textField.rac_textSignal bind:^RACStreamBindBlock{
        //typedef RACStream * (^RACStreamBindBlock)(id value, BOOL *stop);
        //参数一（value）：表示接收到信号的原始值，还没做处理
        //参数二（*stop）：用来控制绑定Block，如果*stop=YES，那么就会结束绑定。
        //返回值：信号，做好处理，在通过这个信号返回出去，一般使用RACReturnSignal,需要手动导入头文件RACReturnSignal.h
        return ^RACStream *(id value, BOOL *stop){
            
            return [RACReturnSignal return:[NSString stringWithFormat:@"输出：%@",value]];
        };
    }] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}
- (void)notication
{
    // 4.监听通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];
}
- (void)notice{
    // 通知第一个控制器，告诉它，按钮被点了
    
    // 通知代理
    // 判断代理信号是否有值
    if (self.delegateSignal) {
        // 有值，才需要通知
        [self.delegateSignal sendNext:nil];
    }
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.textField resignFirstResponder];
    self.name = @"123";
}
- (void)btnckick{
    NSLog(@"%s----%@",__func__,[self class]);
}
- (void)KVO
{
    // 2.KVO
    [self rac_observeKeyPath:@"name" options:NSKeyValueObservingOptionNew observer:nil block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
        // 只要监听的属性一改变调用
        NSLog(@"%@",self.name);
    }];
    
    // KVO:第二种,只要对象的值改变,就会产生信号,订阅信号
    [[self rac_valuesForKeyPath:@"name" observer:nil] subscribeNext:^(id x) {
        NSLog(@"name=%@",x);
    }];
    
    //kVO:第三种
    [RACObserve(self, name) subscribeNext:^(id x) {
        NSLog(@"name=%@",x);
    }];
}
- (void)delegate
{
    // 使用任何框架,都可以尝试下敲框架的类名
    // 1.代替代理,RACSubject
    // RAC方法:可以判断下某个方法有没有调用
    // 只要self调用Selector就会产生一个信号
    // rac_signalForSelector:监听某个对象调用某个方法
    [[self rac_signalForSelector:@selector(didReceiveMemoryWarning)] subscribeNext:^(id x) {
        
        NSLog(@"控制器调用了didReceiveMemoryWarning");
    }];
    // 判断下redView有没有调用btnClick,就表示点击了按钮
    [[self rac_signalForSelector:@selector(btnckick)] subscribeNext:^(id x) {
        NSLog(@"点击了按钮");
    }];
}
@end
