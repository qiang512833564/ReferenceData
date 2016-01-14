/**
 *******************************************************
 *                                                      *
 * 感谢您的支持， 如果下载的代码在使用过程中出现BUG或者其他问题    *
 * 您可以发邮件到 asiosldh@163.com 或者 到                       *
 * http://www.cocoachina.com/bbs/              提交问题     *
 *
 *  次单例支持arc已经非arc环境,多线程安全  参考了MJ大神的基础上加了一点点东西

 *******************************************************
 */

#import "SharedHttpTools.h"

@implementation SharedHttpTools


- (instancetype)init
{
    static dispatch_once_t onceToken;
    static id obj = nil;
    dispatch_once(&onceToken, ^{
        obj = [super init];
        if (obj) {
            
            // 第一次创建单例就必须加载的数据信息
        }
    });
    return self;
}
singleton_m(HttpTools);

@end
