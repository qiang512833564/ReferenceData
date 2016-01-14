//
//  枚举类.swift
//  swift2.0__协议扩展
//
//  Created by lizhongqiang on 15/12/29.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

import UIKit
enum UIViewAnimationCurve0:Int{
    case EaseInOut
    case EaseIn
    case EaseOut
    case Linear
    func typeName()-> String{
        return __FUNCTION__
    }
    func description()->String{
        switch self{
        case .EaseInOut:
            return "EaseInOut"
        case .EaseIn:
            return "EaseIn"
        case .EaseOut:
            return "EaseOut"
        case .Linear:
            return "Linear"
        }
    }
}

enum Shape{
    case Dot
    case Circle(radius:Double)
    case Square(Double)
    case Rectangle(width:Double,height:Double)
    func area()->Double{
        switch self{
            case Dot:
                return 0;
            case Circle(let r):
                return M_PI*r*r
            case Square(let l):
                return l*l
            case Rectangle(let w, let h):
                return w*h
        }
    }
}

class EnumClass: NSObject {
    func test(){
        let type = UIViewAnimationCurve0.EaseIn
        
        print(type)//这里打印的时候，调用的是UIViewAnimationCurve0内部的description()方法
        
        var shape = Shape.Dot
        print(shape)
        shape = .Square(2)
        print(shape)
        shape = .Rectangle(width: 3, height: 4)
        print(shape)
        print(shape.area())
        
    }
}
