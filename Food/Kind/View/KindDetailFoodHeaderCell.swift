//
//  KindDetailFoodHeaderCell.swift
//  Food
//
//  Created by 谷建兴 on 15/12/30.
//  Copyright © 2015年 gujianxing. All rights reserved.
//

import UIKit

class KindDetailFoodHeaderCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var tags: UILabel!
    
    @IBOutlet weak var imtro: UILabel!
    
    @IBOutlet weak var ingredients: UILabel!
    
    @IBOutlet weak var burden: UILabel!
    
    func addDataWithModel(model:KindDetailFoodModel) {
        self.title.text = model.title
        self.tags.text = model.tags
        self.imtro.text = model.imtro
        self.ingredients.text = model.ingredients
        self.burden.text = model.burden
        
        
//        //如果强制解析没有值可能会引起运行时错误
//        if model.title != nil {
//            let str:NSString = model.title!
//            //16  17
//            let dic:NSDictionary = [NSFontAttributeName:UIFont.systemFontOfSize(16)]
//            let size = str.sizeWithAttributes(dic as? [String : AnyObject])
//            print(size)
//            self.title.frame = CGRectMake(0, 0, 200, 200)
//        }
//        
//        //如果强制解析没有值可能会一起运行时错误
//        if model.albums != nil {
//            let arr:NSArray = model.albums!
//            let str:String = arr[0] as! String
//        }
        
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
