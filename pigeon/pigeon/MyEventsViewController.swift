//
//  MyEventsViewController.swift
//  pigeon
//
//  Created by Liu, Naitian on 9/3/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import UIKit
import SVPullToRefresh

class MyEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HZPhotoBrowserDelegate, APIEventHelperDelegate {
    
    // let apiUrl:String = "\(const_APIEndpoint)/main/get_event_list/"
    
    let myProfileURL:String = "http://tp3.sinaimg.cn/2525851962/180/40000907046/1"
    let newPosts = SampleDataEvent().newPosts
    let EventTypeArray = const_EventTypeArray
    
    var currentIndex = ["row": 0, "col": 0]

    @IBOutlet weak var tableView: UITableView!
    
    var tableData:[AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableData = self.newPosts

        // Do any additional setup after loading the view.
        print(self.tableView.backgroundColor)
        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1), atScrollPosition: UITableViewScrollPosition.Top, animated: false)
        
        self.tableView.addPullToRefreshWithActionHandler { () -> Void in
            // APIEventHelper(url: self.apiUrl, data: nil, delegate: self).GET()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func beforeSendRequest() {
        
    }
    
    func afterReceiveResponse(responseData: AnyObject) {
        self.tableData = responseData as! [AnyObject]
        self.tableData = self.newPosts
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
        /*
        var cell = tableView.dequeueReusableCellWithIdentifier("MyEventCell", forIndexPath: indexPath) as? UITableViewCell
        
        if cell == nil {
            print("cell null")
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MyEventCell")
        }*/
        
        var cell:UITableViewCell!
        
        if indexPath.section == 0 {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "EventUpdateCell")
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell.textLabel?.text = EventTypeArray[indexPath.row]["name"]
            let imgName:String = EventTypeArray[indexPath.row]["img"]!
            cell.imageView?.image = UIImage(named: imgName)
        } else {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MyEventCell")
            let postInfo = self.tableData[indexPath.row] as! [String:AnyObject]
            let renderCellHelper = RenderEventCellHelper(view:self.view, postInfo:postInfo)
            renderCellHelper.setCell(cell, view: self.view)
            let eventButton:UIButton = renderCellHelper.eventButton
            eventButton.tag = indexPath.row
            eventButton.addTarget(self, action: "eventButtonPressDown:", forControlEvents: UIControlEvents.TouchDown)
            eventButton.addTarget(self, action: "eventButtonOnClick:", forControlEvents: UIControlEvents.TouchUpInside)
            var pictureButtonArray:[UIButton] = renderCellHelper.pictureButtonArray
            if pictureButtonArray.count == 1 {
                pictureButtonArray[0].addTarget(self, action: "pictureButton0OnClick:", forControlEvents: UIControlEvents.TouchUpInside)
                pictureButtonArray[0].tag = indexPath.row
            } else if pictureButtonArray.count == 2 {
                pictureButtonArray[0].addTarget(self, action: "pictureButton0OnClick:", forControlEvents: UIControlEvents.TouchUpInside)
                pictureButtonArray[0].tag = indexPath.row
                pictureButtonArray[1].addTarget(self, action: "pictureButton1OnClick:", forControlEvents: UIControlEvents.TouchUpInside)
                pictureButtonArray[1].tag = indexPath.row
            } else if pictureButtonArray.count == 3 {
                pictureButtonArray[0].addTarget(self, action: "pictureButton0OnClick:", forControlEvents: UIControlEvents.TouchUpInside)
                pictureButtonArray[0].tag = indexPath.row
                pictureButtonArray[1].addTarget(self, action: "pictureButton1OnClick:", forControlEvents: UIControlEvents.TouchUpInside)
                pictureButtonArray[1].tag = indexPath.row
                pictureButtonArray[2].addTarget(self, action: "pictureButton2OnClick:", forControlEvents: UIControlEvents.TouchUpInside)
                pictureButtonArray[2].tag = indexPath.row
            }
        }
        
        return cell
    }
    
    func eventButtonPressDown(sender:UIButton!) {
        sender.backgroundColor = UIColor.lightGrayColor()
        sender.alpha = 0.3
    }
    
    func eventButtonOnClick(sender:UIButton!) {
        let index = sender.tag
        print("test \(index)")
        sender.backgroundColor = UIColor.clearColor()
        
        self.performSegueWithIdentifier("EventDetailSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EventDetailSegue" {
            
        } else if segue.identifier == "PostDetailSegue" {
            
        }
    }
    
    func pictureButton0OnClick(sender:UIButton!) {
        self.currentIndex["row"] = sender.tag
        self.currentIndex["col"] = 0
        var postInfo = self.tableData[self.currentIndex["row"]!] as! [String:AnyObject]
        let pictureUrls = postInfo["pictureUrls"] as! [String]
        let browserVC:HZPhotoBrowser = HZPhotoBrowser()
        browserVC.sourceImagesContainerView = self.view
        browserVC.imageCount = pictureUrls.count
        browserVC.currentImageIndex = 0
        browserVC.delegate = self
        browserVC.show()
    }
    
    func pictureButton1OnClick(sender:UIButton!) {
        self.currentIndex["row"] = sender.tag
        self.currentIndex["col"] = 1
        var postInfo = self.tableData[self.currentIndex["row"]!] as! [String:AnyObject]
        let pictureUrls = postInfo["pictureUrls"] as! [String]
        let browserVC:HZPhotoBrowser = HZPhotoBrowser()
        browserVC.sourceImagesContainerView = self.view
        browserVC.imageCount = pictureUrls.count
        browserVC.currentImageIndex = 1
        browserVC.delegate = self
        browserVC.show()
    }
    
    func pictureButton2OnClick(sender:UIButton!) {
        self.currentIndex["row"] = sender.tag
        self.currentIndex["col"] = 2
        var postInfo = self.tableData[self.currentIndex["row"]!] as! [String:AnyObject]
        let pictureUrls = postInfo["pictureUrls"] as! [String]
        let browserVC:HZPhotoBrowser = HZPhotoBrowser()
        browserVC.sourceImagesContainerView = self.view
        browserVC.imageCount = pictureUrls.count
        browserVC.currentImageIndex = 2
        browserVC.delegate = self
        browserVC.show()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 46
        } else {
            let postInfo = self.tableData[indexPath.row] as! [String:AnyObject]
            let renderCellHelper = RenderEventCellHelper(view:self.view, postInfo:postInfo)
            let cellHeight:CGFloat = renderCellHelper.getCellHeight()
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

    }
    
    func photoBrowser(browser: HZPhotoBrowser!, placeholderImageForIndex index: Int) -> UIImage! {
        return UIImage(named: "Apple")
    }
    
    func photoBrowser(browser: HZPhotoBrowser!, highQualityImageURLForIndex index: Int) -> NSURL! {
        var postInfo = self.tableData[self.currentIndex["row"]!] as! [String:AnyObject]
        var pictureUrls = postInfo["pictureUrls"] as! [String]
        return NSURL(string: pictureUrls[index])
    }

}
