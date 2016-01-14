//
//  Cell.swift
//  Test
//
//  Created by lizhongqiang on 15/12/18.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

import UIKit
//let lineHeight:CGFloat = 0.5
class Cell: UITableViewCell {
    
    var view:View!
    var custom:Custom!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        view = View(frame:CGRectMake(0, 0, 320, 20))
        view.backgroundColor = UIColor.whiteColor()
        view.setNeedsDisplay()
        //self.contentView.addSubview(view)
        
        custom = Custom(frame: CGRectMake(0,0,320,20))
        self.contentView.addSubview(custom)
        custom.setNeedsDisplay()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        let ctx = UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(ctx, 15, CGRectGetHeight(rect)-lineHeight)//
        CGContextAddLineToPoint(ctx, CGRectGetWidth(rect), CGRectGetHeight(rect)-lineHeight)
        CGContextSetLineWidth(ctx, lineHeight)
        CGContextSetFillColorWithColor(ctx, UIColor.grayColor().CGColor)
        //CGContextDrawPath(ctx, .Fill)
        CGContextFillPath(ctx)
    }

}
