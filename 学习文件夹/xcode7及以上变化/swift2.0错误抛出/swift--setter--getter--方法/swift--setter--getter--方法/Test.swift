//
//  Test.swift
//  swift--setter--getter--方法
//
//  Created by lizhongqiang on 15/12/17.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

import UIKit

class Test: NSObject {
    var _name:String!
    var name:String{
        get{
            return _name!
        }
        set(newName){
            _name = newName
            print("----()----")
        }
    }
    var age:Int = 0{
//        get{
//            return self.age
//MARK:在Swift语言中用了willSet和didSet这两个特性来监视属性的除初始化之外的属性值变化
        willSet(newValue){//需要在age属性变化前做点什么
            print("newValue\(newValue)")
            self.read()
            
        }
        //didSet与get、set可能不能同时存在
        didSet(oldValue){//我们需要在属性变化后，做点什么
           print("age filed changed form \(oldValue) to \(age)")
          
        }
//        set{
//        }
    }
    var label:UILabel!{
        
        willSet{
            print("\(label)")
        }
        didSet{
            print("\(label)")
        }
//        get{
//            return self.label
//        }
//        set(newLabel){
//            self.label = newLabel
//            print("\(newLabel)")
//        }
    }
    var lable2:UILabel{
        get{
            self.lable2 = UILabel(frame: CGRectZero);
            return self.lable2
        }
        set{
            
        }
    }
    func read(){
        print("dadadadadad")
    }
    override init() {
        super.init()
        print("\(self.age)")
        label = UILabel(frame: CGRectZero)//init()方法，里面调不出来self,从而导致self的对象方法无法被调用，如其属性的setter与getter方法，无法被调用
    }
    func change(){
        self.age = 100
        //print("change:----\(self.label)")
        self.label = UILabel(frame: CGRectZero)
        
        print("\(lable2)")
    }

}
