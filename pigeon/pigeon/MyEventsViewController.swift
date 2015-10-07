//
//  MyEventsViewController.swift
//  pigeon
//
//  Created by Liu, Naitian on 9/3/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import UIKit
import SVPullToRefresh

class MyEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, APIEventHelperDelegate {
    
    let apiUrl:String = "\(const_APIEndpoint)/main/event/list/updated_events/"
    
    let EventTypeArray = const_EventTypeArray
    
    var currentIndex = ["row": 0, "col": 0]
    var currentEventId:String = ""

    @IBOutlet weak var tableView: UITableView!
    
    var tableData:[AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1), atScrollPosition: UITableViewScrollPosition.Top, animated: false)
        
        self.tableView.addPullToRefreshWithActionHandler { () -> Void in
            APIEventHelper(url: self.apiUrl, data: nil, delegate: self).GET()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func beforeSendRequest() {
        
    }
    
    func afterReceiveResponse(responseData: AnyObject) {
        self.tableData = responseData["result"] as! [AnyObject]
        self.tableView.reloadData()
        self.tableView.pullToRefreshView.stopAnimating()
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
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MyEventCell")
            let eventInfo = self.tableData[indexPath.row] as! [String:AnyObject]
            ReminderCellViewHelper(rootViewController: self, eventInfo: eventInfo).setupCell(cell)
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
        self.performSegueWithIdentifier("PostDetailSegue", sender: nil)
        let postInfo = self.tableData[indexPath.row] as! [String:AnyObject]
        self.currentEventId = postInfo["eventId"] as! String
    }
}
