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
    
    var createPostButton:UIButton!
    
    init(viewController:UIViewController) {
        self.rootViewController = viewController
        self.rootView = self.rootViewController.view
    }
    
    func setEventInfoView(eventInfo:[String:AnyObject]) -> UIView {
        self.memberImgUrls = eventInfo["memberImgUrls"] as! [String]
        let eventInfoView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.rootView.frame.width, height: 300))
        eventInfoView.backgroundColor = UIColor.yellowColor()
        let groupProfileView:UIView = self.initGroupProfileView(self.memberImgUrls)
        eventInfoView.addSubview(groupProfileView)
        return eventInfoView
    }
    
    func setupFooterView() -> UIView {
        let view:UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.rootView.frame.width, height: 30))
        self.createPostButton = UIButton(frame: CGRect(x: 20, y: 0, width: 200, height: 30))
        self.createPostButton.setTitle("Create New Post", forState: UIControlState.Normal)
        self.createPostButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        view.addSubview(self.createPostButton)
        return view
    }
    
    func setupUI() {
        // self.rootViewController.navigationController?.navigationBar.alpha = 0
        self.rootViewController.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func changeViewByScroll(yOffset:CGFloat) {
        let alpha:CGFloat = (yOffset) / 300
        if alpha > 1 {
            self.rootViewController.navigationController?.setNavigationBarHidden(false, animated: true)
        } else if alpha < 0 {
            self.rootViewController.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    private func imageWithColor(color:UIColor) -> UIImage {
        let rect:CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context:CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let theImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return theImage
    }
    
    private func initGroupProfileView(memberImgUrls:[String]) -> UIView {
        let width:CGFloat = 80
        let sepatorWidth:CGFloat = 1
        let view:UIView = UIView(frame: CGRect(x: 5, y: 70, width: width, height: width))
        if memberImgUrls.count == 1 {
            let imgView:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: width))
            imgView.sd_setImageWithURL(NSURL(string: memberImgUrls[0]), placeholderImage: UIImage(named: "Apple"))
            view.addSubview(imgView)
        } else if memberImgUrls.count == 2 {
            let imgView1:UIImageView = UIImageView(frame: CGRect(x: -width/2 - sepatorWidth, y: 0, width: width, height: width))
            let imgView2:UIImageView = UIImageView(frame: CGRect(x: width/2 + sepatorWidth, y: 0, width: width, height: width))
            imgView1.sd_setImageWithURL(NSURL(string: memberImgUrls[0]), placeholderImage: UIImage(named: "Apple"))
            imgView2.sd_setImageWithURL(NSURL(string: memberImgUrls[1]), placeholderImage: UIImage(named: "Apple"))
            view.addSubview(imgView1)
            view.addSubview(imgView2)
        } else if memberImgUrls.count == 3 {
            let imgView1:UIImageView = UIImageView(frame: CGRect(x: -width/2 - sepatorWidth, y: 0, width: width, height: width))
            let imgView2:UIImageView = UIImageView(frame: CGRect(x: width/2 + sepatorWidth, y: -sepatorWidth, width: width/2, height: width/2))
            let imgView3:UIImageView = UIImageView(frame: CGRect(x: width/2 + sepatorWidth, y: width/2 + sepatorWidth, width: width/2, height: width/2))
            imgView1.sd_setImageWithURL(NSURL(string: memberImgUrls[0]), placeholderImage: UIImage(named: "Apple"))
            imgView2.sd_setImageWithURL(NSURL(string: memberImgUrls[1]), placeholderImage: UIImage(named: "Apple"))
            imgView3.sd_setImageWithURL(NSURL(string: memberImgUrls[2]), placeholderImage: UIImage(named: "Apple"))
            view.addSubview(imgView1)
            view.addSubview(imgView2)
            view.addSubview(imgView3)
        } else {
            let imgView1:UIImageView = UIImageView(frame: CGRect(x: -sepatorWidth, y: -sepatorWidth, width: width/2, height: width/2))
            let imgView2:UIImageView = UIImageView(frame: CGRect(x: -sepatorWidth, y: width/2 + sepatorWidth, width: width/2, height: width/2))
            let imgView3:UIImageView = UIImageView(frame: CGRect(x: width/2 + sepatorWidth, y: -sepatorWidth, width: width/2, height: width/2))
            let imgView4:UIImageView = UIImageView(frame: CGRect(x: width/2 + sepatorWidth, y: width/2 + sepatorWidth, width: width/2, height: width/2))
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