//
//  EventDetailViewHelper.swift
//  pigeon
//
//  Created by Liu, Naitian on 9/6/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import Foundation

class EventDetailViewHelper: NSObject {
    
    var rootViewController:UIViewController!
    var rootView:UIView!
    
    var titleLabel:UILabel!
    
    var navBgColor:UIColor = UIColor.whiteColor()
    
    var memberImgUrls:[String]!
    
    init(viewController:UIViewController) {
        self.rootViewController = viewController
        self.rootView = self.rootViewController.view
    }
    
    func setEventInfoView(eventInfo:[String:AnyObject]) -> UIView {
        self.memberImgUrls = eventInfo["memberImgUrls"] as! [String]
        var eventInfoView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.rootView.frame.width, height: 300))
        eventInfoView.backgroundColor = UIColor.yellowColor()
        var groupProfileView:UIView = self.initGroupProfileView(self.memberImgUrls)
        eventInfoView.addSubview(groupProfileView)
        return eventInfoView
    }
    
    func setupUI() {
        // self.rootViewController.navigationController?.navigationBar.alpha = 0
        self.rootViewController.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func changeViewByScroll(yOffset:CGFloat) {
        var alpha:CGFloat = (yOffset) / 300
        println(alpha)
        if alpha > 1 {
            self.rootViewController.navigationController?.setNavigationBarHidden(false, animated: true)
        } else if alpha < 0 {
            self.rootViewController.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    private func imageWithColor(color:UIColor) -> UIImage {
        var rect:CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        var context:CGContextRef = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        var theImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return theImage
    }
    
    private func initGroupProfileView(memberImgUrls:[String]) -> UIView {
        let width:CGFloat = 80
        let sepatorWidth:CGFloat = 1
        var view:UIView = UIView(frame: CGRect(x: 5, y: 70, width: width, height: width))
        if memberImgUrls.count == 1 {
            var imgView:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: width))
            imgView.sd_setImageWithURL(NSURL(string: memberImgUrls[0]), placeholderImage: UIImage(named: "Apple"))
            view.addSubview(imgView)
        } else if memberImgUrls.count == 2 {
            var imgView1:UIImageView = UIImageView(frame: CGRect(x: -width/2 - sepatorWidth, y: 0, width: width, height: width))
            var imgView2:UIImageView = UIImageView(frame: CGRect(x: width/2 + sepatorWidth, y: 0, width: width, height: width))
            imgView1.sd_setImageWithURL(NSURL(string: memberImgUrls[0]), placeholderImage: UIImage(named: "Apple"))
            imgView2.sd_setImageWithURL(NSURL(string: memberImgUrls[1]), placeholderImage: UIImage(named: "Apple"))
            view.addSubview(imgView1)
            view.addSubview(imgView2)
        } else if memberImgUrls.count == 3 {
            var imgView1:UIImageView = UIImageView(frame: CGRect(x: -width/2 - sepatorWidth, y: 0, width: width, height: width))
            var imgView2:UIImageView = UIImageView(frame: CGRect(x: width/2 + sepatorWidth, y: -sepatorWidth, width: width/2, height: width/2))
            var imgView3:UIImageView = UIImageView(frame: CGRect(x: width/2 + sepatorWidth, y: width/2 + sepatorWidth, width: width/2, height: width/2))
            imgView1.sd_setImageWithURL(NSURL(string: memberImgUrls[0]), placeholderImage: UIImage(named: "Apple"))
            imgView2.sd_setImageWithURL(NSURL(string: memberImgUrls[1]), placeholderImage: UIImage(named: "Apple"))
            imgView3.sd_setImageWithURL(NSURL(string: memberImgUrls[2]), placeholderImage: UIImage(named: "Apple"))
            view.addSubview(imgView1)
            view.addSubview(imgView2)
            view.addSubview(imgView3)
        } else {
            var imgView1:UIImageView = UIImageView(frame: CGRect(x: -sepatorWidth, y: -sepatorWidth, width: width/2, height: width/2))
            var imgView2:UIImageView = UIImageView(frame: CGRect(x: -sepatorWidth, y: width/2 + sepatorWidth, width: width/2, height: width/2))
            var imgView3:UIImageView = UIImageView(frame: CGRect(x: width/2 + sepatorWidth, y: -sepatorWidth, width: width/2, height: width/2))
            var imgView4:UIImageView = UIImageView(frame: CGRect(x: width/2 + sepatorWidth, y: width/2 + sepatorWidth, width: width/2, height: width/2))
            imgView1.sd_setImageWithURL(NSURL(string: memberImgUrls[0]), placeholderImage: UIImage(named: "Apple"))
            imgView2.sd_setImageWithURL(NSURL(string: memberImgUrls[1]), placeholderImage: UIImage(named: "Apple"))
            imgView3.sd_setImageWithURL(NSURL(string: memberImgUrls[2]), placeholderImage: UIImage(named: "Apple"))
            imgView4.sd_setImageWithURL(NSURL(string: memberImgUrls[3]), placeholderImage: UIImage(named: "Apple"))
            view.addSubview(imgView1)
            view.addSubview(imgView2)
            view.addSubview(imgView3)
            view.addSubview(imgView4)
        }
        view.layer.borderColor = UIColor.whiteColor().CGColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = width / 2
        view.layer.masksToBounds = true
        return view
    }
}