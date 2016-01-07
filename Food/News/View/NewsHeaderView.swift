//
//  NewsHeaderView.swift
//  Food
//
//  Created by 谷建兴 on 16/1/6.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

//声明协议
protocol NewHeaderDelegate {
    //获得button个数
   func headerViewItem() ->Int
    //点击button相应事件
    func header(didSelectItem item:UIButton)
}

class NewsHeaderView: UIView,UIScrollViewDelegate {
    //声明代理
    var delegate:NewHeaderDelegate?
    var scrollView:UIScrollView?
    var line:UIView?
    var count:Int?
    
    var leftBut:UIButton?
    var middleBut:UIButton?
    var rightBut:UIButton?
    
    lazy var dataSource:NSMutableArray = {
        var source = NSMutableArray()
        return source
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    
    func creatView() {
        self.scrollView = UIScrollView(frame: self.frame)
        self.scrollView!.contentSize = CGSizeMake(WIDTH / 3 * CGFloat(self.count!), 40)
        self.scrollView!.backgroundColor = UIColor.blackColor()
        self.scrollView!.delegate = self
        self.addSubview(self.scrollView!)
        for var i = 0;i < self.count;i++ {
            let button = UIButton()
            button.frame = CGRectMake(WIDTH / 3 * CGFloat(i), 0, WIDTH / 3, 40.0)
            button.tag = i + 1000
            button.setTitle("123", forState: .Normal)
            button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            self.scrollView!.addSubview(button)
        }
        
        self.line = UIView(frame: CGRectMake(0, 39, WIDTH / 5, 1))
        self.line!.backgroundColor = UIColor.redColor()
        scrollView!.addSubview(self.line!)
        
    }
    
    
    func buttonAction(sender:UIButton) {
        print("hit")
        let point = sender.center
        self.line?.center = CGPointMake(point.x, (self.line?.center.y)!)
        
        self.delegate?.header(didSelectItem: sender)
        
        
        //滚动
        let Offset:CGPoint = (self.scrollView?.contentOffset)!
        let x = (self.scrollView?.contentOffset.x)! / (WIDTH / 3)
        if sender.tag - 1000 == Int(x) {
            if Int(x) > 0 {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.scrollView?.contentOffset = CGPointMake(Offset.x - WIDTH / 3, Offset.y)
                })
            }
        }else if sender.tag - 1000 == Int(x) + 1 {
            
        }else if sender.tag - 1000 == Int(x) + 2 {
            print(Int(x))
            if Int(x) < self.count! - 3 {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.scrollView?.contentOffset = CGPointMake(Offset.x + WIDTH / 3, Offset.y)
                })
            }
        }else {
            
        }
        

    }
    
    
    //获得数据 不能在init中实现代理方法
    func reloadData() {
        //实现代理方法
        self.count = (self.delegate?.headerViewItem())!
        //加载视图
        self.creatView()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
