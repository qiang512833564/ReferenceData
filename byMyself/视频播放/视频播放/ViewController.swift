//
//  ViewController.swift
//  视频播放
//
//  Created by lizhongqiang on 15/8/24.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var actionBtn: UIButton!
    @IBOutlet weak var movieView: UIView!
    
    var player:MPMoviePlayerController!
    var _spinnerView:MozMaterialDesignSpinner!
    var _downloader:MKNetworkOperation!
    var _engine :MKNetworkEngine!
    var _tableVC:TableViewController!
    var _index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // MPMoviePlayerController
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"beginPlayer", name: MPMediaPlaybackIsPreparedToPlayDidChangeNotification, object: nil)//0.87
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"moviePlayerStateDidChange:", name: MPMoviePlayerLoadStateDidChangeNotification, object: nil)
        setUp()
    }
    @IBAction func downloadAction(sender: AnyObject) {
        
        //self .performSegueWithIdentifier("SendValue", sender: self)
        
       //self.navigationController?.pushViewController(_tableVC, animated: true)
        
/*
            let engine = MKNetworkEngine(hostName:"")
            engine.useCache();

            let paths = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true);
            let cachesDirectory:NSString = paths[0] as NSString;
            let downloadPath = cachesDirectory.stringByAppendingPathComponent("picture1.mp4")
        
        
            //判断之前是否下载过 如果有下载重新构造Header
            var newHeadersDict = NSMutableDictionary();
            
            var fileManager = NSFileManager.defaultManager()
            
            
            if (fileManager.fileExistsAtPath(downloadPath))
            {
                var error:NSError!
                let fileSize = fileManager.attributesOfFileSystemForPath(downloadPath, error: nil)
                let headerRange = NSString(string: "bytes=\(fileSize)")
                newHeadersDict.setObject(headerRange, forKey: "Range")
            }
        
        
            var operation = engine.operationWithURLString("http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4")
            
            operation.addDownloadStream(NSOutputStream(toFileAtPath: downloadPath, append:true));
        
            println(downloadPath)
            operation.addHeaders(newHeadersDict)
            engine.enqueueOperation(operation)
            
            //进度回调
            operation.onDownloadProgressChanged { (value) -> Void in
                println(value)
        }
            //结束回调
            operation.addCompletionHandler({ (operation) -> Void in
                
            }, errorHandler: { (operation, error) -> Void in
                println("\(error)")
            })
        */
    }

    func beginPlayer()
    {
        print("开始播放")
        
        _spinnerView.stopAnimating()
        
        
    }
    func moviePlayerStateDidChange(notific:NSNotification)
    {
        
    }
    func setUp()
    {
        player = MPMoviePlayerController()
        player.view.frame = movieView.bounds
        //player.view.backgroundColor = UIColor.redColor();
        movieView.addSubview(player.view)
        
        _spinnerView = MozMaterialDesignSpinner(frame: CGRectMake(0, 0, 60, 60))
        _spinnerView.center = player.view.center
        player.view.addSubview(_spinnerView)
        
       // _spinnerView.backgroundColor = UIColor.redColor()
   /*
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        _tableVC = storyboard.instantiateViewControllerWithIdentifier(NSString(string: "TableViewControllerId")) as TableViewController
        _tableVC.navigationController?.title = NSString(string: "title")
        _tableVC.tableView.backgroundColor = UIColor.redColor()
        _tableVC.navigationController?.navigationBarHidden = true
*/
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "SendValue"
        {
            _tableVC = segue.destinationViewController as! TableViewController
            
            _tableVC.index = _index++
            _tableVC.urlString = NSString(string: "http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4")
        }
    }
//    override func segueForUnwindingToViewController(toViewController: UIViewController, fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue {
//       if identifier == "TableViewControllerId"
//        {
//            _tableVC = toViewController as TableViewController
//           
//            _tableVC.index = _index++
//            _tableVC.urlString = NSString(string: "http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4")
//       }
//        return UIStoryboardSegue(identifier: identifier, source: fromViewController, destination: toViewController)
//    }
    @IBAction func actionPlayer(sender: AnyObject) {
        

        player.contentURL = NSURL(string: "http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4")
//        var error:NSErrorPointer!
//        let dataString = NSString(contentsOfURL: player.contentURL, encoding: NSUTF8StringEncoding, error: error)//NSString(contentsOfURL: player.contentURL, encoding: NSUTF8StringEncoding, error: &error)
//        println(dataString,error.debugDescription)
        player.prepareToPlay()
        
        player.fullscreen = true
        if player.playbackState == .Playing
        {
            _spinnerView.stopAnimating()
        }else
        {
            _spinnerView.startAnimating()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

