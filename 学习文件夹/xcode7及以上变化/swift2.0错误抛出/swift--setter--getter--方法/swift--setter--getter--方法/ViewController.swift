//
//  ViewController.swift
//  swift--setter--getter--方法
//
//  Created by lizhongqiang on 15/12/17.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let test = Test()
        //test.name = "your name"
        //print("\(test.name)")
        test.age = 10
        test.change()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

