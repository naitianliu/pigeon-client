//
//  TableViewHelper.swift
//  pigeon
//
//  Created by Liu, Naitian on 9/1/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import Foundation

class TestTableViewHelper:NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var rootViewController:UIViewController!
    var groupView:UIView!
    var tableView:UITableView!
    
    var test = UIViewController()
    
    init(rootViewController:UIViewController, groupView:UIView, delegate:UITableViewDelegate, dataSource:UITableViewDataSource) {
        super.init()
        
        self.rootViewController = rootViewController
        self.groupView = groupView
        
        self.tableView = UITableView(frame: self.groupView.frame)
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
        self.groupView.addSubview(self.tableView)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "TestTableCell")
        return cell
    }
}