//
//  EventDetailViewController.swift
//  pigeon
//
//  Created by Liu, Naitian on 9/6/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let eventPosts = SampleDataEvent().eventPosts
    var eventDetailViewHelper:EventDetailViewHelper!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.eventDetailViewHelper = EventDetailViewHelper(viewController:self)
        self.eventDetailViewHelper.setupUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func segmentedControlOnChanged(sender: AnyObject) {
        var selectedIndex = self.segmentedControl.selectedSegmentIndex
        println(selectedIndex)
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.eventPosts.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        /*
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("EventDetailCell", forIndexPath: indexPath) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "EventDetailCell")
        }*/
        
        var cell:UITableViewCell!
        
        if indexPath.section == 0 {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "EventDetailCell")
            var eventInfo = SampleDataEvent().eventInfo
            var eventInfoView:UIView = self.eventDetailViewHelper.setEventInfoView(eventInfo)
            cell.contentView.addSubview(eventInfoView)
        } else {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "EventPostCell")
            var eventPost = eventPosts[indexPath.row] as! [String:AnyObject]
            var eventPostCellHelper:EventPostCellHelper = EventPostCellHelper(view: self.view, eventPost: eventPost)
            eventPostCellHelper.setupCell(cell)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300
        } else {
            var eventPost = eventPosts[indexPath.row] as! [String:AnyObject]
            var eventPostCellHelper:EventPostCellHelper = EventPostCellHelper(view: self.view, eventPost: eventPost)
            var cellHeight:CGFloat = eventPostCellHelper.getCellHeight()
            return cellHeight
        }
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var yOffset:CGFloat = scrollView.contentOffset.y
        self.eventDetailViewHelper.changeViewByScroll(yOffset)
    }
}
