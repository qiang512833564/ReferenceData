//
//  MJTypeEncoding.m
//  MJExtension
//
//  Created by mj on 14-1-15.
//  Copyright (c) 2014年 itcast. All rights reserved.
//
#import <Foundation/Foundation.h>
/**
 *  成员变量类型（属性类型）
 */
/*
 作为对Runtime的补充，编译器将每个方法的返回值和参数类型编码为一个字符串，
 并将其与方法的selector关联在一起。
 这种编码方案在其它情况下也是非常有用的，
 因此我们可以使用@encode编译器指令来获取它。当给定一个类型时，@encode返回这个类型的字符串编码。
 这些类型可以是诸如int、指针这样的基本类型，也可以是结构体、类等类型。事实上，任何可以作为sizeof()操作参数的类型都可以用于@encode()。
 */
NSString *const MJTypeInt = @"i";
NSString *const MJTypeFloat = @"f";
NSString *const MJTypeDouble = @"d";
NSString *const MJTypeLong = @"q";
NSString *const MJTypeLongLong = @"q";
NSString *const MJTypeChar = @"c";
NSString *const MJTypeBOOL = @"c";
NSString *const MJTypePointer = @"*";

NSString *const MJTypeIvar = @"^{objc_ivar=}";
NSString *const MJTypeMethod = @"^{objc_method=}";
NSString *const MJTypeBlock = @"@?";
NSString *const MJTypeClass = @"#";
NSString *const MJTypeSEL = @":";
NSString *const MJTypeId = @"@";

/**
 *  返回值类型(如果是unsigned，就是大写)
 */
NSString *const MJReturnTypeVoid = @"v";
NSString *const MJReturnTypeObject = @"@";



