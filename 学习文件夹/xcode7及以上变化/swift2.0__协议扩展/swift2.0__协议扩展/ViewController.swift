//
//  ViewController.swift
//  swift2.0__协议扩展
//
//  Created by lizhongqiang on 15/12/14.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

import UIKit//RemoteResource

class ViewController: UIViewController,RemoteResource {
    var jsonHost:String!
    var jsonPath:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.load("https://f.hiphotos.baidu.com/image/h%3D200/sign=e7520d120ed162d99aee651c21dea950/3bf33a87e950352a230666de5743fbf2b3118b85.jpg") { (success) -> () in
            
        }
        self.dataForURL("www.baidu.com")
        
        //print("\(self.jsonHost)")
        let song = Song(id: "MYID")
        print("\(song.id)");
        
        let ncc1701 = CustomProtocol(name: "Enterprise", prefix: "USS")
        NSLog("\(ncc1701.fullName)");
        
        let lei = SuddenChange()
        
        
        let enumClass = EnumClass()
        enumClass.test()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


