//
//  ViewController.m
//  runtime--forwardInvocation
//
//  Created by lizhongqiang on 16/3/8.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"
#import "TestObject.h"
#import "SubSomeClass.h"
@interface ViewController ()
@property (nonatomic, strong)SomeClass *object;
@property (nonatomic, strong)SubSomeClass *subObject;
@end

@implementation ViewController
- (IBAction)btnClick:(id)sender {
    //[self.object doesNotRecognizeSelector:@selector(run:)];
    //[self.object doSomething];
    [self.object doSomethingElse];
    //[self.object anyAction];
    //[self.subObject doSomething];
}
- (SomeClass *)object{
    @synchronized(_object) {
        if (_object == nil) {
            _object = [[SomeClass alloc]init];
        }
    }
    return _object;
}
- (SubSomeClass *)subObject{
    if (_subObject == nil) {
        _subObject = [[SubSomeClass alloc]init];
    }
    return _subObject;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
