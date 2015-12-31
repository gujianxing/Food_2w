//
//  KindDetailFoodDoCell.swift
//  Food
//
//  Created by 谷建兴 on 15/12/30.
//  Copyright © 2015年 gujianxing. All rights reserved.
//

import UIKit

class KindDetailFoodDoCell: UITableViewCell {

    
    @IBOutlet weak var picture: UIImageView!
    
    @IBOutlet weak var dosome: UILabel!
    
    
    func setValuesWithModelandIndexPath(model:KindDetailFoodModel,indexpath:NSIndexPath) {
        
        if model.steps != nil {
            let dic:NSDictionary = model.steps![indexpath.row - 2] as! NSDictionary
            self.dosome.text = dic["step"] as? String
            let img:String = (dic["img"] as? String)!
            self.picture.kf_setImageWithURL(NSURL(string: img)!, placeholderImage: nil)
        }

    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
