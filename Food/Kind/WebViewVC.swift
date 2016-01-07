//
//  WebViewVC.swift
//  Food
//
//  Created by 谷建兴 on 16/1/6.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class WebViewVC: UIViewController {
    
    var url:String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false
        
        let webview = UIWebView(frame: CGRectMake(0, 0, WIDTH, HEIGHT))
//        webview.scalesPageToFit = true
        let request = NSURLRequest(URL: NSURL(string: self.url)!)
        webview.loadRequest(request)
        self.view.addSubview(webview)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
