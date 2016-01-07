//
//  LittlePictureCell.swift
//  Food
//
//  Created by 谷建兴 on 16/1/4.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class LittlePictureCell: UITableViewCell {
    
    
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var aLabel: UILabel!
    
    func setValuesWithModel(model:NewsScienceModel) {
        self.title.text = model.title
        self.picture.kf_setImageWithURL(NSURL(string: model.imgsrc!)!, placeholderImage: nil)
        self.content.text = model.digest
        
        if model.skipType == "special" {
            self.aLabel.text = "专题"
            self.aLabel.layer.borderWidth = 0.5
            self.aLabel.layer.cornerRadius = 1
            self.aLabel.layer.borderColor = UIColor.redColor().CGColor
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
