//
//  Model.swift
//  swift2.0__协议扩展
//
//  Created by lizhongqiang on 15/12/14.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

import UIKit

//MARK: -------
protocol RemoteResource{}
protocol JSONResource:RemoteResource{
    var jsonHost:String{ get }//只读，不能调用set方法
    var jsonPath:String{ get }
    func processJSON(success:Bool)
}
protocol MediaResource:RemoteResource{
    var mediaHost:String{ get }
    var mediaPath:String{ get }
}

//MARK: -------
extension RemoteResource{
    func load(url:String, completion:((success:Bool)->())?){
        print("Performing request:",url)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!) { (data, response, error) -> Void in
            if let httpResponse = response as? NSHTTPURLResponse where error == nil && data != nil {
                print("Response Code:%d",httpResponse.statusCode)
                
                dataCache[url]=data
                if let c = completion{
                    c(success: true)
                }else{
                    print("Request Error")
                    if let c=completion{
                        c(success: false)
                    }
                }
            }
            
        }
        task.resume()
    }
    func dataForURL(url:String)->NSData?{
        return dataCache[url];
    }
}


extension JSONResource {
    var jsonHost:String{ return "api.pearmusic.com" }
    var jsonURL:String{ return String(format:"http://%@%@",self.jsonHost,self.jsonPath)}
    func loadJSON(completion:(()->())?){
        self.load(self.jsonURL) { (success) -> () in
            self.processJSON(success)
            
            if let c = completion{
                dispatch_async(dispatch_get_main_queue(), c)
            }
        }
    }
}

extension MediaResource {
    // Default host value for media resources
    var mediaHost: String { return "media.pearmusic.com" }
    
    // Generate the fully qualified URL
    var mediaURL: String { return String(format: "http://%@%@", self.mediaHost, self.mediaPath) }
    
    // Main loading method
    func loadMedia(completion: (()->())?) {
        self.load(self.mediaURL) { (success) -> () in
            // Execute completion block on the main queue
            if let c = completion {
                dispatch_async(dispatch_get_main_queue(), c)
            }
        }
    }
}

public var dataCache:[String:NSData] = [:]
class Model: NSObject {
}
