//
//  ViewController.swift
//  Food
//
//  Created by 谷建兴 on 15/12/30.
//  Copyright © 2015年 gujianxing. All rights reserved.
//

import UIKit
let WIDTH = UIScreen.mainScreen().bounds.size.width
let HEIGHT = UIScreen.mainScreen().bounds.size.height
let BLUE = UIColor(colorLiteralRed: 115 / 255.0, green: 208/255.0, blue: 251/255.0, alpha: 1.0)
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

