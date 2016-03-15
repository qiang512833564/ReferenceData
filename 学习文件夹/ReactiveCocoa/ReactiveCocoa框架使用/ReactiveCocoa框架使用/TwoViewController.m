//
//  TwoViewController.m
//  ReactiveCocoa框架使用
//
//  Created by lizhongqiang on 16/1/23.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "TwoViewController.h"
@interface TwoViewController()
@property (nonatomic, strong)RACCommand *command;
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
    
    //1.创建命令
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"请求数据"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    self.command = command;
    
    //[command.executionSignals subscribeNext:<#^(id x)nextBlock#>];
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
- (void)btnckick{
    NSLog(@"%s----%@",__func__,[self class]);
}
@end
