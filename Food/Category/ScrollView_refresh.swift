//
//  ScrollView_refresh.swift
//  Food
//
//  Created by 谷建兴 on 15/12/30.
//  Copyright © 2015年 gujianxing. All rights reserved.
//


import Foundation
//导入UIKit库
//extension   扩展关键字
import UIKit


extension UIScrollView {
    func addtheHeader() {
        let picture = UIImageView(frame: CGRectMake(WIDTH / 2 - 40, -30, 30, 30))
        picture.image = UIImage(named: "xialajiantou")
        let label = UILabel(frame: CGRectMake(WIDTH / 2, -30, WIDTH / 2, 30))
        label.text = "下拉刷新"
        self.addSubview(label)
        self.addSubview(picture)
        
        
    }
    
    
    
    
    
}
