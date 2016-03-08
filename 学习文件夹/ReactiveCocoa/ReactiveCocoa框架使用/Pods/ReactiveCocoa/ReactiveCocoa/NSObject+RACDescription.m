//
//  NSObject+RACDescription.m
//  ReactiveCocoa
//
//  Created by Justin Spahr-Summers on 2013-05-13.
//  Copyright (c) 2013 GitHub, Inc. All rights reserved.
//

#import "NSObject+RACDescription.h"
#import "RACTuple.h"

@implementation NSObject (RACDescription)

- (NSString *)rac_description {
    //getenv是函数名，从环境中取字符串,获取环境变量的值，getenv()用来取得参数envvar环境变量的内容。
	if (getenv("RAC_DEBUG_SIGNAL_NAMES") != NULL) {
		return [[NSString alloc] initWithFormat:@"<%@: %p>", self.class, self];
	} else {
		return @"(description skipped)";
	}
}

@end

@implementation NSValue (RACDescription)

- (NSString *)rac_description {
	return self.description;
}

@end

@implementation NSString (RACDescription)

- (NSString *)rac_description {
	return self.description;
}

@end

@implementation RACTuple (RACDescription)

- (NSString *)rac_description {
	if (getenv("RAC_DEBUG_SIGNAL_NAMES") != NULL) {
		return self.allObjects.description;
	} else {
		return @"(description skipped)";
	}
}

@end
