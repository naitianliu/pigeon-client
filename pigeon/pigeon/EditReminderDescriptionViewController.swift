//
//  EditReminderDescriptionViewController.swift
//  pigeon
//
//  Created by Liu, Naitian on 10/10/15.
//  Copyright © 2015 naitianliu. All rights reserved.
//

import UIKit
import SZTextView

protocol EditReminderDescriptionViewControllerDelegate {
    func finishEditReminderDescription(description:String)
}

class EditReminderDescriptionViewController: UIViewController {

    @IBOutlet weak var descriptionTextView: SZTextView!
    
    var textString:String = ""
    
    var delegate:EditReminderDescriptionViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.descriptionTextView.text = self.textString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonOnClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            let reminderDescription = self.descriptionTextView.text
            self.delegate?.finishEditReminderDescription(reminderDescription)
        }
    }
    
    @IBAction func cancelButtonOnClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
