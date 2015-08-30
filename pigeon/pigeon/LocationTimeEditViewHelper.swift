//
//  LocationTimeEditViewHelper.swift
//  pigeon
//
//  Created by Liu, Naitian on 8/29/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import Foundation

class LocationTimeEditViewHelper: NSObject {
    
    let viewHeght:CGFloat = 40.0
    
    var rootView:UIView!
    var locationTimeEditView:UIView!
    
    var rootViewRect:CGRect!
    
    init(rootViewController:UIViewController) {
        super.init()
        self.rootView = rootViewController.view
        self.rootViewRect = self.rootView.frame
        self.initiateLocationTimeEditView()
    }
    
    private func initiateLocationTimeEditView() {
        self.locationTimeEditView = UIView(frame: CGRect(x: 0, y: self.rootViewRect.height - viewHeght, width: self.rootViewRect.width, height: viewHeght))
        var locationButton:UIButton = self.initiateLocationButton()
        var timeButton:UIButton = self.initiateTimeButton()
        self.locationTimeEditView.addSubview(locationButton)
        self.locationTimeEditView.addSubview(timeButton)
        self.rootView.addSubview(self.locationTimeEditView)
    }
    
    private func initiateLocationButton() -> UIButton {
        var button:UIButton = UIButton(frame: CGRect(x: 10, y: 5, width: 100, height: 30))
        button.setTitle("地点", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        button.addTarget(self, action: Selector("locationButtonOnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }
    
    private func initiateTimeButton() -> UIButton {
        var buttonWidth:CGFloat = 100
        var button:UIButton = UIButton(frame: CGRect(x: self.rootViewRect.width - 10 - buttonWidth, y: 5, width: buttonWidth, height: 30))
        button.setTitle("时间", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        return button
    }
    
    func adjustViewHeight(keyboardHeight: CGFloat) {
        self.locationTimeEditView.frame.origin.y = self.rootViewRect.height - keyboardHeight - viewHeght
    }
    
    func locationButtonOnClick(sender:UIButton!) {
        print(123)
    }
}