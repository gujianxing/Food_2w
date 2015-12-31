//
//  KindVC.swift
//  Food
//
//  Created by 谷建兴 on 15/12/30.
//  Copyright © 2015年 gujianxing. All rights reserved.
//

import UIKit

class KindVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    let CELLWIDTH = (WIDTH - 50) / 4
    let CELLHEIGHT = (WIDTH - 50) / 8
    lazy var dataSource:NSMutableArray = {
        var source = NSMutableArray()
        return source
    }()
    lazy var listSource:NSMutableArray = {
        var source = NSMutableArray()
        return source
    }()
    

    @IBOutlet weak var MainView: UICollectionView!
    @IBOutlet weak var ListView: UICollectionView!
    
    var first = 0
    var frame = CGRectZero
    override func viewDidLoad() {
        super.viewDidLoad()
        //聚合
        let jh = JHOpenidSupplier.shareSupplier()
        jh.registerJuheAPIByOpenId("JHbd494dc0cc99ce603826cfefc35fd3e1")
        self.jhRequest()
        
        //collectionview添加约束时 要选择top view和bottom view
        //collectionview.frame所获取到的frame  高度比真实的frame低64
        self.MainView.backgroundView = UIImageView(image: UIImage(named: "back"))
        let effect = UIBlurEffect(style: .Light)
        let effectView = UIVisualEffectView(effect: effect)
        let a = self.MainView.frame
        effectView.frame = CGRectMake(0, 0, a.width, a.height + 64)
        self.MainView.backgroundView?.addSubview(effectView)
        
    }
    
    //自定义cell可以直接在storyboard中完成 但是比较乱 最好使用xib
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView == self.MainView {
            let cell:KindCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! KindCell
            let model:KindModel = self.dataSource[indexPath.row] as! KindModel
            cell.Title.text = model.name
            return cell

        }else {
            let cell:KindListCell = collectionView.dequeueReusableCellWithReuseIdentifier("listcell", forIndexPath: indexPath) as! KindListCell
            let dic:NSDictionary = self.listSource[indexPath.row] as! NSDictionary
            cell.title.text = dic["name"] as? String
            //cell动态效果   初始化cell的时候获取frame并设置为0
            cell.backgroundColor = UIColor.lightGrayColor()
            cell.title.textColor = UIColor.whiteColor()
            self.frame = cell.frame
            cell.frame = CGRectMake(0, 0, 0, 0)
            return cell
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.MainView {
            return self.dataSource.count
        }else {
            return self.listSource.count
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView == self.MainView {
            let model:KindModel = self.dataSource[indexPath.row] as! KindModel
            self.listSource = model.list as! NSMutableArray
            self.ListView.reloadData()
        }
    }
    
    //在willDisplayCell方法中设置frame
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView == self.ListView {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                cell.frame = self.frame
                cell.layer.cornerRadius = 10
                cell.layer.masksToBounds = true
            })
        }
    }
    
    //UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let edge = UIEdgeInsetsMake(10, 10, 10, 10)
        return edge
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    //设置不同cell的不同大小
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if collectionView == self.MainView {
            let size = CGSizeMake(CELLWIDTH, CELLHEIGHT)
            return size
        }else {
            let str = self.listSource[indexPath.row]["name"] as! NSString
            if str.length > 4 {
                let size = CGSizeMake(CELLWIDTH , CELLHEIGHT * 2 / 3)
                return size
            }else {
                let size = CGSizeMake(CELLWIDTH * 2 / 3, CELLHEIGHT * 2 / 3)
                return size
            }
        }
        
    }
    
    
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        <#code#>
//    }
//
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        <#code#>
//    }
    
    func jhRequest() {
        let path = "http://apis.juhe.cn/cook/category"
        let api_id = "46"
        let method = "GET"
        let param = ["dtype":"json"]
        let jhAPI = JHAPISDK.shareJHAPISDK()
        
        jhAPI.executeWorkWithAPI(path, APIID: api_id, parameters: param as [NSObject : AnyObject], method: method, success: { (objects) -> Void in
            self.dealWithData(objects)
            }) { (error) -> Void in
                print(error)
                }
    }
    
    
    func dealWithData(objects:AnyObject) {
        let arrs:NSArray = objects["result"] as! NSArray
        for dic in arrs {
            let model = KindModel()
            model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
            self.dataSource.addObject(model)
        }
        self.listSource = self.dataSource[0].list as! NSMutableArray
        dispatch_async(dispatch_get_main_queue()) { [weak self]() -> Void in
            if let weakSelf = self {
                weakSelf.MainView.reloadData()
                weakSelf.ListView.reloadData()
            }
        }
    }
    
    
    
    
//    func requestData() {
//        let request = Request.shareWithRequest()
//        request.getRequestWithString("http://apis.juhe.cn/cook/category?key=6835098e6656cfaf74320c786833c650")
//        request.getRequest = {
//        
//            [weak self] (dic:NSMutableDictionary)->Void in
//        
//            if let weakSelf = self {
//                let arrs:NSArray = dic["result"] as! NSArray
//                for dic in arrs {
//                    let model = KindModel()
//                    model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
//                    weakSelf.dataSource.addObject(model)
//                }
//                weakSelf.listSource = weakSelf.dataSource[0].list as! NSMutableArray
//                //主线程刷新界面  否则异常卡顿
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    weakSelf.MainView.reloadData()
//                    weakSelf.ListView.reloadData()
//                })
//            }
//        }
//        
//        
//    }
    

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        //sender为cell
        let indexpath:NSIndexPath = self.ListView.indexPathForCell(sender as! KindListCell)!
        let detail = segue.destinationViewController as! KindDetialVC
        let dic = self.listSource[indexpath.row]
        detail.cid = dic["id"] as! String
        detail.name = dic["name"] as! String
    }


}
