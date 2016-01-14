//
//  SubView.m
//  事件传送机制
//
//  Created by lizhongqiang on 15/12/11.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "SubView.h"
@interface SubView()
@property (nonatomic, assign)BOOL istransform;
@end
@implementation SubView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    return [super pointInside:point withEvent:event];
}
//uiview/uiimageview默认是不接受点击事件的，如果想要实现touch方法被调用的话，需要设置userInteractionEnabled=YES
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{/*
  我们在重写TouchesEvents的时候，如果不想让响应链继续传递，就不调用super对应的实现就可以了，相反，有些时候你只需要做一个小改变，如上所示，但是你不想中断响应链，你就需要调用父类对应的实现。
  */
    NSLog(@"%s",__func__);
    //self.istransform = YES;
    //如果想把事件往下（往父视图下一个responder传递），则调用super相对应方法
    [super touchesBegan:touches withEvent:event];
}
#pragma mark --- 注意先每次有事件发生的时候，先调用hitTest：withEvent：方法，然后确定其返回值，如果返回值是nil，则方法touchesBegan与pointInside:都不会被调用，
#if 1
//默认的hit-testing顺序是按照UIView中Subviews的逆顺序(最上层的subview,往最底层的superView传递，一直到uiapplication,如果中间有断开，则事件中断，比如imageView--BOOL userInteractionEnabled;  // default is No，)
//注意UIView--BOOL userInteractionEnabled;  // default is YES
//如果View的同级别Subview中有重叠的部分，则优先检查顶部的Subview，如果顶部的Subview返回nil， 再检查底部的Subview
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    //NSLog(@"%d",[self pointInside:point withEvent:event]);
    if(!self.istransform){
        return [super hitTest:point withEvent:event];
    }
    return nil;
}
/*
 当一个View收到hitTest消息时，会调用自己的pointInside:withEvent:方法,如果pointInside返回YES，则表明触摸事件发生在我自己内部，则会遍历自己的所有Subview去寻找最小单位(没有任何子view)的UIView，如果当前View.userInteractionEnabled = NO,enabled=NO(UIControl),或者alpha<=0.01, hidden等情况的时候，hitTest就不会调用自己的pointInside了，直接返回nil，然后系统就回去遍历兄弟节点(及相对于superView的同级别SubView)。
 */
#endif
@end
