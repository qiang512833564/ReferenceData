//
//  ViewController.swift
//  Browser
//
//  Created by lizhongqiang on 15/12/15.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//
import UIKit
import WebKit

class ViewController: UIViewController,WKNavigationDelegate {
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var refreshItem: UIBarButtonItem!
    @IBOutlet weak var forwardItem: UIBarButtonItem!

    @IBOutlet weak var backItem: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var barView: UIView!
    
    @IBOutlet weak var urlField: UITextField!
    var webView:WKWebView!
    
    required init(coder aDecoder:NSCoder){
        self.webView = WKWebView(frame: CGRectZero)
        super.init(coder: aDecoder)!
    }
    //MARK:这段代码将在设备方向改变时重新设置barView的大小。
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        barView.frame = CGRectMake(0, 0,size.width, 30)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        barView.frame = CGRect(x:0, y: 0, width: view.frame.width, height: 30)
        progressView.progress = 0
//        toolBar.translatesAutoresizingMaskIntoConstraints = false
//        let constraint = NSLayoutConstraint(item: toolBar, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 1, constant: -44)
//        view.addConstraint(constraint)
        // Do any additional setup after loading the view, typically from a nib.
        //view.addSubview(webView)
        view.insertSubview(webView, belowSubview: progressView)
        webView.backgroundColor = UIColor.redColor()
        //webView.frame = view.bounds
        webView.translatesAutoresizingMaskIntoConstraints = false
        let left = NSLayoutConstraint(item: webView, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: webView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: webView, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 1, constant: -44)
        let width = NSLayoutConstraint(item: webView, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1, constant: 0)
        view.addConstraints([height,width,left,top])
        print("\(webView)\(view)")
        let url = NSURL(string: "http://www.baidu.com")
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        
        webView.addObserver(self, forKeyPath: "loading", options: .New, context: nil)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil)
        self.webView.navigationDelegate = self
        
        backItem.enabled = false
        forwardItem.enabled = false
    }
    @IBAction func backAction(sender: AnyObject) {
        webView.goBack()
    }

    @IBAction func forwardAction(sender: AnyObject) {
        webView.goForward()
    }
    
    @IBAction func refreshAction(sender: AnyObject) {
        let request = NSURLRequest(URL: webView.URL!)
        webView.loadRequest(request)
    }
//MARK:WKNavigationDelegate代理方法
    func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true) { () -> Void in
            
        }
        
    }
//MARK:webView加载完，重置progressView的进度
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        progressView.setProgress(0, animated: false)
    }
//MARK:监听属性的变化，来决定返回与前进按钮是否能够被点击
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if(keyPath == "loading"){
            backItem.enabled = webView.canGoBack
            forwardItem.enabled = webView.canGoForward
        }
        if(keyPath == "estimatedProgress"){
            progressView.hidden = webView.estimatedProgress==1
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
//MARK:UITextFieldDelegate代码
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        urlField.resignFirstResponder()
        let url = NSURL(string:urlField.text!)//给用户输入的url在必要时添加‘http://’前缀
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        return false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

