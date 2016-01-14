//
//  XIArrowView.h
//  UIBezierPathSymbol_Demo
//
//  Created by yxlong on 15/7/9.
//  Copyright (c) 2015年 Kjuly. All rights reserved.
//

#import <UIKit/UIKit.h>

// Direction
typedef enum {
    ArrowDirectionRight,
    ArrowDirectionLeft,
    //ArrowDirectionUp,
    //ArrowDirectionDown
}ArrowDirection;

@protocol XIArrowSetting <NSObject>

@property(nonatomic, assign) ArrowDirection arrowDirection;
@property(nonatomic, strong) UIColor *strokeColor;
@property(nonatomic, strong) UIColor *highlightedStrokeColor;
@property(nonatomic, assign) CGFloat lineWidth;

@end

@interface XIArrowView : UIView<XIArrowSetting>
@property(nonatomic, assign) BOOL highlighted;
@end

@interface XIArrowButton : UIButton<XIArrowSetting>
@end


