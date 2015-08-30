//
//  CreateTaskViewController.swift
//  pigeon
//
//  Created by Liu, Naitian on 8/29/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import UIKit
import SZTextView


class CreateTaskViewController: UIViewController {
    
    let kOFFSET_FOR_KEYBOARD:CGFloat = 20
    
    var keyboardFrame:CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)

    @IBOutlet var descriptionTextView: SZTextView!
    
    var locationTimeEditViewHelper:LocationTimeEditViewHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.descriptionTextView.becomeFirstResponder()
        
        self.locationTimeEditViewHelper = LocationTimeEditViewHelper(rootViewController: self)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardShown:", name: UIKeyboardDidShowNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonOnClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    
    @IBAction func sendButtonOnClick(sender: AnyObject) {
    }
    
    
    
    func keyboardShown(notification:NSNotification) {
        let info = notification.userInfo!
        let value:AnyObject = info[UIKeyboardFrameEndUserInfoKey]!
        let rawFrame = value.CGRectValue()
        self.keyboardFrame = self.view.convertRect(rawFrame, fromView: nil)
        self.locationTimeEditViewHelper.adjustViewHeight(self.keyboardFrame.height)
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
