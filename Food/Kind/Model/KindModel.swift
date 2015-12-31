//
//  KindModel.swift
//  Food
//
//  Created by 谷建兴 on 15/12/30.
//  Copyright © 2015年 gujianxing. All rights reserved.
//

import UIKit

class KindModel: NSObject {
    //Model的属性不用初始化
    var parentId:String?
    var name:String?
    var list:NSArray?
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}
