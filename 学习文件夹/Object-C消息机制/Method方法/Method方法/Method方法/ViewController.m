//
//  ViewController.m
//  Method方法
//
//  Created by lizhongqiang on 15/11/6.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"
#import "NSArray+Swizzle.h"
#import <objc/runtime.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   // @autoreleasepool {
    /*
     struct objc_method {
     SEL method_name                                          OBJC2_UNAVAILABLE;
     char *method_types                                       OBJC2_UNAVAILABLE;
     IMP method_imp                                           OBJC2_UNAVAILABLE;
     }
     */
        Method ori_Method = class_getInstanceMethod([NSArray class], @selector(lastObject));
        Method my_Method = class_getInstanceMethod([NSArray class], @selector(myLastObject));
        method_exchangeImplementations(ori_Method, my_Method);
        
        NSArray *array = @[@"0",@"1",@"2",@"3"];
        NSString *string = [array lastObject];
        NSLog(@"TEST RESULT : %@",string);
    /*
     2015-11-06 15:59:22.879 Method方法[18035:850458] ********** myLastObject **************
     2015-11-06 15:59:22.880 Method方法[18035:850458] TEST RESULT : 3
     [array lastObject];调用的是方法myLastObject
     - (id)myLastObject{
     id ret = [self myLastObject];调用的是方法[self lastObject];
     NSLog(@"********** myLastObject **************");
     return ret;
     }
     */
    //}
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
