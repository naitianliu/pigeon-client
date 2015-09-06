//
//  MyEventsViewController.swift
//  pigeon
//
//  Created by Liu, Naitian on 9/3/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import UIKit

class MyEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let myProfileURL:String = "http://tp3.sinaimg.cn/2525851962/180/40000907046/1"
    let newPosts = SampleDataEvent().newPosts

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        println(self.tableView.backgroundColor)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newPosts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        /*
        var cell = tableView.dequeueReusableCellWithIdentifier("MyEventCell", forIndexPath: indexPath) as? UITableViewCell
        
        if cell == nil {
            print("cell null")
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MyEventCell")
        }*/
        
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MyEventCell")
        var postInfo = newPosts[indexPath.row] as! [String:AnyObject]
        var renderCellHelper = RenderEventCellHelper(view:self.view, postInfo:postInfo)
        renderCellHelper.setCell(cell, view: self.view)
        var eventButton:UIButton = renderCellHelper.eventButton
        eventButton.tag = indexPath.row
        eventButton.addTarget(self, action: "eventButtonPressDown:", forControlEvents: UIControlEvents.TouchDown)
        eventButton.addTarget(self, action: "eventButtonOnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        return cell
    }
    
    func eventButtonPressDown(sender:UIButton!) {
        sender.backgroundColor = UIColor.lightGrayColor()
        sender.alpha = 0.3
    }
    
    func eventButtonOnClick(sender:UIButton!) {
        var index = sender.tag
        println("test \(index)")
        sender.backgroundColor = UIColor.clearColor()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var postInfo = newPosts[indexPath.row] as! [String:AnyObject]
        var renderCellHelper = RenderEventCellHelper(view:self.view, postInfo:postInfo)
        var cellHeight:CGFloat = renderCellHelper.getCellHeight()
        return cellHeight
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
