//
//  View.swift
//  Test
//
//  Created by lizhongqiang on 15/12/18.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

import UIKit
let lineHeight:CGFloat = 2
class View: UIView {

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(ctx, lineHeight)
        CGContextSetFillColorWithColor(ctx, UIColor.yellowColor().CGColor)
        CGContextMoveToPoint(ctx, 15, 20-lineHeight)//
        CGContextAddLineToPoint(ctx, 320, 20-lineHeight)
        
        //CGContextDrawPath(ctx, .Fill)
        CGContextFillPath(ctx)
    }
}
