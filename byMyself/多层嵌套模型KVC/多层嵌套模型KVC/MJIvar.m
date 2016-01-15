//
//  MJIvar.m
//  多层嵌套模型KVC
//
//  Created by lizhongqiang on 15/10/14.
//  Copyright (c) 2015年 lizhongqiang. All rights reserved.
//

#import "MJIvar.h"

@implementation MJIvar
- (instancetype)initMJIvar:(Ivar )ivar scrObject:(id)object
{
    if(self=[super initWithSrcObject:object]){
        self.ivar=ivar;
    }
    return self;
}
- (void)setIvar:(Ivar )ivar
{
    _ivar = ivar;
    
    _name = [NSString stringWithUTF8String:ivar_getName(ivar)];
    
    // 2.属性名
    if ([_name hasPrefix:@"_"]) {
        _propertyName = [_name stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
    } else {
        _propertyName = _name;
    }
    NSString *code = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
    
    _type = [[MJType alloc] initWithCode:code];
}
- (void)setValue:(id)value
{
    [_srcObject setValue:value forKey:_propertyName];
}
@end
