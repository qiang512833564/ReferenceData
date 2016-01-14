//
//  InterfaceController.swift
//  LinkingiWatchToiPhone WatchKit Extension
//
//  Created by lizhongqiang on 15/8/20.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didReceiveMessageNotification", name: "notification", object: nil)
    }
    func didReceiveMessageNotification()
    {
        println("收到消息")
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
