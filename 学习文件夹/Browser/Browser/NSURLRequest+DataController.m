//
//  NSURLRequest+DataController.m
//  Browser
//
//  Created by lizhongqiang on 15/12/16.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "NSURLRequest+DataController.h"

@implementation NSURLRequest (DataController)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
    return YES;
}
@end
