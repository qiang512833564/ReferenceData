//
//  ViewController.m
//  ReactiveCocoa框架使用
//
//  Created by lizhongqiang on 16/1/23.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark 总结：
/*
 RACSignal创建信号，自我理解：其实显示存储需要发送的信号，然后调用相应的方法subscribeNext来接受信号（在方法subscribeNext的内部会调用创建信号时候设置的block）
 RACSubject是先把subscribeNext后面的block存储到RACSubscriber对象里，其每次调用subscribeNext方法都会创建一个RACSubscriber信号订阅者对象，NSMutableArray *subscribers = RACSubject.subscribers;订阅者存到RACSubject对象的数组里，当有信号发出的时候，最终是通过RACCompoundDisposable对象去中转
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
#pragma mark ---- RACSignal
    //1、创建信号-----从下面的实现步骤（先是生成信号，然后在对信号进行订阅）来看：信号类（RACSiganl）,默认是一个冷信号，也就是只有值发生改变时，才会触发，（换句话说：只有订阅了该信号，这个信号才会变成热信号，才会被触发）
    RACSignal *siganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //block调用时刻：每当有订阅者订阅信号，就会调用block
        //2.发送信号
        [subscriber sendNext:@1];//RACSubscriber表示订阅者的意思，用于发送信号，这是一个协议，不是一个类，只有遵守这个协议，并且实现方法才能成为订阅者
        
        //如果不发送数据，最好发送信号完成，内部会自动调用[RACDisposable disposableWithBlock:^{}]取消订阅信号
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            //block调用时刻：当信号发送完成或者发送错误，就会自动执行这个block，取消订阅信号
            //执行完block后，当前信号就不在被订阅了。
            NSLog(@"信号被销毁");
        }];
    }];
    
    //3.订阅信号，才会激活信号。
    [siganl subscribeNext:^(id x) {
        //block调用时刻：每当有信号发出数据，就会调用block
        NSLog(@"接收到数据:%@",x);
    }];

#pragma mark -- RACSubject
    // RACReplaySubject使用步骤:
    // 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
    // 2.可以先订阅信号，也可以先发送信号。
    // 2.1 订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 2.2 发送信号 sendNext:(id)value
    //1.创建信号
    RACSubject *subject = [RACSubject subject];
    //订阅信号
    [subject subscribeNext:^(id x) {
       //block调用时刻：当信号发出新值，就会调用
        NSLog(@"第一个订阅者%@",x);
    }];
    [subject subscribeNext:^(id x) {
        //block调用时刻：当信号发出新值，就会调用
        NSLog(@"第二个订阅者%@",x);
    }];
    
    //3.发送信号
    [subject sendNext:@"1"];
    
#pragma mark --- RACReplaySubject
    // RACReplaySubject:底层实现和RACSubject不一样。
    // 1.调用sendNext发送信号，把值保存起来，然后遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。
    // 2.调用subscribeNext订阅信号，遍历保存的所有值，一个一个调用订阅者的nextBlock
    
    // 如果想当一个信号被订阅，就重复播放之前所有值，需要先发送信号，在订阅信号。
    // 也就是先保存值，在订阅值。
    // 1.创建信号
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    
    // 2.发送信号
    [replaySubject sendNext:@1];
    [replaySubject sendNext:@2];
    
    // 3.订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"第一个订阅者接收到的数据--%@",x);
    }];
    
    // 订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"第二个订阅者接收到的数据--%@",x);
    }];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送消息" forState:UIControlStateNormal];
    btn.frame = CGRectMake(20, 100, 100, 30);
    btn.backgroundColor = [UIColor purpleColor];
    [btn sizeToFit];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(sendNotes) forControlEvents:UIControlEventTouchUpInside];
}
- (void)sendNotes{
    TwoViewController *twoVC = [[TwoViewController alloc]init];
    //设置代理信号
    twoVC.delegateSignal = [RACSubject subject];
    //订阅代理信号
    [twoVC.delegateSignal subscribeNext:^(id x) {
        NSLog(@"点击了通知按钮");
    }];
    
    [self presentViewController:twoVC animated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
