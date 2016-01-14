//
//  ViewController.swift
//  iOS唯一标示符
//
//  Created by lizhongqiang on 15/12/15.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

import UIKit
/*
*/
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let cfuuid = CFUUID()
        let str:NSString! = cfuuid.getUUID()
        NSLog("\(str)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

