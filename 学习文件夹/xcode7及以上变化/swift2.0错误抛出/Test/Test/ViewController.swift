//
//  ViewController.swift
//  Test
//
//  Created by lizhongqiang on 15/12/18.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let str = "CellID"
    var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView = UITableView(frame: self.view.bounds,style: .Plain);
        self.view.addSubview(tableView)
        tableView.separatorStyle = .None
        //tableView.registerClass(Cell.self, forCellReuseIdentifier: str)
        tableView.delegate = self
        tableView.dataSource = self
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:Cell! = tableView.dequeueReusableCellWithIdentifier(str) as? Cell//注意这里cell:后面需要跟上:cell!另外，也需要注意as? cell里的as后面需要跟上？
        // var cell = tableView.dequeueReusableCellWithIdentifier(str) as! Cell
        if cell == Optional.None{
            cell = Cell(style: .Default, reuseIdentifier: str)
            cell.setNeedsDisplay()
        }
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

