//
//  HWHTTPRequestOperationManager.swift
//  SwiftTest
//
//  Created by caijingpeng.haowu on 15/2/2.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述： 十六进制 颜色 函数 exp：“#ffffff”.UIColor
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-02-11           创建文件
//

import UIKit

extension String {

  public var CGColor: CGColorRef {
    return self.CGColor(1)
  }

  public var UIColor: UIKit.UIColor {
    return self.UIColor(1)
  }
  
  public func CGColor (alpha: CGFloat) -> CGColorRef {
    return self.UIColor(alpha).CGColor
  }
  
  public func UIColor (alpha: CGFloat) -> UIKit.UIColor {
    var hex = self
    
    if hex.hasPrefix("#") { // Strip leading "#" if it exists
      hex = hex.substringFromIndex(hex.startIndex.successor())
    }

    switch (hex.characters.count) {
      case 1: // Turn "f" into "ffffff"
        hex = hex.repeatString(6)
      case 2: // Turn "ff" into "ffffff"
        hex = hex.repeatString(3)
      case 3: // Turn "123" into "112233"
        hex = hex[0].repeatString(2) + hex[1].repeatString(2) + hex[2].repeatString(2)
      default:
        break
    }
    
   // assert(countElements(hex) == 6, "Invalid hex value")
    
    var r: UInt32 = 0
    var g: UInt32 = 0
    var b: UInt32 = 0
    
    NSScanner(string: "0x" + hex[0...1]).scanHexInt(&r)
    NSScanner(string: "0x" + hex[2...3]).scanHexInt(&g)
    NSScanner(string: "0x" + hex[4...5]).scanHexInt(&b)
    
    let red = CGFloat(Int(r)) / CGFloat(255.0)
    let green = CGFloat(Int(g)) / CGFloat(255.0)
    let blue = CGFloat(Int(b)) / CGFloat(255.0)
    
    return UIKit.UIColor(red: red, green: green, blue: blue, alpha: alpha)
  }
}

private extension String {
  
  func repeatString (count: Int) -> String {
    return "".stringByPaddingToLength((self.characters.count) * count, withString: self, startingAtIndex:0)
  }
  
  subscript (i: Int) -> String {
    return String(Array(arrayLiteral: self)[i])
  }
  //substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
  subscript (r: Range<Int>) -> String {
    return substringWithRange(Range(start: startIndex.advancedBy(r.startIndex), end: startIndex.advancedBy( r.endIndex)))
  }
}
