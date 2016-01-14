//
//  ViewController.swift
//  折线图swift
//
//  Created by lizhongqiang on 15/9/6.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var chartView = LineChartView()
        chartView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        chartView.backgroundColor = UIColor.whiteColor()
        chartView.points = [["x":1.53,"y":2],["x":2.2,"y":4.5],["x":3.2,"y":3.4],["x":4.3,"y":3.7]];
        self.view.addSubview(chartView);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

