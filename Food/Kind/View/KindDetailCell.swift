//
//  KindDetailCell.swift
//  Food
//
//  Created by 谷建兴 on 15/12/30.
//  Copyright © 2015年 gujianxing. All rights reserved.
//

import UIKit

class KindDetailCell: UICollectionViewCell {
    
    @IBOutlet weak var picture: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    func setValuesWithModel(model:KindDetailModel) {
        let str:String = model.albums?.firstObject as! String
        self.picture.kf_setImageWithURL(NSURL(string: str)!, placeholderImage: nil)
        self.title.text = model.title
    }
    
}
