//
//  View.h
//  model_layer_and_presentation_tree
//
//  Created by lizhongqiang on 16/4/8.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ViewDelegate <NSObject>

- (void)touchAction:(CGPoint)point;

@end
@interface View : UIView
@property (nonatomic, assign) id<ViewDelegate> delegate;
@end
