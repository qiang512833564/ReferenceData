//
//  CFUUID.m
//  iOS唯一标示符
//
//  Created by lizhongqiang on 15/12/15.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "CFUUID.h"

@implementation CFUUID
/*
 UUID是Universally Unique Identifier的缩写,中文意思是通用唯一识别码.
 由网上资料显示,UUID是一个软件建构的标准,也是被开源软件基金会(Open Software Foundation,OSF)的组织在分布式计算环境(Distributed Computing Environment,DCE)领域的一部份.UUID的目的,是让分布式系统中的所有元素,都能有唯一的辨识资讯,而不需要透过中央控制端来做辨识资讯的指定.
 根据以上定义可知,同一设备上的不同应用的UUID是互斥的,即能在改设备上标识应用.但是并没有明确指出能标识出装有同一应用的不同设备,但是根据我推测,这个UUID应该是根据设备标识和应用标识生成唯一标识,再经过加密而来的(纯推测).
 */
/*
 获得的这个CFUUID值系统并没有存储。每次调用CFUUIDCreate，系统都会返回一个新的唯一标示符。
 如果你希望存储这个标示符，
 那么需要自己将其存储到NSUserDefaults, Keychain, Pasteboard或其它地方
 */
- (instancetype)init{
    if(self = [super init]){
    }
    return self;
}
#pragma mark --获取到UUID的，目的是为了利用其唯一性，来给后台数据库中的一些用户表来标识，并确保其唯一性--/
//最近项目开发,运用到要获取UUID转MD5,但是iOS7不能使用获取的UDID的接口（涉及到隐私），获取MAC地址的方式的接口在iOS7下也废弃了.目前可能的就是获取UUID了,但是在iOS7下,UUID一个不好的地方是每次调用一次，生成的就不一样，这个会导致一旦APP卸载重装，UUID就变了.
/*
 大多数应用都会用到苹果设备的UDID号，UDID通常有以下两种用途：
 1）用于一些统计与分析目的；【第三方统计工具如友盟，广告商如ADMOB等】
 2）将UDID作为用户ID来唯一识别用户，省去用户名，密码等注册过程。
 */
- (NSString *)getUUID{
    //284C1635-D620-43B6-B1F8-A4C401DC13E0
    CFUUIDRef cfuuid = CFUUIDCreate(nil);
    NSString *cfuuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(nil, cfuuid));
    /*
     虽然UUID是官方提出的一种替代UDID的建议方案,但网上有资料说UUID不能保证在以后的系统升级后(IOS6,7)还能用.
     经过我测试目前,UUID在IOS4和IOS5下均可以使用,而且UUID每次生成的值都不一样,需要开发者自行保存UUID.
     如果使用UUID为标识保存用户的资料在网络上,当用户重装软件后,UUID的值就可能会发生改变(基本上可说是百分百会发生改变),用户则无法重新下载原来的网络资料.
     */
    return cfuuidString;
}
#pragma mark ---iOS的keychain服务提供了一种安全的保存私密信息（密码，序列号，证书等）的方式，每个iOS程序都有一个独立的keychain存储。相对于NSUserDefaults、文件保存等一般方法，keychain保存更为安全，而且keychain里保存的信息不会因app被删除而丢失，所以在重装app后，keychain里的数据还能使用。从iOS3.0开始，跨程序分享keychain变得可行---
@end
