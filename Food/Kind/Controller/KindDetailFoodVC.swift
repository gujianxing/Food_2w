//
//  KindDetailFoodVC.swift
//  Food
//
//  Created by 谷建兴 on 15/12/30.
//  Copyright © 2015年 gujianxing. All rights reserved.
//

import UIKit

class KindDetailFoodVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate {
    var id:String = String()
    
    lazy var model:KindDetailFoodModel = {
        var amodel = KindDetailFoodModel()
        return amodel
    }()
    
    
    
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var MainView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //聚合
        let jh = JHOpenidSupplier.shareSupplier()
        jh.registerJuheAPIByOpenId("JHbd494dc0cc99ce603826cfefc35fd3e1")
        self.jhRequest()
        
        //当UITableView.backgroundColor和cell?.backgroundColor同时设为UIColor.clearColor()时 才会透明
        self.MainView.backgroundColor = UIColor.clearColor()
        self.MainView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //开启毛玻璃 设置barTintColor和alpha
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.alpha = 0
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.alpha = 1.0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell")
                cell?.backgroundColor = UIColor.clearColor()
            cell?.selectionStyle = .None
            return cell!
        }else if indexPath.row == 1{
            let cell:KindDetailFoodHeaderCell = tableView.dequeueReusableCellWithIdentifier("foodcell") as! KindDetailFoodHeaderCell
            cell.addDataWithModel(self.model)
            return cell
        }else {
            let cell:KindDetailFoodDoCell = tableView.dequeueReusableCellWithIdentifier("docell") as! KindDetailFoodDoCell
            cell.setValuesWithModelandIndexPath(self.model, indexpath: indexPath)
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //防止运行时错误
        if self.model.steps != nil {
            return (self.model.steps?.count)! + 2
        }else {
            return 10
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //第一个row的高度等于  图片的高度300
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 300
        }else if indexPath.row == 1{
            return 340
        }else {
            return 120
        }
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //导航条动态效果
        if scrollView.contentOffset.y <= (300 - 64) {
            self.navigationController?.navigationBar.alpha = scrollView.contentOffset.y / (300 - 64) * 1.0
        }
        if scrollView.contentOffset.y == (300 - 64) {
            self.navigationController?.navigationBar.translucent = false
        }else {
            self.navigationController?.navigationBar.translucent = true
        }
        //上拉图片缩小(此时contentOffset.y > 0)
        if scrollView.contentOffset.y > 0 {
            self.picture.frame = CGRectMake(0, 0 - scrollView.contentOffset.y * 0.6, WIDTH, 300)
        }
        //下拉图片放大(此时contentOffset.y > 0)
        if scrollView.contentOffset.y < 0 {
            let center = self.picture.center
            self.picture.frame = CGRectMake(0, 0, WIDTH * (-scrollView.contentOffset.y / 200 + 1), 300 * (-scrollView.contentOffset.y / 200 + 1))
            self.picture.center = center
            
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func jhRequest() {
        let path = "http://apis.juhe.cn/cook/queryid"
        let api_id = "46"
        let method = "GET"
        let param = ["dtype":"json","id":self.id]
        let jhAPI = JHAPISDK.shareJHAPISDK()
        
        jhAPI.executeWorkWithAPI(path, APIID: api_id, parameters: param as [NSObject : AnyObject], method: method, success: { (objects) -> Void in
            self.dealWithData(objects)
            }) { (error) -> Void in
                print(error)
        }
    }

    
    func dealWithData(objects:AnyObject) {
        let dic:NSDictionary = objects["result"] as! NSDictionary
        let arr:NSArray = dic["data"] as! NSArray
        let dicFood:NSDictionary = arr[0] as! NSDictionary
        self.model = KindDetailFoodModel()
        self.model.setValuesForKeysWithDictionary(dicFood as! [String : AnyObject])
        
        dispatch_async(dispatch_get_main_queue()) { [weak self]() -> Void in
            if let weakSelf = self {
                weakSelf.MainView.reloadData()
                if weakSelf.model.albums != nil {
                    let url = NSURL(string: weakSelf.model.albums![0] as! String)
                    weakSelf.picture.kf_setImageWithURL(url!, placeholderImage: UIImage(named: "back"))
                }
                
            }
        }
    }
    
    
    func requestData() {
        let manager = AFHTTPRequestOperationManager()
        manager.GET("http://apis.juhe.cn/cook/queryid?key=6835098e6656cfaf74320c786833c650&id=\(self.id)", parameters: nil, success: { (operation, objects) -> Void in
            self.dealWithData(objects)
            }) { (operation, error) -> Void in
                
        }
        
    }
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
