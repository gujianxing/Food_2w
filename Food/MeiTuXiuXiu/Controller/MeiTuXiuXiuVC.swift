//
//  MeiTuXiuXiuVC.swift
//  Food
//
//  Created by 谷建兴 on 16/1/5.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class MeiTuXiuXiuVC: UIViewController {

    
    
    
    @IBOutlet weak var headerPicture: UIImageView!
    @IBOutlet weak var bottomScrollView: UIScrollView!
    
    @IBOutlet weak var bottom1: UIImageView!
    @IBOutlet weak var bottom2: UIImageView!
    @IBOutlet weak var bottom3: UIImageView!
    @IBOutlet weak var bottom4: UIImageView!
    @IBOutlet weak var bottom5: UIImageView!
    @IBOutlet weak var bottom6: UIImageView!
    
    var cicontext:CIContext?
    var image1:UIImage?
    var image2:UIImage?
    var image3:UIImage?
    var image4:UIImage?
    var image5:UIImage?
    var image6:UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        let image:UIImage = UIImage(named: "back")!
        self.headerPicture.image = image
        
        let ciimage:CIImage = CIImage(image: image)!
        self.cicontext = CIContext()
        
        self.image1 = self.creatAllFilter(name: "CIColorMonochrome", ciimage: ciimage)
        self.image2 = self.creatAllFilter(name: "CIPhotoEffectChrome", ciimage: ciimage)
        self.image3 = self.creatAllFilter(name: "CIColorPosterize", ciimage: ciimage)
        self.image4 = self.creatAllFilter(name: "CIEdges", ciimage: ciimage)
        self.image5 = self.creatAllFilter(name: "CIHatchedScreen", ciimage: ciimage)
        self.image6 = self.creatAllFilter(name: "CILinearToSRGBToneCurve", ciimage: ciimage)

        self.bottom1.image = image1
        self.bottom2.image = image2
        self.bottom3.image = image3
        self.bottom4.image = image4
        self.bottom5.image = image5
        self.bottom6.image = image6
        
        self.bottom1.tag = 10001
        self.bottom2.tag = 10002
        self.bottom3.tag = 10003
        self.bottom4.tag = 10004
        self.bottom5.tag = 10005
        self.bottom6.tag = 10006

        let tap1:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapaction:")
        let tap2:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapaction:")
        let tap3:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapaction:")
        let tap4:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapaction:")
        let tap5:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapaction:")
        let tap6:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapaction:")

        
        self.bottom1.addGestureRecognizer(tap1)
        self.bottom2.addGestureRecognizer(tap2)
        self.bottom3.addGestureRecognizer(tap3)
        self.bottom4.addGestureRecognizer(tap4)
        self.bottom5.addGestureRecognizer(tap5)
        self.bottom6.addGestureRecognizer(tap6)

        
    }
    
    func tapaction(sender:UITapGestureRecognizer) {
        if sender.view?.tag == 10001 {
            self.headerPicture.image = self.image1
        }else if sender.view?.tag == 10002 {
            self.headerPicture.image = self.image2
        }else if sender.view?.tag == 10003 {
            self.headerPicture.image = self.image3
        }else if sender.view?.tag == 10004 {
            self.headerPicture.image = self.image4
        }else if sender.view?.tag == 10005 {
            self.headerPicture.image = self.image5
        }else {
            self.headerPicture.image = self.image6
        }
    }
    
    
    
    func creatAllFilter(name name:String,ciimage:CIImage) ->UIImage {
        
        let cifilter:CIFilter = CIFilter(name: name)!
        cifilter.setValue(ciimage, forKey: kCIInputImageKey)
        cifilter.setDefaults()
        let outciimage:CIImage = cifilter.valueForKey(kCIOutputImageKey) as! CIImage
        let cgimage:CGImageRef = self.cicontext!.createCGImage(outciimage, fromRect: outciimage.extent)
        let endimage:UIImage = UIImage(CGImage: cgimage)
        return endimage
    }
    
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func creatFilter() {
        
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
