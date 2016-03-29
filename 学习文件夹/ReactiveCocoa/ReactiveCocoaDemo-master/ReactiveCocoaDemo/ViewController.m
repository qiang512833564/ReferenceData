//
//  ViewController.m
//  ReactiveCocoaDemo
//
//  Created by junze on 15/1/14.
//  Copyright (c) 2015年 Lno. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveCocoa.h"
#import <RACReturnSignal.h>
#import <libkern/OSAtomic.h>

@interface ViewController ()

@end

@implementation ViewController
- (void)test{
    NSLog(@"%s",__func__);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self subscriptionOperator];
//    [self injectOperator];
//    [self mapOperator];
//    [self filterOperator];
//    [self concatOperator];
//    [self flattenOfSequenceOperator];
//    [self flattenOfSignalOperator];
//    [self sequenceFlattenMapOperator];
//    [self signalFlattenMapOperator];
//    [self signalOfThenOperator];
//    [self mergeOperator];
//    [self combineLatestOperator];
//    [self switchToLatestOperator];
//    [self deliverOn_Operations];
//    [self raccommandOperations];
//    [self deferOperations];
//    [self multicastConnectionOperations];
//    [self reduceEach_Operation];
    [self combineLatestWith_Operation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Basic Operators
#pragma mark - 订阅(分三种信号订阅，分别是：next、error、completed)
- (void)subscriptionOperator
{
    RACSignal *letters = [@"a b c d e f" componentsSeparatedByString:@" "].rac_sequence.signal;
    [letters subscribeNext:^(NSString *x) {
        NSLog(@"%@", x);
    }];
    
    
    __block NSUInteger count = 0;
    RACSignal *subscription = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        count++;
        [subscriber sendCompleted];
        return nil;
    }];
    
    
    RACSignal *subSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@200];
        [subscriber sendCompleted];
        return nil;
    }];
    RACSignal *completeSignal = [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@100];
    
        return [subSignal subscribeNext:^(id x) {
            //这里想要执行，则subSignal必须发送sendNext信号
            [subscriber sendNext:x];
        } error:^(NSError *error) {
            //这里想要执行，则subSignal必须发送sendError信号
            [subscriber sendError:error];
        } completed:^{
            //这里想要执行，则subSignal必须发送sendCompleted信号
            [subscriber sendCompleted];
        }];
    }];
    /*
     对信号进行订阅的时候：都会调用
     RACSubscriber *o = [RACSubscriber subscriberWithNext:nextBlock error:NULL completed:NULL];
     return [self subscribe:o];//这个subscribe:o方法，仅仅只是调用创建信号时参数block
     方法，而该方法，基本上，都是简单的对next/error/completed三个block进行copy存值
     真正实现调用订阅传入的block参数的是，RACSubscriber相应的send方法
     */
    //subscribeNext会去调用subscribe相应的next-block代码块(但是前提是，信号必须next信号)
    [completeSignal subscribeNext:^(id x) {
        NSLog(@"next----%@",x);
    }];
    //subscribeCompleted会去调用subscribe相应的complete-block代码块(但是前提是，信号必须completed信号)
    [completeSignal subscribeCompleted:^{
        NSLog(@"completion");
    }];
    
    [subscription subscribeCompleted:^{
        NSLog(@"count: %@", @(count));//1
    }];
    [subscription subscribeCompleted:^{
        NSLog(@"count: %@", @(count));//2---从count可以看出，RACSignal创建时候，传入的block，参数，是在订阅者，订阅的时候，调用的
    }];
}

#pragma mark - 注入
- (void)injectOperator
{
    __block unsigned subscriptions = 0;
    
    RACSignal *loggingSignal = [RACSignal createSignal:^ RACDisposable * (id<RACSubscriber> subscriber) {
        subscriptions++;
        
        [subscriber sendNext:@(200)];
        [subscriber sendCompleted];
        //一旦，发送错误error信号和完成completed信号，则该订阅者，直接结束所有后序操作，但是需要注意的是，相应的订阅仍然可以相应
        [subscriber sendError:[NSError errorWithDomain:@"error" code:404 userInfo:nil]];
        return nil;
    }];
    
    // Does not output anything yet
    loggingSignal = [loggingSignal doCompleted:^{
        NSLog(@"1 about to complete subscription %u", subscriptions);
    }];
    
    [loggingSignal subscribeError:^(NSError *error) {
        NSLog(@"error=%@",error);
    }];
    [loggingSignal subscribeNext:^(id x) {
        NSLog(@"loggingSignal-subscribeNext-= %@",x);
    }];
    
    loggingSignal = [loggingSignal doCompleted:^{
        NSLog(@"2 about to complete subscription %u", subscriptions);
    }];
    //两个doCompleted方法，就是每调用一次，都会创建一个信号对象，然后，该信号又对上一个信号，进行订阅，（这是由于每次创建信号的block，只有再被订阅时，才能调用），有点类似于递归调用
    
    // Outputs:
    // 1 about to complete subscription 1
    // 2 about to complete subscription 1
    // subscription 1
    [loggingSignal subscribeCompleted:^{
        NSLog(@"subscription %u", subscriptions);
    }];
}

#pragma mark - 映射
- (void)mapOperator
{
    RACSequence *letters = [@"a b c d e" componentsSeparatedByString:@" "].rac_sequence;
    RACSequence *mapped = [letters map:^(NSString *value) {
        return [value stringByAppendingString:value];
    }];
    [mapped.signal subscribeNext:^(NSString *x)
    {
        NSLog(@"mapped: %@", x);
    }];
}

#pragma mark - 过滤
- (void)filterOperator
{
    RACSequence *numbers = [@"0 1 2 3 4 5 6 7 8 9" componentsSeparatedByString:@" "].rac_sequence;
    //filter过滤，根据其return的Bool来判断，YES，表示过滤掉，NO，表示不过滤掉
    /*
     id stream = block(value) ?: [class empty];
     这就是fileter根据传入的block，返回的bool，来返回RACSignal
     */
    RACSequence *filterNumbers = [numbers filter:^BOOL(NSString *value) {
        NSLog(@"%@",value);
        return value.intValue % 2 == 0;
    }];
    [filterNumbers.signal subscribeNext:^(NSString *x) {
        NSLog(@"filter: %@",x);
    }];
}

#pragma mark - concat连接(将多个信号，一次拼接)
- (void)concatOperator
{
    RACSequence *letters = [@"a b c d e" componentsSeparatedByString:@" "].rac_sequence;
    RACSequence *numbers = [@"1 2 3 4 5" componentsSeparatedByString:@" "].rac_sequence;
    /*
     - (RACSignal *)concat:(RACSignal *)signal {
     return [[RACSignal createSignal:^(id<RACSubscriber> subscriber) {
     RACSerialDisposable *serialDisposable = [[RACSerialDisposable alloc] init];
     
     RACDisposable *sourceDisposable = [self subscribeNext:^(id x) {
     [subscriber sendNext:x];
     } error:^(NSError *error) {
     [subscriber sendError:error];
     } completed:^{
     RACDisposable *concattedDisposable = [signal subscribe:subscriber];//这里是拼接的根源，因为两个信号同时绑定一个订阅者
     从这里可以看出，[letters concat:numbers]，letters信号会先调用订阅的方法，numbers后调用
     serialDisposable.disposable = concattedDisposable;
     }];
     
     serialDisposable.disposable = sourceDisposable;
     return serialDisposable;
     }] setNameWithFormat:@"[%@] -concat: %@", self.name, signal];
     }
     */
    RACSequence *concatSequence = [letters concat:numbers];
    
    [concatSequence.signal subscribeNext:^(NSString *x) {
        NSLog(@"concat: %@", x);
    }];
}

#pragma mark - 对sequence类型进行flatten(合并)操作,使每个sequence，都调同用一个nextblock
- (void)flattenOfSequenceOperator
{
    RACSequence *letters = [@"a b c d e f" componentsSeparatedByString:@" "].rac_sequence;
    [letters setName:@"letters"];
    RACSequence *numbers = [@"1 2 3 4 5 6" componentsSeparatedByString:@" "].rac_sequence;
    [numbers setName:@"numbers"];
    RACSequence *sequenceOfSequences = @[letters, numbers].rac_sequence;
    
    RACSequence *flatted = [sequenceOfSequences flatten];
    
    [flatted.signal subscribeNext:^(id x) {
        NSLog(@"flatten of sequence: %@", x);
    }];
}

#pragma mark - 对signal类型进行flatten(合并)操作,使每个RACSignal，都调同用一个nextblock
- (void)flattenOfSignalOperator
{
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    RACSignal *signalOfSignals = [RACSignal createSignal:^ RACDisposable * (id<RACSubscriber> subscriber) {
        [subscriber sendNext:letters];
        [subscriber sendNext:numbers];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *flattened = [signalOfSignals flatten];
    
    // Outputs: A 1 B C 2
    [flattened subscribeNext:^(NSString *x) {
        NSLog(@"%@", x);
    }];
    
    [letters sendNext:@"A"];
    [numbers sendNext:@"1"];
    [letters sendNext:@"B"];
    [letters sendNext:@"C"];
    [numbers sendNext:@"2"];
    [numbers sendCompleted];
    [numbers sendNext:@"haha"];
}

#pragma mark - sequence的flattenMap操作
- (void)sequenceFlattenMapOperator
{
    
    //抽象理解：
    //对RACSequence类型的对象进行flattenMap操作，
    //可以理解成在flattenMap后的block中对sequence中的元素进行某种操作，
    //并返回操作后得到的元素的RACSequence类型对象，
    //所有返回的RACSequence类型对象*有序*合并在一起，
    //成为一个新的RACSequence类型对象。
    RACSequence *numbers = [@"1 2 3 4 5 6 7 8 9" componentsSeparatedByString:@" "].rac_sequence;
#if 0
    RACSequence *extended = [numbers flattenMap:^(NSString *num) {
        return @[num, num].rac_sequence;
    }];
    [extended.signal subscribeNext:^(NSString *x) {
        NSLog(@"extended x: %@", x);
    }];
#endif
#if 1
    RACSequence *edited = [numbers flattenMap:^RACStream *(NSString *num)
    {
        if (num.intValue % 2 == 0)
        {
            return [RACSequence empty];
        }
        else
        {
            NSString *newNum = [num stringByAppendingString:@"_"];
            return [RACSequence return:newNum];//return前面加上RACSequence，表示把返回值，强转成RACSequence类型
        }
    }];
    [edited.signal subscribeNext:^(NSString *x) {
        NSLog(@"edited: %@", x);
    }];
#endif
}

#pragma mark - signal的flattenMap操作
- (void)signalFlattenMapOperator
{
    //抽象理解：
    //对RACSignal类型的对象进行flattenMap操作，
    //可以理解成在flattenMap后的block中对signal
    //中的元素进行某种操作，并返回操作后得到的元素的RACSignal类型对象，
    //所有返回的RACSequence类型对象*无序*合并在一起，
    //成为一个新的RACSignal类型对象。
    RACSignal *letters = [@"a b c d e f g" componentsSeparatedByString:@" "].rac_sequence.signal;
    RACSignal *lettersFlattenMap = [letters flattenMap:^RACStream *(NSString *letter)
                                    {
                                        
                                        return @[letter, letter].rac_sequence.signal;
                                    }];
    
    [lettersFlattenMap subscribeNext:^(id x) {
        NSLog(@"RACSignal flattenMap: %@", x);
    }];
}

#pragma mark - then操作
- (void)signalOfThenOperator
{
    RACSignal *letters = [@"1 2 3 4 5 6 7 8 9" componentsSeparatedByString:@" "].rac_sequence.signal;
    
    // The new signal only contains: 1 2 3 4 5 6 7 8 9
    //
    // But when subscribed to, it also outputs: A B C D E F G H I
    /*
     注意
     doNext: 执行Next之前，会先执行这个Block
     doCompleted: 执行sendCompleted之前，会先执行这个Block
     doNext/subscribeNext
     doCompleted/subscribeCompleted
     doError/subscribeError
     两两相互调用
     */
    RACSignal *doNext = [letters
                         doNext:^(NSString *letter) {
                             //NSLog(@"%@", letter);
                         }];
    [doNext subscribeNext:^(id x){
       // NSLog(@"%@",x);
    }];
    RACSignal *filterNumbers = [doNext filter:^BOOL(NSString *value) {
        NSLog(@"%@",value);
        return value.intValue % 2 == 0;
    }];
    [filterNumbers subscribeNext:^(id x) {
        NSLog(@"ignoreValues=%@",x);
    }];
    //then函数，是通过concat对RACSequence里面的NSArray信号，进行拼接,
    //但是需要注意的是，then函数，会忽略掉原来信号里，所有的值，
    //而替换为return返回的值，
    RACSignal *sequenced = [doNext
                            then:^{//[self ignoreValues]
                                return [@"1 2 3 4 5 6 7 8 9 10" componentsSeparatedByString:@" "].rac_sequence.signal;
                            }];
    /*
     - (RACSequence *)tail {
     RACSequence *sequence = [self.class sequenceWithArray:self.backingArray offset:self.offset + 1];
     sequence.name = self.name;
     return sequence;
     }
     */
    //array.rac_sequence.signal,在被订阅的时候，会通过数组的tail将,RACSequence与所需要绑定的数组绑定，然后再通过递归调用，循环的遍历，数组中的每个元素
    [sequenced subscribeNext:^(id x) {
        NSLog(@"then: %@", x);
    }];
    
}

#pragma mark - merge操作
- (void)mergeOperator
{
    //该操作流程和对signal类型进行flatten(合并)操作流程是一样的
    RACSubject *letters = [[RACSubject alloc]init];
    RACSubject *numbers = [[RACSubject alloc]init];
    RACSignal *merged = [RACSignal merge:@[letters, numbers]];
    [merged subscribeNext:^(id x) {
        NSLog(@"merged: %@", x);
    }];
    
    [letters sendNext:@"a"];
    [numbers sendNext:@"1"];
    [letters sendNext:@"b"];
    [numbers sendNext:@"2"];
}

#pragma mark - combineLatest操作
- (void)combineLatestOperator
{
    RACSubject *letters = [[RACSubject alloc]init];
    RACSubject *numbers = [[RACSubject alloc]init];
    //reduce: 归纳
    
    /*
     combineLatest:将多个信号合并起来，并且拿到各个信号的最新的值,必须每个合并的signal至少都有过一次sendNext，才会触发合并的信号。
     //第一次的时候，两个信号同时发送信号
     //以后，每个信号发送的时候，都会与另一个发送的上次信号相结合
     
     combineLatest:reduce:
     combineLatest传入的多个信号参数，当他们信号发出的时候，调用reduce，并且把他们发出信号的参数同时传入reduce后面的block参数里
     */
    RACSignal *combined = [RACSignal combineLatest:@[letters, numbers] reduce:^(NSString *letter, NSString *number){
        return [letter stringByAppendingString:number];
    }];
    
    [combined subscribeNext:^(id x) {
        NSLog(@"combined: %@", x);
    }];
    [letters sendNext:@"A"];
    [numbers sendNext:@"1"];
    [numbers sendNext:@"2"];
    [letters sendNext:@"AA"];
    [letters sendNext:@"B"];
    [numbers sendNext:@"1"];
    [numbers sendNext:@"2"];
    [letters sendNext:@"C"];
    [numbers sendNext:@"1"];
    [numbers sendNext:@"2"];
}
#pragma mark ---switchToLatest:用于signalOfSignals(信号的信号)，有时候信号也会发出信号，会在signalOfSignals中，获取signalOfSignals发送的最新信号
- (void)switchToLatestOperator{
#if 1
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    RACSubject *signalOfSignals = [RACSubject subject];
    
    RACSignal *switched = [signalOfSignals switchToLatest];
    
    //Outputs: A B 1 D
    [switched subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    //需要注意的是：[signalOfSignals switchToLatest]是[signalOfSignals sendNext:letters];发送的信号，对其订阅时，也需要是相应的信号订阅
    [signalOfSignals sendNext:letters];
    [letters sendNext:@"A"];
    [letters sendNext:@"B"];
    
    [signalOfSignals sendNext:numbers];
    [letters sendNext:@"C"];
    [letters sendNext:@"1"];
//
    [signalOfSignals sendNext:letters];
    [numbers sendNext:@"2"];
    [numbers sendNext:@"D"];
#endif
#if 0
    RACSubject *signalOfSignals = [RACSubject subject];
    RACSubject *signal = [RACSubject subject];
    
    //获取信号中信号最近发出信号，订阅最近发出的信号。
    //注意switchToLatest:只能用于信号中的信号
    [signalOfSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    [signalOfSignals sendNext:signal];
    [signal sendNext:@1];
    [signal sendNext:@200];
#endif
}
#pragma mark  ----- RACScheduler类操作
- (void)deliverOn_Operations{
    RACSignal *signal = [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"发送信号"];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号销毁");
        }];//deliverOn创建一个新的信号并且使该信号处于其它队列中（比如有时我们需要回到主线程中更新UI）
    }]deliverOn:[RACScheduler mainThreadScheduler]]
    map:^id(id value) {
        return @"map二次操作信号";
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"thread=%@",[NSThread currentThread]);
        NSLog(@"订阅信号%@",x);
    }];
}
#pragma mark -----  raccommand类操作
- (void)raccommandOperations{
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@(100)];
            [subscriber sendError:[NSError errorWithDomain:@"错误" code:404 userInfo:nil]];
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"销毁信号");
            }];
        }];
    }];
    [command.executionSignals subscribeNext:^(RACSignal *signal) {
         [signal subscribeNext:^(id x) {
             NSLog(@"%@",x);
         }];
        //这里对信号，进行订阅是无效的-----有效方式是通过command.errors订阅操作
        [signal subscribeError:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }];
    [command.errors subscribeNext:^(id x) {
        NSLog(@"next=%@",x);
    }];
    [command.errors subscribeError:^(NSError *error) {
        NSLog(@"errors=%@",error);
    }];
    [command execute:@"执行"];
}
#pragma mark ----- defer 操作(延迟操作，具体一点来说，是跟defer传入block参数调用返回的RACSignal有关，只有当其发送信号时，才回去调用defer方法创建的RACSignal的订阅subscribeNext方法)
- (void)deferOperations{
    /*
     + (RACSignal *)defer:(RACSignal * (^)(void))block {
     NSCParameterAssert(block != NULL);
     
     return [[RACSignal createSignal:^(id<RACSubscriber> subscriber) {
     return [block() subscribe:subscriber];
     }] setNameWithFormat:@"+defer:"];
     }
     */
    __block RACSubject *returnSignal = nil;
    RACSignal *signal = [RACSignal defer:^RACSignal *{
        returnSignal = [RACSubject subject];
        return returnSignal;
    }];
    NSLog(@"%@",signal);
    //对signal订阅，会调用[block() subscribe:subscriber]方法，去对block返回的信号进行订阅，
    //其实原理，就是defer方法创建的signal与defer传入的block返回的signal，两个信号源，公用一个subscriber,当该subscriber发送sendNext的时候，会同时激活两者的订阅block
    [signal subscribeNext:^(id x) {
        NSLog(@"self=%@,defer=%@",signal,x);
    }];
    
    [returnSignal subscribeNext:^(id x) {
        NSLog(@"returnSignal=%@",x);
    }];
    
    [returnSignal sendNext:@100];
    
    
}
#pragma mark --- multicastConnectionOperations
- (void)multicastConnectionOperations{
#if 0
    int32_t volatile _hasConnected;
    
    BOOL shouldConnect = OSAtomicCompareAndSwap32Barrier(0, 100, &_hasConnected);
    
    if (shouldConnect) {
        NSLog(@"%d",_hasConnected);
    }
#endif
    //步骤一、
    RACSignal *signal = [[RACSignal return:@"hello"]doNext:^(id nextValue) {
        NSLog(@"nextValue:%@",nextValue);
    }];
    //正常对一个信号订阅两次的话，也会调用创建RACSignal传入的block两次，也就是会发送信号两次
    [signal subscribeNext:^(id x) {
        NSLog(@"no_operations=%@",x);
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"no_operations=%@",x);
    }];
    //步骤二、
    //下面的操作，就是为了实现，一次信号发送，可以多次订阅（replay,publish,multicast操作，都是利用RACSubject这个中间信号，它既可以充当信号源，又可以充当订阅者，每次RACSubject发送，信号的时候，都会通过其属性 NSMutableArray *subscribers遍历所有的订阅者，如何有订阅者，则激活成热信号）
    RACMulticastConnection *connection = [signal publish];
    //publish
    //RACMulticastConnection *connection = [[RACMulticastConnection alloc] initWithSourceSignal:self subject:subject];
    //connection.signal 是 subject，并不是源信号
    //步骤三、
    [connection.signal subscribeNext:^(id nextValue) {
        NSLog(@"First %@",nextValue);
    }];
    [connection.signal subscribeNext:^(id nextValue) {
        NSLog(@"Second %@",nextValue);
    }];
    /*
     - (RACDisposable *)connect {
     #pragma mark --- 利用原子性操作，保证对_hasConnected操作是线程安全的
     BOOL shouldConnect = OSAtomicCompareAndSwap32Barrier(0, 1, &_hasConnected);
     if (shouldConnect) {
     self.serialDisposable.disposable = [self.sourceSignal subscribe:_signal];这里是对源信号，进行订阅,这里信号发送的对象是RACSubject,而步骤一中，创建的信号的block里，会有[subject sendNext:@(value)]语句的调用(这里因为RACSubject既可以充当信号源又可以充当订阅者)，所以subject发送信号的同时，会触发对subject订阅的block
     }
     return self.serialDisposable;
     }
     */
    //步骤四、
    [connection connect];
    
    
    connection = [signal multicast:[RACReplaySubject subject]];
    
    [connection.signal subscribeNext:^(id nextValue) {
        NSLog(@"First %@", nextValue);
    }];
    [connection.signal subscribeNext:^(id nextValue) {
        NSLog(@"Second %@", nextValue);
    }];
    [connection connect];
    
#pragma mark --- Replay
    
    RACSignal *replaySignal = [signal replay];
    [replaySignal subscribeNext:^(id nextValue) {
        NSLog(@"First %@", nextValue);
    }];
    [replaySignal subscribeNext:^(id nextValue) {
        NSLog(@"Second %@", nextValue);
    }];
}
#pragma mark --- reduceEach
- (void)reduceEach_Operation{
    /*
     RACSignal *result = [self combineLatest:signals];
     
     if (reduceBlock != nil) result = [result reduceEach:reduceBlock];
     */
    RACSignal *subject = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@100];
        return nil;
    }];
    
    subject  = [RACSubject combineLatest:@[subject]];
    
    //(id (^)())reduceBlock
    id (^reduceBlock) (id)= ^(id value){
        NSLog(@"%@",value);
        return [[RACSignal alloc]init];
    };
    /*
     - (instancetype)reduceEach:(id (^)())reduceBlock {
     return [[self map:^(RACTuple *t) {从这里可以看出对subject = [subject reduceEach:reduceBlock]订阅，返回的block调用就是信号发送的对象
     return [RACBlockTrampoline invokeBlock:reduceBlock withArguments:t];//这里是将block根据传入的参数个数，调用相应方法，从而调用block，并且返回block()调用后返回的对象，作为信号发送的值
     }] setNameWithFormat:@"[%@] -reduceEach:", self.name];
     }
     */
    subject = [subject reduceEach:reduceBlock];
    
    [subject subscribeNext:^(id x) {
        NSLog(@"next=%@",x);
    }];
    
}

#pragma mark --- combineLatestWith_Operation
- (void)combineLatestWith_Operation{
    RACSubject *subject1 = [RACSubject subject];
    RACSubject *subject2 = [RACSubject subject];
    
    RACSignal *lastestSignal = [subject1 combineLatestWith:subject2];
    /*
    void (^sendNext)(void) = ^{
        @synchronized (disposable) {
            if (lastSelfValue == nil || lastOtherValue == nil) return;这是对信号subject1与subject2两者是否有信号发出，做出判断（因为两个信号源，每发送一次信号，都会通过lastSelfValue和lastOtherValue记录）
            [subscriber sendNext:[RACTuple tupleWithObjects:lastSelfValue, lastOtherValue, nil]];
            //这是combineLatestWith创建RACSignal信号源，发送一个方法信号
        }
    };
     */
    [lastestSignal subscribeNext:^(RACTuple *tuple) {
        NSLog(@"number1=%@,number2=%@",tuple.first,tuple.second);
    }];
    
    [subject1 sendNext:@100];
    [subject2 sendNext:@200];
}

@end
