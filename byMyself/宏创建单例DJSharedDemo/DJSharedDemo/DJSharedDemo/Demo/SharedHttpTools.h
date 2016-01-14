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
#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface SharedHttpTools : NSObject

singleton_h(HttpTools);

@end
