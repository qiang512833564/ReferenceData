//
//  TableViewController.swift
//  视频播放
//
//  Created by lizhongqiang on 15/8/25.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

import UIKit



class TableViewController: UITableViewController,ASIHTTPRequestDelegate {

    var urlString:NSString!
    var index = 0
    let cellId = NSString(string: "cellId")
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.view.backgroundColor = UIColor.purpleColor()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //self.tableView.registerNib(UINib(nibName:"UITableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }
    override func viewDidAppear(animated: Bool) {
        print("\(self.urlString)------\(self.index)")
//        //self.tableView.reloadData()
//        var indexPaths = NSIndexPath(index: 0)
//        //self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Middle)
//        self.tableView.insertRowsAtIndexPaths([indexPaths], withRowAnimation: .Middle)
        download()
    }
    func download()
    {
        var queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(queue, { () -> Void in
            let webPath = NSHomeDirectory().stringByAppendingString("Library/Private Documents/Temp")//stringByAppendingPathComponent("Library/Private Documents/Temp")
            let cachePath = NSHomeDirectory().stringByAppendingString("Library/Private Documents/Cache")
            let fileManager:NSFileManager! = NSFileManager.defaultManager()
            if !fileManager.fileExistsAtPath(cachePath)
            {
                //fileManager.createDirectoryAtPath(cachePath as NSString, withIntermediateDirectories: true, attributes: nil, error: nil)
                //fileManager.createDirectoryAtPath(webPath, withIntermediateDirectories: true, attributes: nil, error: nil)
            }//webPath与cachePath两个文件夹必须同时存在，下载先往webPath下载，然后下载完成了，再剪贴（和解压）到cachePath文件夹上去
            //经测试，默认是4个任务，同时下载
            
            var request = ASIHTTPRequest(URL: NSURL(string: self.urlString as String))
            request.downloadDestinationPath = cachePath.stringByAppendingString("vedio\(self.index).mp4")
            request.temporaryFileDownloadPath = webPath.stringByAppendingString("vedio\(self.index).mp4")
            request.delegate = self
            request.setBytesReceivedBlock { (size, total) -> Void in
                print("\(size)-------\(webPath)------\(cachePath)")
            }
            request.allowResumeForFileDownloads = true
            request.startAsynchronous()
        })
        /*
实现多任务下载：
        很简单，再生成一下asihttprequest，加入队列。前提是你设置好了request的临时存放路径，目的路径和setAllowResumeForFileDownloads为YES。

任务下载的暂停或者开始：
        可以通过，[request clearDelegatesAndCancel]//取消请求
                 开始：创建新的请求，但是要实施记录下载到得位置，然后接着下载
        */
        
        
    }
    func requestStarted(request: ASIHTTPRequest!) {
        print("开始发送请求")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.index
    }
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cellId:NSString! = NSString(string: "cellId")
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId as String, forIndexPath: indexPath) as UITableViewCell
        
        if ( cell == 0)
        {
            cell = UITableViewCell(style:UITableViewCellStyle.Default, reuseIdentifier: cellId as String)
        }
        
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
