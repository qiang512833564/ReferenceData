//
//  ViewController.swift
//  iPhoneToiWatch
//
//  Created by lizhongqiang on 15/8/20.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var myTextfield: UITextField!
    
    @IBOutlet weak var myLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "senderMessage", userInfo: nil, repeats: true)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didReceiveMessageNotification", name: "notification", object: nil)
    }
    @IBAction func saveButtonClicked(sender: AnyObject) {
        let inputedData = self.myTextfield.text
        self.myLabel.text = inputedData
        let userDefaults = NSUserDefaults(suiteName: "group.com.haowu..iPhoneToiWatch")
        userDefaults?.setObject(inputedData, forKey: "shared")
        userDefaults?.synchronize()
    }
    
    func senderMessage()
    {
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "notification", object: nil))
        println("timer")
    }
    

func didReceiveMessageNotification()
{
    println("收到消息")
}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

