//
//  Request.swift
//  New
//
//  Created by 谷建兴 on 15/12/24.
//  Copyright © 2015年 gujianxing. All rights reserved.
//

import UIKit
typealias block = (dic:NSMutableDictionary)->Void

class Request: NSObject {
    var getRequest:block?
    
    var session:NSURLSession?
    
    static let request:Request = Request()
    class func shareWithRequest()->Request {
        return request
    }
    
    
    func getRequestWithString(str:String) {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        self.session = NSURLSession(configuration: config)
        let url:NSURL = NSURL(string: str)!
        let task = self.session!.dataTaskWithURL(url) {  [weak self]  (data, response, error) -> Void in
            if let weakSelf = self {
                do{
                    let dicSource = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSMutableDictionary
                    weakSelf.session!.finishTasksAndInvalidate()
                    weakSelf.getRequest!(dic:dicSource)
                }catch{
                    
                }
            }
        
        }
        task.resume()
    }
    
    /*
    
    let request = Request.shareWithRequest()
    
    request.getRequestWithString("")
    
    request.getRequest = {
    [weak self] (dic:NSMutableDictionary)->Void in
    if let weakSelf = self {
    let dics:NSDictionary = dic["result"] as! NSDictionary
    weakSelf.dataSource = dics["list"] as! NSMutableArray
    //主线程刷新界面  否则异常卡顿
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
    weakSelf.MainTableView.reloadData()
    
    })
    }
    }
    */

    


    
    
}
