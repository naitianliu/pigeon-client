//
//  MyEventsViewController.swift
//  pigeon
//
//  Created by Liu, Naitian on 9/3/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import UIKit
import SVPullToRefresh

class MyEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, APIEventHelperDelegate {
    
    let apiUrl:String = "\(const_APIEndpoint)/main/event/list/updated_events/"
    
    let EventTypeArray = const_EventTypeArray
    
    var currentIndex = 0
    var currentEventId:String = ""

    @IBOutlet weak var tableView: UITableView!
    
    var tableData:[AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1), atScrollPosition: UITableViewScrollPosition.Top, animated: false)
        
        self.tableView.addPullToRefreshWithActionHandler { () -> Void in
            APIEventHelper(url: self.apiUrl, data: nil, delegate: self).GET("list_all")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButtonOnClick(sender: AnyObject) {
        let createReminderViewController:CreateReminderViewController = self.storyboard!.instantiateViewControllerWithIdentifier("CreateReminderViewController") as! CreateReminderViewController
        createReminderViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        self.presentViewController(createReminderViewController, animated: true, completion: nil)
    }
    
    func beforeSendRequest() {
        
    }
    
    func afterReceiveResponse(responseData: AnyObject, index:String?) {
        let data = responseData as! [String:AnyObject]
        if index == "list_all" {
            self.tableData = data["result"] as! [AnyObject]
            self.tableView.reloadData()
            self.tableView.pullToRefreshView.stopAnimating()
        } else if index == "reminder" {
            
        }
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else {
            return tableData.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell!
        
        if indexPath.section == 0 {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "EventUpdateCell")
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell.textLabel?.text = EventTypeArray[indexPath.row]["name"]
            let imgName:String = EventTypeArray[indexPath.row]["img"]!
            cell.imageView?.image = UIImage(named: imgName)
        } else {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "MyEventCell")
            let eventInfo = self.tableData[indexPath.row] as! [String:AnyObject]
            let reminderCellHelper = ReminderCellViewHelper(rootViewController: self, eventInfo: eventInfo)
            reminderCellHelper.setupCell(cell)
            reminderCellHelper.actionButton.tag = indexPath.row
            reminderCellHelper.actionButton.addTarget(self, action: "reminderActionButtonOnClick:", forControlEvents: UIControlEvents.TouchUpInside)

        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 46
        } else {
            let eventInfo = self.tableData[indexPath.row] as! [String:AnyObject]
            let cellHelper = ReminderCellViewHelper(rootViewController: self, eventInfo: eventInfo)
            let cellHeight:CGFloat = cellHelper.getCellHeight()
            print("cell height \(cellHeight)")
            return cellHeight
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        } else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("ReminderDetailSegue", sender: nil)
        let postInfo = self.tableData[indexPath.row] as! [String:AnyObject]
        self.currentEventId = postInfo["eventId"] as! String
    }
    
    override func performSegueWithIdentifier(identifier: String, sender: AnyObject?) {
        if identifier == "ReminderDetailSegue" {
            
        }
    }
    
    func reminderActionButtonOnClick(sender:UIButton!) {
        print("action button clicked: \(sender.tag)")
        self.currentIndex = sender.tag
        let eventInfo = self.tableData[self.currentIndex] as! [String:AnyObject]
        self.currentEventId = eventInfo["event_id"] as! String
        let popup:UIActionSheet = UIActionSheet(title: "Select Reminder Action:", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles:
            "Complete",
            "Reject",
            "Delay")
        popup.showInView(self.view)
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        print(buttonIndex)
        var reminderApiUrl:String!
        switch buttonIndex {
        case 1:
            reminderApiUrl = "\(const_APIEndpoint)/main/event/reminder/complete/"
            break
        case 2:
            reminderApiUrl = "\(const_APIEndpoint)/main/event/reminder/reject/"
            break;
        case 3:
            reminderApiUrl = "\(const_APIEndpoint)/main/event/reminder/delay/"
            break;
        default:
            break
        }
        let postData = ["event_id": self.currentEventId]
        APIEventHelper(url: reminderApiUrl, data: postData, delegate: self).POST("reminder")
    }
}
