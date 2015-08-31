//
//  AddMembersViewHelper.swift
//  pigeon
//
//  Created by Liu, Naitian on 8/30/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import Foundation
import SDWebImage

class AddMembersViewHelper:NSObject {
    
    let myProfileURL:String = "http://tp3.sinaimg.cn/2525851962/180/40000907046/1"
    
    let viewHeight:CGFloat = 50
    
    var rootViewController:UIViewController!
    var rootView:UIView!
    var rootViewRect:CGRect!
    
    var addMembersView:UIView!
    var addButton:UIButton!
    
    init(rootViewController:UIViewController, addMembersView:UIView) {
        super.init()
        self.rootViewController = rootViewController
        self.rootView = rootViewController.view
        self.rootViewRect = self.rootView.frame
        self.addMembersView = addMembersView
        self.initAddMembersView()
        self.initAddButton()
        self.addMembersView.addSubview(self.initProfileImageView(1, imgUrl: myProfileURL))
    }
    
    private func initAddMembersView() {
        
    }
    
    private func initAddButton() {
        self.addButton = UIButton.buttonWithType(UIButtonType.ContactAdd) as! UIButton
        self.addButton.frame = CGRect(x: 5, y: 5, width: 40, height: 40)
        self.addButton.layer.cornerRadius = 20.0
        self.addButton.layer.borderWidth = 1.0
        self.addButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        // self.addButton.setImage(UIImage(named: "add"), forState: UIControlState.Normal)
        self.addButton.addTarget(self, action: Selector("addButtonOnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.addMembersView.addSubview(self.addButton)
    }
    
    private func initProfileImageView(index:Int, imgUrl:String) -> UIImageView {
        var profileImageView:UIImageView = UIImageView(frame: CGRect(x: 5 + 50 * index, y: 5, width: 40, height: 40))
        profileImageView.sd_setImageWithURL(NSURL(string: imgUrl), placeholderImage: UIImage(named: "Apple"))
        profileImageView.layer.cornerRadius = 20.0
        profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        profileImageView.layer.masksToBounds = true
        return profileImageView
    }
    
    func addButtonOnClick(sender:UIButton!) {
        println("add")
    }
}