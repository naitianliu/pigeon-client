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
    
    func createPostButtonOnClick(sender:UIButton!) {
        let createPostViewController:UIViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("CreatePostViewController"))!
        createPostViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        self.presentViewController(createPostViewController, animated: true) { () -> Void in
            
        }
    }
    
    @IBAction func segmentedControlOnChanged(sender: AnyObject) {
        let selectedIndex = self.segmentedControl.selectedSegmentIndex
        print(selectedIndex)
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
            let eventInfo = SampleDataEvent().eventInfo
            let eventInfoView:UIView = self.eventDetailViewHelper.setEventInfoView(eventInfo)
            cell.contentView.addSubview(eventInfoView)
        } else {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "EventPostCell")
            let eventPost = eventPosts[indexPath.row] as! [String:AnyObject]
            let eventPostCellHelper:EventPostCellHelper = EventPostCellHelper(view: self.view, eventPost: eventPost)
            eventPostCellHelper.setupCell(cell)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300
        } else {
            let eventPost = eventPosts[indexPath.row] as! [String:AnyObject]
            let eventPostCellHelper:EventPostCellHelper = EventPostCellHelper(view: self.view, eventPost: eventPost)
            let cellHeight:CGFloat = eventPostCellHelper.getCellHeight()
            return cellHeight
        }
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            let view = self.eventDetailViewHelper.setupFooterView()
            let createPostButton:UIButton = self.eventDetailViewHelper.createPostButton
            createPostButton.addTarget(self, action: Selector("createPostButtonOnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
            return view
        } else {
            return nil
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 30
        } else {
            return 0
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let yOffset:CGFloat = scrollView.contentOffset.y
        self.eventDetailViewHelper.changeViewByScroll(yOffset)
    }
}
