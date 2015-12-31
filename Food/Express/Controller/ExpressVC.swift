//
//  ExpressVC.swift
//  Food
//
//  Created by 谷建兴 on 15/12/31.
//  Copyright © 2015年 gujianxing. All rights reserved.
//

import UIKit

class ExpressVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    lazy var dataSource:NSMutableArray = {
        var source = NSMutableArray()
        return source
    }()
    
    @IBOutlet weak var MainView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //聚合
        let jh = JHOpenidSupplier.shareSupplier()
        jh.registerJuheAPIByOpenId("JHbd494dc0cc99ce603826cfefc35fd3e1")
        self.jhRequest()
        
        
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:ExpressCell = tableView.dequeueReusableCellWithIdentifier("expresscell") as! ExpressCell
        cell.title.text = self.dataSource[indexPath.row]["com"] as? String
        return cell
    }
    
    
    
    func jhRequest() {
        let path = "http://v.juhe.cn/exp/com"
        let api_id = "43"
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
        self.dataSource = objects["result"] as! NSMutableArray
        dispatch_async(dispatch_get_main_queue()) { [weak self]() -> Void in
            if let weakSelf = self {
                weakSelf.MainView.reloadData()
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
        let detailVC:ExpressDetailVC = segue.destinationViewController as! ExpressDetailVC
        let index:NSIndexPath = self.MainView.indexPathForCell(sender as! ExpressCell)!
        let str:String = self.dataSource[index.row]["no"] as! String
        detailVC.com = str
    }

}
