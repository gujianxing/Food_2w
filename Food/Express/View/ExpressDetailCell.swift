//
//  ExpressDetailCell.swift
//  Food
//
//  Created by 谷建兴 on 15/12/31.
//  Copyright © 2015年 gujianxing. All rights reserved.
//

import UIKit

class ExpressDetailCell: UITableViewCell {

    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var remarkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
