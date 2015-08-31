//
//  LocationTimeEditViewHelper.swift
//  pigeon
//
//  Created by Liu, Naitian on 8/29/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import Foundation
import MapKit
import RMDateSelectionViewController

protocol LocationTimeEditViewDelegate {
    func locationTimeReceiveLocation(mapItem:MKMapItem)
}

class LocationTimeEditViewHelper: NSObject, EditLocationViewControllerDelegate {
    
    let viewHeght:CGFloat = 100
    
    var rootViewController:UIViewController!
    var rootView:UIView!
    var locationTimeEditView:UIView!
    
    var rootViewRect:CGRect!
    
    var locationLabel:UILabel!
    var timeLabel:UILabel!
    
    var dateSelectionController:RMDateSelectionViewController!
    
    var locationTimeEditViewDelegate:LocationTimeEditViewDelegate?
    
    var editLocationViewController:EditLocationViewController!
    
    init(rootViewController:UIViewController, delegate:LocationTimeEditViewDelegate) {
        super.init()
        self.locationTimeEditViewDelegate = delegate
        let eventStoryboard:UIStoryboard = UIStoryboard(name: "Event", bundle: nil)
        self.editLocationViewController = eventStoryboard.instantiateViewControllerWithIdentifier("EditLocationViewController") as! EditLocationViewController
        self.editLocationViewController.editLocationDelegate = self
        self.rootViewController = rootViewController
        self.rootView = rootViewController.view
        self.rootViewRect = self.rootView.frame
        self.initiateLocationTimeEditView()
        self.initiateLocationAndTimeLabel()
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
        var button:UIButton = UIButton(frame: CGRect(x: 10, y: 65, width: 100, height: 30))
        button.setTitle("地点", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        button.addTarget(self, action: Selector("locationButtonOnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }
    
    private func initiateTimeButton() -> UIButton {
        var buttonWidth:CGFloat = 100
        var button:UIButton = UIButton(frame: CGRect(x: self.rootViewRect.width - 10 - buttonWidth, y: 65, width: buttonWidth, height: 30))
        button.setTitle("时间", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        button.addTarget(self, action: Selector("timeButtonOnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }
    
    private func initiateLocationAndTimeLabel() {
        self.locationLabel = UILabel(frame: CGRect(x: 10, y: 5, width: self.rootViewRect.width - 10, height: 20))
        self.locationLabel.text = "未设置地址 （可选）"
        self.locationLabel.textColor = UIColor.lightGrayColor()
        self.locationLabel.font = UIFont(name: "Arial", size: 14)
        self.locationLabel.textAlignment = NSTextAlignment.Center
        self.timeLabel = UILabel(frame: CGRect(x: 10, y: 30, width: self.rootViewRect.width - 10, height: 20))
        self.timeLabel.text = "未设置时间 （可选）"
        self.timeLabel.textColor = UIColor.lightGrayColor()
        self.timeLabel.font = UIFont(name: "Arial", size: 14)
        self.timeLabel.textAlignment = NSTextAlignment.Center
        self.locationTimeEditView.addSubview(self.locationLabel)
        self.locationTimeEditView.addSubview(self.timeLabel)
    }
    
    func adjustViewHeight(keyboardHeight: CGFloat) {
        self.locationTimeEditView.frame.origin.y = self.rootViewRect.height - keyboardHeight - viewHeght
    }
    
    func locationButtonOnClick(sender:UIButton!) {
        editLocationViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        self.rootViewController.presentViewController(editLocationViewController, animated: true) { () -> Void in
            
        }
    }
    
    func timeButtonOnClick(sender:UIButton!) {
        var selectAction:RMAction = RMAction(title: "确定", style: RMActionStyle.Done) { (controller:RMActionController!) -> Void in
            var formatter:NSDateFormatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd hh:mm a"
            var datetime:String = formatter.stringFromDate((controller.contentView as! UIDatePicker).date)
            self.timeLabel.text = datetime
        }
        var cancelAction:RMAction = RMAction(title: "取消", style: RMActionStyle.Cancel) { (controller) -> Void in
            println("Cancelled")
        }
        var dateSelectionController:RMDateSelectionViewController = RMDateSelectionViewController(style: RMActionControllerStyle.White, selectAction: selectAction, andCancelAction: cancelAction)
        dateSelectionController.title = "选择时间"
        dateSelectionController.message = "请设置时间发生时间"
        dateSelectionController.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        dateSelectionController.disableBlurEffectsForBackgroundView = true
        self.rootViewController.presentViewController(dateSelectionController, animated: true, completion: nil)
    }
    
    func finishEditLocation(mapItem: MKMapItem) {
        self.locationLabel.text = mapItem.name
        self.locationTimeEditViewDelegate?.locationTimeReceiveLocation(mapItem)
    }
}