//
//  InterfaceController.swift
//  WatchKitDemo WatchKit Extension
//
//  Created by lizhongqiang on 15/8/19.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var slider: WKInterfaceSlider!
    @IBOutlet weak var map: WKInterfaceMap!
    @IBOutlet weak var showLabel: WKInterfaceLabel!
    @IBOutlet weak var guessAction: WKInterfaceButton!
    @IBOutlet weak var label: WKInterfaceLabel!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        
        slider.setNumberOfSteps(5)
        slider.setValue(5)
        // Configure interface objects here.
        map.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2DMake(30.541093, 114.360734), span: MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)))
    }

    var fullValue = 3
    
    
    @IBAction func updateGuessValue(var value: Float) {
        
        var str = "你猜的是\(Int(value))"
        //str = String("\(value)")
        
        showLabel.setText(str)
        
        fullValue = Int(value)//Int(roundf(value))//swift将float转换为int类型
        
        value = Float(fullValue)
        
        println("-----\(value)-----")
    }
    /*
    swift语言中 如何把字符串转化为浮点数类型
    let str = "1.66";
    var dbVal = ( str as NSString ).doubleValue;
    var flVal = ( str as NSString ).floatValue;
    */
    
    var radomNumber = Int(arc4random_uniform(6))
    
    @IBAction func startGuess() {
        if(radomNumber == fullValue)
        {
            label.setText("您猜对啦")
        }
        else
        {
            label.setText("您猜错啦")
        }
        println("\(radomNumber)-------\(fullValue)")
    }
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
}
/*
：pirntln()函数  可以 字符串和 变量或常量 直接输出
其中 输出的变量表示方式 \(变量名)  \()变量的占位符，括号里面放变量
复制代码
//println 函数直接输出  变量或常量 字符串

var c = 10

println("c=\(c)")// \() 是占位符  c是变量名

var d = true

println ("d=\(d)") // \() 是占位符 d是变量名
复制代码
运行结果
*/
