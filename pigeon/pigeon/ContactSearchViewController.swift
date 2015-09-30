//
//  ContactSearchViewController.swift
//  pigeon
//
//  Created by Liu, Naitian on 9/29/15.
//  Copyright © 2015 naitianliu. All rights reserved.
//

import UIKit

class ContactSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var userListArray:[AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.userListArray = [[],[]]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userListArray[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "ContactSearchResultsCell")
        let userInfo:[String:String] = self.userListArray[indexPath.section][indexPath.row] as! [String:String]
        let imgUrl:String = userInfo["img_url"]!
        let nickname:String = userInfo["nickname"]!
        let user_id:String = userInfo["user_id"]!
        
        cell.textLabel?.text = nickname
        cell.detailTextLabel?.text = "板眼ID: \(user_id)"
        cell.imageView?.sd_setImageWithURL(NSURL(string: imgUrl), placeholderImage: UIImage(named: "Apple"))
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "User list by id"
        } else {
            return "User List by nickname"
        }
    }
}