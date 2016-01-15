//
//  CTFrameParser.h
//  图文混排Test
//
//  Created by lizhongqiang on 16/1/13.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreTextData.h"
#import "CTFrameParserConfig.h"
@interface CTFrameParser : NSObject
+ (NSDictionary *)attributesWithConfig:(CTFrameParserConfig *)config;
+ (CoreTextData *)parseContent:(NSString *)content config:(CTFrameParserConfig*)config;
+ (CoreTextData *)parseAttributedContent:(NSAttributedString *)content config:(CTFrameParserConfig*)config;
+ (CoreTextData *)parseTemplateFile:(NSString *)path config:(CTFrameParserConfig*)config ;
+ (NSAttributedString *)loadTemplateFile:(NSString *)path config:(CTFrameParserConfig*)config;
+ (NSAttributedString *)parseAttributedContentFromNSDictionary:(NSDictionary *)dict config:(CTFrameParserConfig*)config;
+ (UIColor *)colorFromTemplate:(NSString *)name;
@end
