
/**
 *******************************************************
 *                                                      *
 * 感谢您的支持， 如果下载的代码在使用过程中出现BUG或者其他问题    *
 * 您可以发邮件到 asiosldh@163.com 或者 到                       *
 * http://www.cocoachina.com/bbs/              提交问题     *
 *
 *
 *  次单例支持arc已经非arc环境  参考了MJ大神的基础上加了一点点东西
 
 使用说明
 1. 创建你的单例 比如我这里创建的是 SharedMaxTools 
 2. 在.h文件添加  singleton_h(MaxTools)
 3. 在.m文件添加  
 
 - (instancetype)init
 {
 static dispatch_once_t onceToken;
 static id obj = nil;
 dispatch_once(&onceToken, ^{
 obj = [super init];
 if (obj) {
 
 // 加载资源
 
 }
 });
 return self;
 }
 singleton_m(MaxTools);

 *******************************************************
 */


// ## : 连接字符串和参数
#define singleton_h(name) + (instancetype)shared##name;

#if __has_feature(objc_arc) // ARC
#define singleton_m(name) \
static id _instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
    return _instance; \
} \
 \
+ (instancetype)shared##name \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [[self alloc] init]; \
    });\
    return _instance; \
} \
+ (instancetype)copyWithZone:(struct _NSZone *)zone \
{ \
    return _instance; \
}\
+ (instancetype)new\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _instance = [[self alloc] init];\
    });\
    return _instance;\
}


#else // F-ARC
#define singleton_m(name) \
static id _instance; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (oneway void)release \
{ \
\
} \
\
- (instancetype)autorelease \
{ \
return _instance; \
} \
\
- (instancetype)retain \
{ \
return _instance; \
} \
\
- (NSUInteger)retainCount \
{ \
return 1; \
} \
\
+ (instancetype)copyWithZone:(struct _NSZone *)zone \
{ \
return _instance; \
}\
+ (instancetype)new\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _instance = [[self alloc] init];\
    });\
    return _instance;\
}
#endif
