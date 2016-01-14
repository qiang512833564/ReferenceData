//
//  ViewController.swift
//  LinkingiWatchToiPhone
//
//  Created by lizhongqiang on 15/8/20.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "senderMessage", userInfo: nil, repeats: true)
    
    }

    func senderMessage()
    {
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), "notification", nil, nil, 1)
        println("timer")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

