//
//  CustomProtocol.swift
//  swift2.0__协议扩展
//
//  Created by lizhongqiang on 15/12/14.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

import UIKit
protocol SomeProtocol {
    //协议内容
//协议能够要求其遵循者必须含有一些特定名称和类型的实例属性或类属性，也能够要求属性的（设置权限）settable和(访问权限)gettable
    var musBeSettable: Int { get set }//通常前置var关键字将属性声明为变量。在属性声明后写上{ get set }表示属性为可读写的。{ get }用来表示属性为可读的。
    var doesNotNeedToBeSettable:Int { get }
//协议能够要求其遵循者必备某些特定的实例方法和类方法。协议方法的声明与普通方法声明相似，但他不需要方法内容
//注意：协议方法支持变量参数，不支持默认参数。
//前置class关键字表示协议中的成员为类成员，当协议用于被枚举或结构体遵循时，则使用static关键字
    static func someTypeMethod()
}
protocol RandomNumberGenerator{
//RandomNumberGenerator协议要求其遵循者必须拥有一个名为random， 返回值类型为Double的实例方法。
    func random()->Double
}
protocol AnotherProtocol{
    static var someTypeProperty:Int { get set }
}
protocol FullyName {
    var fullName:String { get }
    func myNameIsWhat()->String;
}
//MARK: 在类，结构体，枚举的名称后加上协议名称，中间以冒号：分隔
struct Person:FullyName{
    var fullName:String//FullyNamed协议含有fullName属性。因此其遵循者必须含有一个名为fullName，类型为String的可读属性。
    func myNameIsWhat() -> String {
        return self.fullName
    }
}
let john = Person(fullName: "John Appleseed")

class CustomProtocol: NSObject,FullyName {
    var prefix:String?
    var name:String
    init(name:String, prefix:String?=nil){
        self.name = name
        self.prefix = prefix
        
        let generator = linearCongruentialGenerator()
        print("Here's a random number: \(generator.random())")
        // 输出 : "Here's a random number: 0.37464991998171"
        print("And another one: \(generator.random())")
        //
        print(Person(fullName: "myFullName is zhang !").myNameIsWhat())
    }
    var fullName:String{
        return (prefix!+" ")+name
    }
    func myNameIsWhat() -> String {
        return self.fullName
    }
    
    
}
class linearCongruentialGenerator:RandomNumberGenerator{
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random()->Double{
        lastRandom = ((lastRandom*a+c)%m)
        return lastRandom/m
    }
}
