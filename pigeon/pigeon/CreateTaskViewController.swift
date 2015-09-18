//
//  CreateTaskViewController.swift
//  pigeon
//
//  Created by Liu, Naitian on 8/29/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import UIKit
import SZTextView
import MapKit


class CreateTaskViewController: UIViewController, LocationTimeEditViewDelegate, APIEventHelperDelegate {
    
    let apiUrl:String = "\(const_APIEndpoint)/main/create_new_event/"
    
    let kOFFSET_FOR_KEYBOARD:CGFloat = 20
    
    var keyboardFrame:CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)

    @IBOutlet var descriptionTextView: SZTextView!
    @IBOutlet weak var addMembersView: UIView!
    
    var locationTimeEditViewHelper:LocationTimeEditViewHelper!
    var addMembersViewHelper:AddMembersViewHelper!
    
    var locationData:[String:AnyObject] = ["name": "unknown"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.descriptionTextView.becomeFirstResponder()
        
        self.locationTimeEditViewHelper = LocationTimeEditViewHelper(rootViewController:self, delegate:self)
        
        self.addMembersViewHelper = AddMembersViewHelper(rootViewController: self, addMembersView: self.addMembersView)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardShown:", name: UIKeyboardDidShowNotification, object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.descriptionTextView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonOnClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    func locationTimeReceiveLocation(mapItem: MKMapItem) {
        print(mapItem)
        let locationName = mapItem.name
        let x = mapItem.placemark.location?.coordinate.latitude
        let y = mapItem.placemark.location?.coordinate.longitude
        let coordination:[String] = [String(Double(x!)), String(Double(y!))]
        self.locationData["name"] = locationName
        self.locationData["coordination"] = coordination 
        self.locationTimeEditViewHelper.rootViewController = self
    }
    
    @IBAction func sendButtonOnClick(sender: AnyObject) {
        var requestData:[String: AnyObject] = [:]
        requestData["description"] = self.descriptionTextView.text
        requestData["location"] = self.locationData
        requestData["time"] = self.locationTimeEditViewHelper.datetime
        requestData["members"] = []
        
        APIEventHelper(url:self.apiUrl, data: requestData, delegate: self).POST()
    }
    
    func keyboardShown(notification:NSNotification) {
        let info = notification.userInfo!
        let value:AnyObject = info[UIKeyboardFrameEndUserInfoKey]!
        let rawFrame = value.CGRectValue
        self.keyboardFrame = self.view.convertRect(rawFrame, fromView: nil)
        self.locationTimeEditViewHelper.adjustViewHeight(self.keyboardFrame.height)
    }

    func beforeSendRequest() {
        
    }
    
    func afterReceiveResponse(responseData: AnyObject) {
        print(responseData)
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }

}
