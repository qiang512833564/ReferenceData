//
//  CTDisplayView.h
//  图文混排Test
//
//  Created by lizhongqiang on 16/1/13.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreTextData.h"
#import "UIView+frameAdjust.h"
@interface CTDisplayView : UIView

@property (strong, nonatomic) CoreTextData *data;

@end
