//
//  WeatherVC.swift
//  Food
//
//  Created by 谷建兴 on 15/12/31.
//  Copyright © 2015年 gujianxing. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController {

    
    @IBOutlet weak var MainView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path:String = NSBundle.mainBundle().pathForResource("wa", ofType: "gif")!
        let gifData:NSData = NSData(contentsOfFile: path)!
        //工厂模式，也就是写一个类方法来生成和返回实例，或者在失败的时候返回 nil
        //webview加载gif的时候无法改变图片的尺寸   所以当我们想要根据不同机型配置不同的图片的时候 先要判断当前的机型
        self.MainView.loadData(gifData, MIMEType: "image/gif", textEncodingName: "", baseURL: NSURL(string: "")!)
        self.MainView.scalesPageToFit = true
        
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
