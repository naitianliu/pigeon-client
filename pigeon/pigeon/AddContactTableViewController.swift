//
//  AddContactTableViewController.swift
//  pigeon
//
//  Created by Liu, Naitian on 9/2/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import UIKit

class AddContactTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {

    var searchController:UISearchController!
    var searchResults = ["test1", "test2", "test3", "test4"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var searchResultsController:UINavigationController = self.storyboard?.instantiateViewControllerWithIdentifier("SearchContactNavigationController") as! UINavigationController
        self.searchController = UISearchController(searchResultsController: searchResultsController)
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.frame = CGRect(x: self.searchController.searchBar.frame.origin.x, y: self.searchController.searchBar.frame.origin.y, width: self.searchController.searchBar.frame.size.width, height: 44.0)
        self.tableView.tableHeaderView = self.searchController.searchBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if section == 0 {
            return 1
        } else if section == 1 {
            return 3
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 55
        } else if indexPath.section == 1 {
            return 50
        } else {
            return 46
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return " "
        } else {
            return "从第三方应用导入联系人"
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40
        } else {
            return 40
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40
        } else {
            return 40
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("addContactCell", forIndexPath: indexPath) as? UITableViewCell

        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "addContactCell")
        }
        
        if indexPath.section == 0 {
            cell?.textLabel?.text = "搜索昵称或用户名添加好友"
            cell?.textLabel?.textColor = UIColor.grayColor()
            cell?.textLabel?.textAlignment = NSTextAlignment.Center
        } else if indexPath.section == 1 {
            cell?.textLabel?.textColor = UIColor.blackColor()
            cell?.textLabel?.textAlignment = NSTextAlignment.Left
            cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            switch (indexPath.row) {
            case 0:
                cell?.imageView?.image = UIImage(named: "icon-weibo")
                cell?.textLabel?.text = "新浪微博"
            case 1:
                cell?.imageView?.image = UIImage(named: "icon-qq")
                cell?.textLabel?.text = "腾讯QQ"
            case 2:
                cell?.imageView?.image = UIImage(named: "icon-weixin")
                cell?.textLabel?.text = "微信"
            default:
                break
            }
        }

        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var contactStoryboard:UIStoryboard = UIStoryboard(name: "Contact", bundle: nil)
        var vendorContactVC:VendorContactViewController = contactStoryboard.instantiateViewControllerWithIdentifier("VendorContactViewController") as! VendorContactViewController
        if indexPath.section == 1 && indexPath.row == 0 {
            vendorContactVC.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
            self.presentViewController(vendorContactVC, animated: true, completion: { () -> Void in
                
            })
        } else if indexPath.section == 0 {

        }
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if (self.searchController.searchResultsController != nil) {
            var navController:UINavigationController = self.searchController.searchResultsController as! UINavigationController
            var vc:ContactSearchResultsTableViewController = navController.topViewController as! ContactSearchResultsTableViewController
            vc.searchResults = self.searchResults
            vc.tableView.reloadData()
        }
    }
    
}
