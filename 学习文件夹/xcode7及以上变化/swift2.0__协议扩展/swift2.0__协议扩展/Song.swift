//
//  Song.swift
//  swift2.0__协议扩展
//
//  Created by lizhongqiang on 15/12/14.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

import UIKit

//MARK:　－－－－
protocol Unique{
    var myid:String! { get set }
}
//MARK: 这里用where Self:NSObject语句限定只有在类型为NSObject时才可使用该扩展(即：约束)---不这样做的话，就没办法调用self.init()方法，因为根本没有它的声明。
//MARK: 协议扩展，swift里面叫extension为扩展，对应OC为category
extension Unique where Self:NSObject{
    var id:String{ return "api.pearmusic.com" }
    init(id:String?){
        self.init()
        if let identifier = id {
            self.myid = identifier
        }else{
            self.myid = NSUUID().UUIDString
        }
    }
}
func ==(lhs:Unique,rhs:Unique)->Bool{
    return lhs.myid == rhs.myid
}
extension NSObjectProtocol where Self:Unique{
    func isEqual(object:AnyObject?)->Bool{
        if let o = object as? Unique{
            return o.myid == self.myid
        }
        return false
    }
}
//MARK: JSONResource的扩展
//extension JSONResource where Self:Song{
//    var jsonPath: String { return String(format: "/songs/%@", self.myid) }
//    func processJSON(success:Bool){
//        if let json = self.jsonValue where success {
//            self.title = json["title"] as? String ?? ""
//            self.artist = json["artist"] as? String ?? ""
//            self.streamURL = json["url"] as? String ?? ""
//            self.duration = json["duration"] as? NSNumber ?? 0
//        }
//    }
//}
//MARK: 协议继承

class Song: NSObject,Unique {//JSONResource
    // MARK: - Metadata
    var title: String?
    var artist: String?
    var streamURL: String?
    var duration: NSNumber?
    var imageURL: String?
    
    // MARK: - Unique
    var myid: String!
    
    
}