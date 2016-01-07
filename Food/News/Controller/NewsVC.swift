//
//  NewsVC.swift
//  Food
//
//  Created by 谷建兴 on 16/1/4.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

//仿网易
import UIKit
//遵循协议
class NewsVC: UIViewController,NewHeaderDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
    lazy var ScrollView:UIScrollView = {
        var scroView = UIScrollView(frame: CGRectMake(0, 40, WIDTH, HEIGHT - 40 ))
        scroView.contentSize = CGSizeMake(WIDTH * 5, HEIGHT - 40)
        scroView.pagingEnabled = true
        return scroView
    }()
    lazy var Headline:UITableView = {
        var tabView = UITableView(frame: CGRectMake(0, 0, WIDTH, HEIGHT - 40 - 64))
        tabView.delegate = self
        tabView.dataSource = self
        tabView.backgroundColor = UIColor.redColor()
        return tabView
    }()
    lazy var Second:UITableView = {
        var tabView = UITableView(frame: CGRectMake(WIDTH, 0, WIDTH, HEIGHT - 40 - 64))
        tabView.delegate = self
        tabView.dataSource = self
        return tabView
    }()
    lazy var Third:UITableView = {
        var tabView = UITableView(frame: CGRectMake(WIDTH * 2, 0, WIDTH, HEIGHT - 40 - 64))
        tabView.delegate = self
        tabView.dataSource = self
        return tabView
    }()
    lazy var Fourth:UITableView = {
        var tabView = UITableView(frame: CGRectMake(WIDTH * 3, 0, WIDTH, HEIGHT - 40 - 64))
        tabView.delegate = self
        tabView.dataSource = self
        return tabView
    }()
    lazy var Fifth:UITableView = {
        var tabView = UITableView(frame: CGRectMake(WIDTH * 4, 0, WIDTH, HEIGHT - 40 - 64))
        tabView.delegate = self
        tabView.dataSource = self
        return tabView
    }()
    
    lazy var dataSource1:NSMutableArray = {
        var source = NSMutableArray()
        return source
    }()
    lazy var dataSource2:NSMutableArray = {
        var source = NSMutableArray()
        return source
    }()
    lazy var dataSource3:NSMutableArray = {
        var source = NSMutableArray()
        return source
    }()
    lazy var dataSource4:NSMutableArray = {
        var source = NSMutableArray()
        return source
    }()
    lazy var dataSource5:NSMutableArray = {
        var source = NSMutableArray()
        return source
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false  //scrollview常用属性
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()
        let headerView = NewsHeaderView(frame: CGRectMake(0, 0, WIDTH, 40))
        //设置代理人
        headerView.delegate = self
        self.view.addSubview(headerView)
        //传递数据
        headerView.reloadData()
        
        
        self.ScrollView.delegate = self
        self.view.addSubview(self.ScrollView)
        self.ScrollView.addSubview(self.Headline)
        self.ScrollView.addSubview(self.Second)
        self.ScrollView.addSubview(self.Third)
        self.ScrollView.addSubview(self.Fourth)
        self.ScrollView.addSubview(self.Fifth)
        
        self.Headline.registerNib(UINib(nibName: "LittlePictureCell", bundle: nil), forCellReuseIdentifier: "cell1")
        self.Headline.registerNib(UINib(nibName: "BigPictureCell", bundle: nil), forCellReuseIdentifier: "cell2")
        self.Headline.registerNib(UINib(nibName: "ThreePictureCell", bundle: nil), forCellReuseIdentifier: "cell3")

        self.Second.registerNib(UINib(nibName: "LittlePictureCell", bundle: nil), forCellReuseIdentifier: "cell1")
        self.Second.registerNib(UINib(nibName: "BigPictureCell", bundle: nil), forCellReuseIdentifier: "cell2")
        self.Second.registerNib(UINib(nibName: "ThreePictureCell", bundle: nil), forCellReuseIdentifier: "cell3")
        
        self.Third.registerNib(UINib(nibName: "LittlePictureCell", bundle: nil), forCellReuseIdentifier: "cell1")
        self.Third.registerNib(UINib(nibName: "BigPictureCell", bundle: nil), forCellReuseIdentifier: "cell2")
        self.Third.registerNib(UINib(nibName: "ThreePictureCell", bundle: nil), forCellReuseIdentifier: "cell3")
        
        self.Fourth.registerNib(UINib(nibName: "LittlePictureCell", bundle: nil), forCellReuseIdentifier: "cell1")
        self.Fourth.registerNib(UINib(nibName: "BigPictureCell", bundle: nil), forCellReuseIdentifier: "cell2")
        self.Fourth.registerNib(UINib(nibName: "ThreePictureCell", bundle: nil), forCellReuseIdentifier: "cell3")
        
        self.Fifth.registerNib(UINib(nibName: "LittlePictureCell", bundle: nil), forCellReuseIdentifier: "cell1")
        self.Fifth.registerNib(UINib(nibName: "BigPictureCell", bundle: nil), forCellReuseIdentifier: "cell2")
        self.Fifth.registerNib(UINib(nibName: "ThreePictureCell", bundle: nil), forCellReuseIdentifier: "cell3")
        
        self.Headline.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cells")
        self.Second.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cells")
        self.Third.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cells")
        self.Fourth.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cells")
        self.Fifth.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cells")

//        self.requestData()
        
        
    }
    
    //MARK:实现代理方法
    //返回标题数量
    func headerViewItem() -> Int {
        return 5
    }
    
    //点击事件
    func header(didSelectItem item: UIButton) {
        if item.tag == 1000 {
            self.ScrollView.contentOffset = CGPointMake(0, 0)
        }else if item.tag == 1001 {
            self.ScrollView.contentOffset = CGPointMake(WIDTH, 0)
        }else if item.tag == 1002 {
            self.ScrollView.contentOffset = CGPointMake(WIDTH * 2, 0)
        }else if item.tag == 1003 {
            self.ScrollView.contentOffset = CGPointMake(WIDTH * 3, 0)
        }else if item.tag == 1004 {
            self.ScrollView.contentOffset = CGPointMake(WIDTH * 4, 0)
        }else {
            
        }
        
        
        
    }
    
    func refreshData() {
        
    }
    
    func reloadData() {
    
    }
    
    
    func requestData(or:Bool) {
        if or == true {
            if self.ScrollView.contentOffset.x == 0 {
                let str:String = "http://c.m.163.com/nc/article/list/T1348649580692/0-20.html"   //科技
                let manager = AFHTTPRequestOperationManager()
                manager.GET(str, parameters: nil, success: { (operation, objects) -> Void in
                    self.dealWithData(objects)
                    }) { (operation, error) -> Void in
                        
                }
            }else if self.ScrollView.contentOffset.x == WIDTH{
                let str:String = "http://c.m.163.com/nc/article/list/T1348649079062/0-20.html"   //体育
                let manager = AFHTTPRequestOperationManager()
                manager.GET(str, parameters: nil, success: { (operation, objects) -> Void in
                    self.dealWithData(objects)
                    }) { (operation, error) -> Void in
                        
                }
            }else if self.ScrollView.contentOffset.x == WIDTH * 2{
                let str:String = "http://c.m.163.com/nc/article/list/T1348648756099/0-20.html"   //财经
                let manager = AFHTTPRequestOperationManager()
                manager.GET(str, parameters: nil, success: { (operation, objects) -> Void in
                    self.dealWithData(objects)
                    }) { (operation, error) -> Void in
                        
                }
            }else if self.ScrollView.contentOffset.x == WIDTH * 3{
                let str:String = "http://c.m.163.com/nc/article/list/T1348648517839/0-20.html"   //娱乐
                let manager = AFHTTPRequestOperationManager()
                manager.GET(str, parameters: nil, success: { (operation, objects) -> Void in
                    self.dealWithData(objects)
                    }) { (operation, error) -> Void in
                        
                }
            }else if self.ScrollView.contentOffset.x == WIDTH * 4{
                let str:String = "http://c.m.163.com/nc/auto/list/5a6B5rOi/0-20.html"   //汽车
                let manager = AFHTTPRequestOperationManager()
                manager.GET(str, parameters: nil, success: { (operation, objects) -> Void in
                    self.dealWithData(objects)
                    }) { (operation, error) -> Void in
                        
                }
            }
            
        }else {
            
            
            
            
        }
        
        
        

    }
    
    
    
    func dealWithData(objects:AnyObject) {
        if self.ScrollView.contentOffset.x == 0 {
            let arr:NSArray = objects["T1348649580692"] as! NSArray
            for dic in arr {
                let model:NewsScienceModel = NewsScienceModel()
                model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                self.dataSource1.addObject(model)
            }
            self.dataSource1.removeObjectAtIndex(0)
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.Headline.reloadData()
            }
        }else if self.ScrollView.contentOffset.x == WIDTH {
            let arr:NSArray = objects["list"] as! NSArray
            
            for dic in arr {
                let model:NewsScienceModel = NewsScienceModel()
                model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                self.dataSource1.addObject(model)
            }
            self.dataSource1.removeObjectAtIndex(0)
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.Headline.reloadData()
            }
        }else if self.ScrollView.contentOffset.x == WIDTH * 2 {
            let arr:NSArray = objects["T1348649580692"] as! NSArray
            
            for dic in arr {
                let model:NewsScienceModel = NewsScienceModel()
                model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                self.dataSource1.addObject(model)
            }
            self.dataSource1.removeObjectAtIndex(0)
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.Headline.reloadData()
            }
        }else if self.ScrollView.contentOffset.x == WIDTH * 3 {
            let arr:NSArray = objects["T1348649580692"] as! NSArray
            
            for dic in arr {
                let model:NewsScienceModel = NewsScienceModel()
                model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                self.dataSource1.addObject(model)
            }
            self.dataSource1.removeObjectAtIndex(0)
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.Headline.reloadData()
            }
        }else if self.ScrollView.contentOffset.x == WIDTH * 4 {
            let arr:NSArray = objects["T1348649580692"] as! NSArray
            
            for dic in arr {
                let model:NewsScienceModel = NewsScienceModel()
                model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                self.dataSource1.addObject(model)
            }
            self.dataSource1.removeObjectAtIndex(0)
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.Headline.reloadData()
            }
        }
        
        
        
        
        
        

        
    }
    
    //MARK:scrollView
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView == self.ScrollView {
            //refresh
        }
        
        
        
    }
    

    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.Headline {
            return self.dataSource1.count
        }
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == self.Headline {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell1") as! LittlePictureCell
            let model:NewsScienceModel = self.dataSource1[indexPath.row] as! NewsScienceModel
            cell.setValuesWithModel(model)
            return cell
        }else if tableView == self.Second {
            let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cells")!
            return cell
        }else if tableView == self.Third {
            let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cells")!
            return cell
        }else if tableView == self.Fourth {
            let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cells")!
            return cell
        }else if tableView == self.Fifth {
            let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cells")!
            return cell
        }else {
            let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cells")!
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model:NewsScienceModel = self.dataSource1[indexPath.row] as! NewsScienceModel
        let web = WebViewVC()
        if model.url_3w != nil {
            web.url = model.url_3w!
            self.navigationController?.pushViewController(web, animated: true)
        }else {
            print("没哟偶")
        }
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
