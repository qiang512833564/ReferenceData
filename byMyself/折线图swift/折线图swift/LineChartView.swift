//
//  LineChartView.swift
//  折线图swift
//
//  Created by lizhongqiang on 15/9/6.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

import UIKit

class LineChartView: BaseChartView {
    let width = CGRectGetWidth(UIScreen.mainScreen().bounds)-2*25
    let height = 150
    var points:NSArray!
    var mutablePoints:NSMutableArray!
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        super.drawRect(rect)
        mutablePoints = NSMutableArray()
        mutablePoints.addObject(["x":25,"y":(120+150)])
        let ctx = UIGraphicsGetCurrentContext()
        
        self.points.enumerateObjectsUsingBlock { (anyObject, idx, bool) -> Void in
            let dic:NSDictionary! = anyObject as NSDictionary;
            let numberX = dic["x"]?.floatValue
            let numberY = dic["y"]?.floatValue
            let scaleX = (numberX!/10)
            let scaleY = (numberY!/5)
            
            let x:CGFloat = CGFloat(scaleX*Float(self.width))+25
            let y:CGFloat = (150+120)-CGFloat(scaleY*Float(self.height))
         
            self.mutablePoints.addObject(["x":x,"y":y])
            
            CGContextAddArc(ctx, x, y, 2.1, 0, CGFloat(M_PI*2.0), 1)//1为顺时针，0 为逆时针
            CGContextDrawPath(ctx, kCGPathFillStroke)
        }
        
        
        var path = CGPathCreateMutable()
        self.mutablePoints.enumerateObjectsUsingBlock { (anyObject, idx, bool) -> Void in
            if idx==0
            {
                
            }else
            {
                let dic = anyObject as NSDictionary
                let startDic = self.mutablePoints[idx-1] as NSDictionary
                let startX = startDic["x"]?.floatValue
                let startY = startDic["y"]?.floatValue
                let endX = dic["x"]?.floatValue
                let endY = dic["y"]?.floatValue
                let startPoint = CGPointMake(CGFloat(startX!), CGFloat(startY!))
                let endPoint = CGPointMake(CGFloat(endX!), CGFloat(endY!))
                self.drawLineWithStartPointAndEndPoint(path,startPoint: startPoint, endPoint: endPoint)
            }
        }
    
        
    }
    func drawLineWithStartPointAndEndPoint(path:CGMutablePathRef,startPoint:CGPoint,endPoint:CGPoint)
    {
        var shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 1
        shapeLayer.lineCap = kCALineCapButt
        shapeLayer.strokeColor = UIColor.redColor().CGColor
        
        CGPathMoveToPoint(path, nil, startPoint.x, startPoint.y)
        CGPathAddLineToPoint(path, nil, endPoint.x, endPoint.y)
        
        shapeLayer.path = path
        
        var animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.fromValue = 0
        animation.toValue = 1
        animation.fillMode = kCAFillModeForwards
        
        shapeLayer.addAnimation(animation, forKey: nil)
        
        self.layer.addSublayer(shapeLayer)
    }

}
