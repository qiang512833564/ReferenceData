//
//  NSString+UIColorFromNSString.m
//  Partner-Swift
//
//  Created by lizhongqiang on 16/1/4.
//  Copyright © 2016年 caijingpeng.haowu. All rights reserved.
//

#import "NSString+UIColorFromNSString.h"
#import <objc/runtime.h>
@implementation NSString (UIColorFromNSString)
- (UIColor *)UIColor{
    UIColor *color = objc_getAssociatedObject(self, _cmd);
    if(color){
        return  color;
    }
    return [self getForUIColor];
}
- (void)setUIColor:(UIColor *)UIColor{
    objc_setAssociatedObject(self, @selector(UIColor), UIColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIColor *)getForUIColor{
    NSString *str = self;
    if([str hasPrefix:@"#"]){
        str = [str substringFromIndex:1];
    }
    switch (str.length) {
        case 1:
            str = [str repeatString:6];
        case 2:
            str = [str repeatString:3];
        case 3:
            str = [str repeatString:2];
        default:
            break;
    }
    unsigned int r = 0;
    unsigned int g = 0;
    unsigned int b = 0;
    NSString *mutableStr = [NSString stringWithFormat:@"0x%@",[str substringWithRange:NSMakeRange(0, 2)]];
    [[NSScanner scannerWithString:mutableStr] scanHexInt:&r];
    
    mutableStr = [NSString stringWithFormat:@"0x%@",[str substringWithRange:NSMakeRange(2, 2)]];
    [[NSScanner scannerWithString:mutableStr] scanHexInt:&g];
    
    mutableStr = [NSString stringWithFormat:@"0x%@",[str substringWithRange:NSMakeRange(4, 2)]];
    [[NSScanner scannerWithString:mutableStr] scanHexInt:&b];
    
    CGFloat red = r/255.f;
    CGFloat green = g/255.f;
    CGFloat blue = b/255.f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}
- (NSString *) repeatString:(int)count {
    NSMutableString *str = @"".mutableCopy;
   [str stringByPaddingToLength:self.length*count withString:self startingAtIndex:0];
    return str;
//    return "".stringByPaddingToLength((self.characters.count) * count, withString: self, startingAtIndex:0)
}

@end
