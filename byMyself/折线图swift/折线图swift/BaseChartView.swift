//
//  BaseChartView.swift
//  折线图swift
//
//  Created by lizhongqiang on 15/9/6.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

import UIKit

class BaseChartView: UIView {

   
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let maxX = (CGRectGetWidth(UIScreen.mainScreen().bounds) - 25)
        
        let ctx = UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(ctx, 25, 120)
        CGContextSetLineWidth(ctx, 0.5);
        CGContextSetStrokeColorWithColor(ctx, UIColor.grayColor().CGColor)
        CGContextAddLineToPoint(ctx, maxX, 120)
        CGContextAddLineToPoint(ctx, maxX, 120+150)
        CGContextAddLineToPoint(ctx, 25, 120+150);
        CGContextClosePath(ctx);
        CGContextStrokePath(ctx)
        
        let lengths:[CGFloat] = [5.0,5.0]
        CGContextSetLineDash(ctx, 0, lengths, 2)
        CGContextMoveToPoint(ctx, 25, 120+150.0/5);
        CGContextAddLineToPoint(ctx, maxX, 120+150/5.0)
        
        CGContextMoveToPoint(ctx, 25, 120+150.0*2/5.0);
        CGContextAddLineToPoint(ctx, maxX, 120+150.0*2/5.0)
        
        CGContextMoveToPoint(ctx, 25, 120+150.0*3/5.0)
        CGContextAddLineToPoint(ctx, maxX, 120+150.0*3/5.0)
        
        CGContextMoveToPoint(ctx, 25, 120+150.0*4/5.0)
        CGContextAddLineToPoint(ctx, maxX, 120+150.0*4/5.0)
        
        CGContextStrokePath(ctx)
        
        var number:CGFloat! = 0.0;
        for  i in 0...9
        {
            number = CGFloat(i);
            let width = ((maxX - 25)/10.0)
            let  x = 25+width*number;
            var point = CGPointMake(x, 120+150+20/2.0)
            var label = self.createLabel(point, text: "\(i)", textAlignment: NSTextAlignment.Left)
            self.addSubview(label)
        }
        number = 0
        for i in 0...5
        {
            number = CGFloat(i)
            let height:(CGFloat!) = 150/5.0
            
            let y:CGFloat = 270-number*height
            let point = CGPointMake(19, y)
            var label = self.createLabel(point, text: "\(i)", textAlignment: .Left)
            self.addSubview(label)
        }

    }
    func createLabel(center:CGPoint!,text:String!,textAlignment:NSTextAlignment!)->UILabel
    {
        var label = UILabel()
        label.center = center
        label.bounds = CGRectMake(0, 0, 10, 10)
        label.text = text;
        label.textAlignment = textAlignment;
        label.backgroundColor = UIColor.clearColor()
        label.textColor = UIColor.grayColor()
        label.font = UIFont.systemFontOfSize(10)
        return label;
    }
    

}
