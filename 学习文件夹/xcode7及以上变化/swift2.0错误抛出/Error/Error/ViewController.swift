//
//  ViewController.swift
//  Error
//
//  Created by lizhongqiang on 15/12/1.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

import UIKit
/*
throws关键字来标记出可能抛出错误的函数。
throw则在发生错误用来抛出错误的。
这里抛出错误，这个错误可以在4中被捕获到
do用来包裹可能捕获到错误的代码块。（do-catch语句来对错误进行捕获）
try关键字来对可能抛出错误的方法进行调用（对于一个可能抛出错误的方法，需要使用try关键字来调用它，由于要将错误再次抛出，所以同时使用throws关键字来表明我们不准备处理这个错误）
*/
enum DrinkError:ErrorType{
    case NoBeerRemainingError
}
struct MyErrorStruct:ErrorType {
    var _domain:String
    var _code:Int
    init(){
     _domain = "zs"
     _code = 1
    }
}
class ViewController: UIViewController {
    var beer:Beer!
    func catchError()throws{
        //1.
        //        if beer.isAvailable(){
        //
        //        }else{
        //            throw DrinkError.NoBeerRemainingError
        //        }
        //2.guard有点像if
        /*
        区别：
        guard必须强制有else语句
        只有在guard审查的条件成立，guard之后的代码才会运行
        guard 中的 else 只能执行转换语句，像 return, break, continue 或者 throws 当然你也可以在这里返后一个函数或者方法。
        值得注意的是，guard的使用会提高你代码的可读性，但是也代表你的代码的执行会有非常明确的顺序性，这一点需要开发者们留心处理。
        guard具有广泛的适用性
        */
        var errorString = MyErrorStruct()
        errorString._domain = "我是一个错误描述"
        guard beer.isAvailable() else{
            //throw DrinkError.NoBeerRemainingError//后面如果再跟return--则不会被执行
            throw errorString//-----这里抛出的错误，可以是遵循ErrorType的任何类型数据（注意：NSError也是遵循ErrorType的）
        }
    }
    func drinkWithError() throws -> String{
       
        
        try catchError()//----有错误发生，被抛出，下面的语句就不会被执行
        return "Could not drink beer!:{";
    }
    func functionThrowErrorNil() throws{
    }
    
    func tryToDrink(error:String){
        //4
        
        var systemAttributes: String? = nil
        do{
            systemAttributes = try drinkWithError()
            //如果报错：
            //Errors thrown from here are not handled because the enclosing catch is not exhaustive
            //则表示：错误没有被完全捕获，因为catch后面加的条件不足，一般需要最后再加一个catch{}
        }catch let error as MyErrorStruct{//let error
            print("\(error)-----\(error._domain)")
            
/*
            //这里如果需要加对不同错误进行不同处理，则需要catch后面加错误的类型-----没有捕获到throw抛出的错误{里面的语句不会被执行}
            //print("\(systemAttributes)")
            print("\(systemAttributes)")
            systemAttributes = nil;
*/
        }catch{
        }
        do{
            try! functionThrowErrorNil()//-----不对错误进行处理----需要注意的是方法functionThrowErrorNil中不能用throw抛出异常
        }
        print("\(systemAttributes)")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        beer = Beer()
        var error:String!=String()
        self.tryToDrink(error)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func mycustomError(error:NSError!){
        //let userInfo = NSDictionary(dictionaryLiteral: [NSLocalizedDescriptionKey:"is a error test"])
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

