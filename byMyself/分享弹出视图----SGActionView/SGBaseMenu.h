//
//  SGBaseMenu.h
//  SGActionView
//
//  Created by Sagi on 13-9-18.
//  Copyright (c) 2013年 AzureLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGActionView.h"

//#define O_COLOR [UIColor colorWithRed:218./255. green:98./255. blue:77./255. alpha:1.]
#define O_COLOR [UIColor blackColor]

#define BaseMenuBackgroundColor(style)  (style == SGActionViewStyleLight ? [UIColor colorWithWhite:1.0 alpha:1.0] : [UIColor colorWithWhite:0.2 alpha:1.0])
#define BaseMenuTextColor(style)        (style == SGActionViewStyleLight ? O_COLOR : [UIColor lightTextColor])
#define BaseMenuActionTextColor(style)  ([UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0])

@interface SGButton : UIButton
@end

@interface SGBaseMenu : UIView{
    SGActionViewStyle _style;
}

// if rounded top left/right corner, default is YES.
@property (nonatomic, assign) BOOL roundedCorner;

@property (nonatomic, assign) SGActionViewStyle style;

@end
