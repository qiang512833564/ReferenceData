//
//  ViewController.swift
//  SwiftByMySelf
//
//  Created by lizhongqiang on 15/8/18.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

import UIKit

@objc class ViewController: UIViewController,NSURLConnectionDelegate/*在这里声明代理*/{

    override func viewDidLoad() {//override代表重写父类方法
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.redColor()
        
        
        let imageview = UIImageView(frame: CGRectZero)
        
        
        let label = UILabel(frame: CGRectMake(100, 100, 40, 20))
        
        self.view.addSubview(label)
        
        let channel = OCChannel()//swift与OC混编--Objective-C Bridging Header设置你要用的桥头文件路径
        
        label.text = channel.title
        
        imageview.frame = CGRectMake(100, 200, 100, 80)
        
        imageview.backgroundColor = UIColor.purpleColor()
        
        self.view.addSubview(imageview)
        
        let http = AFHTTPRequestOperationManager()
        
//        var connection = NSURLConnection(request: NSURLRequest(URL: NSURL(string: "http://img5q.duitang.com/uploads/item/201302/17/20130217172207_4TVZf.jpeg")!), delegate: self)
        
       
       NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: NSURL(string: "http://img5q.duitang.com/uploads/item/201302/17/20130217172207_4TVZf.jpeg")!), queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
        
        imageview.image = UIImage(data: data)
        
        }
        
        
        
        
        http.GET("http://img5q.duitang.com/uploads/item/201302/17/20130217172207_4TVZf.jpeg", parameters: nil, success: { (operation, responseObject) -> Void in
            
            let data = responseObject as NSData
            
            imageview.image = UIImage(data: data)
            
        }) { (operation, error) -> Void in
            println("\(error)")
        }
        
        //self.view.addConstraint(constraint:NSLayoutConstraint.)
    }

    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        
    }
    
    func connection(connection: NSURLConnection, didReceiveAuthenticationChallenge challenge: NSURLAuthenticationChallenge) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

