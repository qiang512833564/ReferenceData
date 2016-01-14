//
//  突变方法要求.swift
//  swift2.0__协议扩展
//
//  Created by lizhongqiang on 15/12/14.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

//MARK: 能在方法或函数内部改变实例类型的方法称为突变方法,在值类型(Value Type)(译者注：特指结构体和枚举)中的的函数前缀加上mutating关键字来表示该函数允许改变该实例和其属性的类型
//Swift默认不允许修改类型，因此需要前置mutating关键字用来表示该函数中能够修改类型
import UIKit
protocol Togglable{
    mutating func toggle()
}
enum OnOffSwitch:Togglable{
    case Off,On
    mutating func toggle() {
        switch self{
        case .Off:
            self = On
        case .On:
            self = Off
        }
    }
}
class SuddenChange: NSObject {
    override init() {
        var linghtSwitch = OnOffSwitch.Off
        linghtSwitch.toggle()
    }
}
