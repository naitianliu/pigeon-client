//
//  SelectContactsViewController.swift
//  pigeon
//
//  Created by Liu, Naitian on 10/11/15.
//  Copyright © 2015 naitianliu. All rights reserved.
//

import UIKit

protocol SelectContactsViewControllerDelegate {
    func finishSelectContacts(userIdArray:[String])
}

class SelectContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var delegate:SelectContactsViewControllerDelegate?
    
    var contactList:[AnyObject]!
    
    var tableData:[[[String:AnyObject]]] = []
    var indexArray = []
    
    var userIdArray:[String] = []
    
    var selectContactTableUIHelper:SelectContactsTableUIHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.selectContactTableUIHelper = SelectContactsTableUIHelper(view: self.view)
        
        self.contactList = ContactModelHelper().getContactList()
        print(self.contactList)
        var contactDict:[String:[String:AnyObject]] = [:]
        var contactArray:[String] = []
        for  item in self.contactList {
            var contactInfo = item as! [String:AnyObject]
            contactInfo["selected"] = false
            let name = contactInfo["nickname"] as! String
            contactArray.append(name)
            contactDict[name] = contactInfo
        }
        print(contactDict)
        self.indexArray = ChineseString.IndexArray(contactArray)
        print(indexArray)
        let letterResultArray = ChineseString.LetterSortArray(contactArray)
        print(letterResultArray)
        var newArray:[[[String:AnyObject]]] = []
        for (var i=0; i<letterResultArray.count; i++) {
            let rowArray:[String] = letterResultArray[i] as! [String]
            print(rowArray)
            var tempArray:[[String:AnyObject]] = []
            for (var j=0; j<rowArray.count; j++) {
                let name:String = rowArray[j]
                let info:[String:AnyObject] = contactDict[name]!
                tempArray.append(info)
            }
            newArray.append(tempArray)
        }
        self.tableData = newArray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doneButtonOnClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            self.delegate?.finishSelectContacts(self.userIdArray)
        }
    }
    
    @IBAction func cancelButtonOnClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.tableData.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let row:[AnyObject] = self.tableData[section]
        return row.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let letter = self.indexArray[section] as! String
        return letter
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "SelectContactsCell")
        let rowArray:[AnyObject] = self.tableData[indexPath.section]
        let contactInfo:[String:AnyObject] = rowArray[indexPath.row] as! [String:AnyObject]
        self.selectContactTableUIHelper.setupCell(cell, contactInfo: contactInfo)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if self.tableData[indexPath.section][indexPath.row]["selected"] as! Bool {
            self.tableData[indexPath.section][indexPath.row]["selected"] = false
        } else {
            self.tableData[indexPath.section][indexPath.row]["selected"] = true
        }
        let userId = self.tableData[indexPath.section][indexPath.row]["user_id"] as! String
        if let index = userIdArray.indexOf(userId) {
            self.userIdArray.removeAtIndex(index)
        } else {
            self.userIdArray.append(userId)
        }
        print(self.userIdArray)
        self.tableView.reloadData()
    }
    
}
