//
//  CreateReminderViewController.swift
//  pigeon
//
//  Created by Liu, Naitian on 10/6/15.
//  Copyright © 2015 naitianliu. All rights reserved.
//

import UIKit
import MapKit
import RMDateSelectionViewController

class CreateReminderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, APIEventHelperDelegate, EditReminderDescriptionViewControllerDelegate, EditLocationViewControllerDelegate {
    
    let apiUrl:String = "\(const_APIEndpoint)/main/event/reminder/create/"
    
    @IBOutlet weak var tableView: UITableView!
    
    var reminderDescription:String!
    var location:[String:AnyObject]!
    var startTime:[String:AnyObject]!
    var endTime:[String:AnyObject]!
    var receivers:[String]!
    
    var reminderUIHelper:ReminderUIHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.reminderUIHelper = ReminderUIHelper(view: self.view)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonOnClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func sendButtonOnClick(sender: AnyObject) {
        
    }
    
    func beforeSendRequest() {
        
    }
    
    func afterReceiveResponse(responseData: AnyObject, index:String?) {
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        if section == 0 {
            rows = 2
        } else if section == 1 {
            rows = 3
        }
        return rows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "CreateReminderCell")
        if indexPath.section == 0 && indexPath.row == 0 {
            if self.reminderDescription == nil {
                cell.textLabel?.text = "Description"
                cell.textLabel?.textColor = UIColor.lightGrayColor()
            } else {
                print(const_MyImgURL)
                let descriptionView = self.reminderUIHelper.setupDescriptionView(self.reminderDescription, nickname: const_MyNickname, imgUrl: const_MyImgURL)
                cell.contentView.addSubview(descriptionView)
            }
        } else if indexPath.section == 0 && indexPath.row == 1 {
            if self.receivers == nil {
                cell.textLabel?.text = "Add Receivers"
                cell.textLabel?.textColor = UIColor.lightGrayColor()
            }
        } else if indexPath.section == 1 && indexPath.row == 0 {
            if self.location == nil {
                cell.textLabel?.text = "Location"
                cell.textLabel?.textColor = UIColor.lightGrayColor()
            } else {
                cell.textLabel?.text = self.location["name"] as? String
                cell.textLabel?.textColor = UIColor.blackColor()
                cell.detailTextLabel?.text = self.location["placemark"] as? String
            }
        } else if indexPath.section == 1 && indexPath.row == 1 {
            if self.startTime == nil {
                cell.textLabel?.text = "Start Time"
                cell.textLabel?.textColor = UIColor.lightGrayColor()
            } else {
                let timeLabel:UILabel = UILabel(frame: CGRect(x: 100, y: 0, width: cell.contentView.frame.width - 80 , height: cell.contentView.frame.height))
                timeLabel.textAlignment = NSTextAlignment.Right
                timeLabel.text = self.startTime["datetime"] as? String
                cell.contentView.addSubview(timeLabel)
                cell.textLabel?.text = "Starts"
            }
        } else if indexPath.section == 1 && indexPath.row == 2 {
            if self.endTime == nil {
                cell.textLabel?.text = "End Time"
                cell.textLabel?.textColor = UIColor.lightGrayColor()
            } else {
                let timeLabel:UILabel = UILabel(frame: CGRect(x: 100, y: 0, width: cell.contentView.frame.width - 80 , height: cell.contentView.frame.height))
                timeLabel.textAlignment = NSTextAlignment.Right
                timeLabel.text = self.endTime["datetime"] as? String
                cell.contentView.addSubview(timeLabel)
                cell.textLabel?.text = "Ends"
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            if self.reminderDescription == nil {
                return 46
            } else {
                return self.reminderUIHelper.descriptionViewHeight
            }
        } else {
            return 46
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            // edit description
            let editReminderDescriptionVC:EditReminderDescriptionViewController = self.storyboard?.instantiateViewControllerWithIdentifier("EditReminderDescriptionViewController") as! EditReminderDescriptionViewController
            editReminderDescriptionVC.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
            editReminderDescriptionVC.delegate = self
            if self.reminderDescription != nil {
                editReminderDescriptionVC.textString = self.reminderDescription
            }
            self.presentViewController(editReminderDescriptionVC, animated: true, completion: nil)
        } else if indexPath.section == 0 && indexPath.row == 1 {
            // add members
            let contactStoryboard:UIStoryboard = UIStoryboard(name: "Contact", bundle: nil)
            let selectContactsVC:SelectContactsViewController = contactStoryboard.instantiateViewControllerWithIdentifier("SelectContactsViewController") as! SelectContactsViewController
            selectContactsVC.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
            self.presentViewController(selectContactsVC, animated: true, completion: nil)
        } else if indexPath.section == 1 && indexPath.row == 0 {
            // edit location
            let editLocationVC:EditLocationViewController = self.storyboard?.instantiateViewControllerWithIdentifier("EditLocationViewController") as! EditLocationViewController
            editLocationVC.delegate = self
            self.presentViewController(editLocationVC, animated: true, completion: nil)
        } else if indexPath.section == 1 && indexPath.row == 1 {
            // edit start time
            self.pickTimeForStart()
        } else if indexPath.section == 1 && indexPath.row == 2 {
            // edit end time
            self.pickTimeForEnd()
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func finishEditReminderDescription(description: String) {
        print(description)
        self.reminderDescription = description
        self.tableView.reloadData()
    }
    
    func finishEditLocation(mapItem: MKMapItem) {
        print(mapItem)
        let name = mapItem.name
        var thoroughfare:String! = ""
        if mapItem.placemark.thoroughfare != nil {
            thoroughfare = mapItem.placemark.thoroughfare!
        }
        var locality:String! = ""
        if mapItem.placemark.locality != nil {
            locality = mapItem.placemark.locality!
        }
        var administrativeArea:String! = ""
        if mapItem.placemark.administrativeArea != nil {
            administrativeArea = mapItem.placemark.administrativeArea!
        }
        var postalCode:String! = ""
        if mapItem.placemark.postalCode != nil {
            postalCode = mapItem.placemark.postalCode!
        }
        let placemark:String = "\(thoroughfare), \(locality), \(administrativeArea), \(postalCode)"
        print(placemark)
        let x = mapItem.placemark.location?.coordinate.latitude
        let y = mapItem.placemark.location?.coordinate.longitude
        let coordination:[String] = [String(Double(x!)), String(Double(y!))]
        self.location = [:]
        self.location["name"] = name
        self.location["placemark"] = placemark
        self.location["coordination"] = coordination
        self.tableView.reloadData()
    }
    
    func pickTimeForStart() {
        let selectAction:RMAction = RMAction(title: "确定", style: RMActionStyle.Done) { (controller:RMActionController!) -> Void in
            let formatter:NSDateFormatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd hh:mm a"
            let datetime:String = formatter.stringFromDate((controller.contentView as! UIDatePicker).date)
            self.startTime = [:]
            self.startTime["datetime"] = datetime
            self.tableView.reloadData()
        }
        let cancelAction:RMAction = RMAction(title: "取消", style: RMActionStyle.Cancel) { (controller) -> Void in
            print("Cancelled")
        }
        let dateSelectionController:RMDateSelectionViewController = RMDateSelectionViewController(style: RMActionControllerStyle.White, selectAction: selectAction, andCancelAction: cancelAction)
        dateSelectionController.title = "选择时间"
        dateSelectionController.message = "请设置时间发生时间"
        dateSelectionController.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        dateSelectionController.disableBlurEffectsForBackgroundView = true
        self.presentViewController(dateSelectionController, animated: true, completion: nil)
    }
    
    func pickTimeForEnd() {
        let selectAction:RMAction = RMAction(title: "确定", style: RMActionStyle.Done) { (controller:RMActionController!) -> Void in
            let formatter:NSDateFormatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd hh:mm a"
            let datetime:String = formatter.stringFromDate((controller.contentView as! UIDatePicker).date)
            self.endTime = [:]
            self.endTime["datetime"] = datetime
            self.tableView.reloadData()
        }
        let cancelAction:RMAction = RMAction(title: "取消", style: RMActionStyle.Cancel) { (controller) -> Void in
            print("Cancelled")
        }
        let dateSelectionController:RMDateSelectionViewController = RMDateSelectionViewController(style: RMActionControllerStyle.White, selectAction: selectAction, andCancelAction: cancelAction)
        dateSelectionController.title = "选择时间"
        dateSelectionController.message = "请设置时间发生时间"
        dateSelectionController.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        dateSelectionController.disableBlurEffectsForBackgroundView = true
        self.presentViewController(dateSelectionController, animated: true, completion: nil)
    }

}
