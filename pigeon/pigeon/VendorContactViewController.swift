//
//  VendorContactViewController.swift
//  pigeon
//
//  Created by Liu, Naitian on 9/2/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import UIKit


class VendorContactViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var contactTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonOnClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("VendorContactTableCell", forIndexPath: indexPath)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "VendorContactTableCell")
        }
        
        return cell!
    }
}
