//
//  CoreTextImageData.h
//  图文混排Test
//
//  Created by lizhongqiang on 16/1/13.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreTextImageData : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic, assign) int position;

//此坐标是CoreText的坐标系，而不是UIKit的坐标系
@property (nonatomic, assign) CGRect imagePosition;
@end
