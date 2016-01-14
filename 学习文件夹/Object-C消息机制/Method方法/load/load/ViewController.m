//
//  ViewController.m
//  load
//
//  Created by lizhongqiang on 15/11/6.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"
#import "testObjsct2.h"
#import <objc/runtime.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    testObjsct2 *test = [[testObjsct2 alloc]init];
    [test sd_reloadData];
    
    NSLog(@"%s",object_getClassName(test));//object_getClassName获取的是其自身类别，而不是父类类别
    NSLog(@"%d",object_isClass(test));//判断对象是否是一个类别，而不是一个对象
    /*
     typedef struct objc_ivar *Ivar;
     
     struct objc_ivar {
     char *ivar_name                                          OBJC2_UNAVAILABLE;
     char *ivar_type                                          OBJC2_UNAVAILABLE;
     int ivar_offset                                          OBJC2_UNAVAILABLE;
     #ifdef __LP64__
     int space                                                OBJC2_UNAVAILABLE;
     #endif
     }
     */
//    var->ivar_offset = 10;
//    
//    object_setIvar(test, var, @"test");
    //iOS运行时添加属性和方法
    //这个依赖于：OC的setter与getter方法是通过SEL方法名来寻找方法实现，另外我们也可以修改IMP方法的实现
    objc_property_attribute_t type = {"T","@\"NSString\""};
    objc_property_attribute_t ownership = {"C",""};//// C = copy
    objc_property_attribute_t backingivar = {"V","_privateName"};
    objc_property_attribute_t attrs[] = {type,ownership,backingivar};
    class_addProperty([testObjsct2 class], "name", attrs, 3);
    class_addMethod([testObjsct2 class], @selector(name), (IMP)nameGetter, "@@:");
    class_addMethod([testObjsct2 class], @selector(setName:), (IMP)nameSetter, "v@:@");
    
    id o = [testObjsct2 new];
    NSLog(@"%@",[o name]);
    [o setName:@"dadadadaada"];
    NSLog(@"%@",[o name]);
    //[o valueForUndefinedKey:@"myname"];
    //NSLog(@"%@",o);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
