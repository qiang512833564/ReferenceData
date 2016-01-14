//
//  InterfaceController.swift
//  iPhoneToiWatch WatchKit Extension
//
//  Created by lizhongqiang on 15/8/20.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet weak var myLabel: WKInterfaceLabel!


    @IBAction func loadButtonClicked() {
        let userDefaults = NSUserDefaults(suiteName: "group.com.haowu..iPhoneToiWatch")
        let data = userDefaults?.stringForKey("shared")
        self.myLabel.setText(data)
    }
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
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
