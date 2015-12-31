//
//  ExpressDetailVC.swift
//  Food
//
//  Created by 谷建兴 on 15/12/31.
//  Copyright © 2015年 gujianxing. All rights reserved.
//

import UIKit

class ExpressDetailVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    lazy var dataSource:NSMutableArray = {
        var source = NSMutableArray()
        return source
    }()
    
    
    @IBOutlet weak var theNumber: UITextField!
    
    @IBOutlet weak var company: UILabel!
    
    @IBOutlet weak var number: UILabel!
    
    @IBOutlet weak var MainView: UITableView!
    
    
    var com:String = String()
    
    //label只需设置宽或高就行
    override func viewDidLoad() {
        super.viewDidLoad()
        //聚合
        let jh = JHOpenidSupplier.shareSupplier()
        jh.registerJuheAPIByOpenId("JHbd494dc0cc99ce603826cfefc35fd3e1")
        
        
        
    }
    
    
    @IBAction func buttonAction(sender: AnyObject) {
        self.jhRequest()

    }
    
    
    
    func jhRequest() {
        
        let path = "http://v.juhe.cn/exp/index"
        let api_id = "43"
        let method = "GET"
        let param = ["com":self.com,"no":self.theNumber.text!]
        let jhAPI = JHAPISDK.shareJHAPISDK()
        
        jhAPI.executeWorkWithAPI(path, APIID: api_id, parameters: param as [NSObject : AnyObject], method: method, success: { (objects) -> Void in
            self.dealWithData(objects)
            }) { (error) -> Void in
                print(error)
        }
    }
    
    
    func dealWithData(objects:AnyObject) {
        let dic:NSDictionary = objects["result"] as! NSDictionary
        let company:String = dic["company"] as! String
        let no:String = dic["no"] as! String
        self.dataSource = dic["list"] as! NSMutableArray
        dispatch_async(dispatch_get_main_queue()) { [weak self]() -> Void in
            if let weakSelf = self {
                weakSelf.company.text = company
                weakSelf.number.text = no
                weakSelf.MainView.reloadData()
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:ExpressDetailCell = tableView.dequeueReusableCellWithIdentifier("cell") as! ExpressDetailCell
        let time:String = self.dataSource[indexPath.row]["datetime"] as! String
        let remark:String = self.dataSource[indexPath.row]["remark"] as! String
        cell.timeLabel.text = time
        cell.remarkLabel.text = remark
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
