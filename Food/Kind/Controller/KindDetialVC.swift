//
//  KindDetialVC.swift
//  Food
//
//  Created by 谷建兴 on 15/12/30.
//  Copyright © 2015年 gujianxing. All rights reserved.
//

import UIKit
 
class KindDetialVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    let CELLWIDTH = (WIDTH - 30) / 2
    let CELLHEIGHT = (WIDTH - 30) / 2
    lazy var dataSource:NSMutableArray = {
        var source = NSMutableArray()
        return source
    }()
    //传值的属性 必须初始化
    var cid = String()
    var name = String()
    @IBOutlet weak var MainView: UICollectionView!
    
    var frame = CGRectZero

    override func viewDidLoad() {
        super.viewDidLoad()
        //聚合
        let jh = JHOpenidSupplier.shareSupplier()
        jh.registerJuheAPIByOpenId("JHbd494dc0cc99ce603826cfefc35fd3e1")
        self.jhRequest()
        
        
        self.MainView.backgroundColor = BLUE
        
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell:KindDetailHeaderCell = collectionView.dequeueReusableCellWithReuseIdentifier("detailheader", forIndexPath: indexPath) as! KindDetailHeaderCell
            //初始化 动态cell
            self.frame = cell.frame
            cell.frame = CGRectMake(self.frame.origin.x, -self.frame.size.height , self.frame.size.width, self.frame.size.height)
            cell.title.text = self.name
            return cell
        }else {
            let cell:KindDetailCell = collectionView.dequeueReusableCellWithReuseIdentifier("detailcell", forIndexPath: indexPath) as! KindDetailCell
            //初始化 动态cell
            self.frame = cell.frame
            if indexPath.row % 2 == 1 {
                cell.frame = CGRectMake(self.frame.origin.x - WIDTH / 2, self.frame.origin.y, self.frame.size.width, self.frame.size.height)
            }else {
                cell.frame = CGRectMake(self.frame.origin.x + WIDTH / 2, self.frame.origin.y, self.frame.size.width, self.frame.size.height)
            }
            let model:KindDetailModel = self.dataSource[indexPath.row] as! KindDetailModel
            cell.setValuesWithModel(model)
            return cell
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    //展示cell
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        UIView.animateWithDuration(0.5) { () -> Void in
            cell.frame = self.frame
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
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.row == 0 {
            let size = CGSizeMake(WIDTH - 20, CELLHEIGHT / 2)
            return size
        }else {
            let size = CGSizeMake(CELLWIDTH, CELLHEIGHT)
            return size
        }
    }
    
    func jhRequest() {
        let path = "http://apis.juhe.cn/cook/index"
        let api_id = "46"
        let method = "GET"
        let param = ["dtype":"json","cid":self.cid]
        let jhAPI = JHAPISDK.shareJHAPISDK()
        
        jhAPI.executeWorkWithAPI(path, APIID: api_id, parameters: param as [NSObject : AnyObject], method: method, success: { (objects) -> Void in
            self.dealWithData(objects)
            }) { (error) -> Void in
                print(error)
        }
    }
    
    
    func dealWithData(objects:AnyObject) {
        let dics:NSDictionary = objects["result"] as! NSDictionary
        let arr:NSArray = dics["data"] as! NSArray
        for dicDetail in arr {
            let model = KindDetailModel()
            model.setValuesForKeysWithDictionary(dicDetail as! [String : AnyObject])
            self.dataSource.addObject(model)
        }
        
        dispatch_async(dispatch_get_main_queue()) { [weak self]() -> Void in
            if let weakSelf = self {
                weakSelf.MainView.reloadData()
            }
        }
    }
    
    
    
    
    func requestData() {
        let request = Request.shareWithRequest()
        request.getRequestWithString("http://apis.juhe.cn/cook/index?key=6835098e6656cfaf74320c786833c650&cid=\(self.cid)&rn=30")
        request.getRequest = {
            [weak self] (dic:NSMutableDictionary)->Void in
            if let weakSelf = self {
                
                let dics:NSDictionary = dic["result"] as! NSDictionary
                let arr:NSArray = dics["data"] as! NSArray
                for dicDetail in arr {
                    let model = KindDetailModel()
                    model.setValuesForKeysWithDictionary(dicDetail as! [String : AnyObject])
                    weakSelf.dataSource.addObject(model)
                }
                
                //主线程刷新界面  否则异常卡顿
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    weakSelf.MainView.reloadData()
                    
                })
            }
        }
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let foodVC:KindDetailFoodVC = segue.destinationViewController as! KindDetailFoodVC
        let indexpath:NSIndexPath = self.MainView.indexPathForCell(sender as! KindDetailCell)!
        let model:KindDetailModel = self.dataSource[indexpath.row] as! KindDetailModel
        foodVC.id = model.id!
        
    }
   

}
