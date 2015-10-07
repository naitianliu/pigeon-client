//
//  CreateReminderViewController.swift
//  pigeon
//
//  Created by Liu, Naitian on 10/6/15.
//  Copyright © 2015 naitianliu. All rights reserved.
//

import UIKit
import SZTextView
import MapKit

class CreateReminderViewController: UIViewController, LocationTimeEditViewDelegate, APIEventHelperDelegate {
    
    let apiUrl:String = "\(const_APIEndpoint)/main/event/reminder/create/"
    
    let kOFFSET_FOR_KEYBOARD:CGFloat = 20
    
    var keyboardFrame:CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)

    @IBOutlet weak var editTextView: SZTextView!
    @IBOutlet weak var addMembersView: UIView!
    
    var locationTimeEditViewHelper:LocationTimeEditViewHelper!
    var addMembersViewHelper:AddMembersViewHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.editTextView.becomeFirstResponder()
        
        self.locationTimeEditViewHelper = LocationTimeEditViewHelper(rootViewController:self, delegate:self)
        
        self.addMembersViewHelper = AddMembersViewHelper(rootViewController: self, addMembersView: self.addMembersView)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardShown:", name: UIKeyboardDidShowNotification, object: nil)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.editTextView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardShown(notification:NSNotification) {
        let info = notification.userInfo!
        let value:AnyObject = info[UIKeyboardFrameEndUserInfoKey]!
        let rawFrame = value.CGRectValue
        self.keyboardFrame = self.view.convertRect(rawFrame, fromView: nil)
        self.locationTimeEditViewHelper.adjustViewHeight(self.keyboardFrame.height)
    }
    
    @IBAction func cancelButtonOnClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func sendButtonOnClick(sender: AnyObject) {
        
    }
    
    func locationTimeReceiveLocation(mapItem: MKMapItem) {
        
    }
    
    func beforeSendRequest() {
        
    }
    
    func afterReceiveResponse(responseData: AnyObject) {
        
    }

}
