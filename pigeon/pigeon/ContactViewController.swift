//
//  ContactViewController.swift
//  pigeon
//
//  Created by Liu, Naitian on 9/1/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    var groupView:UIView!
    var collectionView:UICollectionView!
    
    var searchController:UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.groupView = UIView(frame: CGRect(x: 0, y: 32, width: self.view.frame.width, height: self.view.frame.height - 32 - 32 - 23))
        self.groupView.backgroundColor = UIColor.whiteColor()
        self.collectionView = UICollectionView(frame: self.groupView.frame, collectionViewLayout: UICollectionViewFlowLayout())
        self.collectionView.backgroundColor = UIColor.whiteColor()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "GroupCollectionCell")
        self.groupView.addSubview(self.collectionView)
        self.view.addSubview(self.groupView)
        self.view.bringSubviewToFront(self.tableView)
        
        
        let searchResultsController:UINavigationController = self.storyboard?.instantiateViewControllerWithIdentifier("SearchContactNavigationController") as! UINavigationController
        self.searchController = UISearchController(searchResultsController: searchResultsController)
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.frame = CGRect(x: self.searchController.searchBar.frame.origin.x, y: self.searchController.searchBar.frame.origin.y, width: self.searchController.searchBar.frame.size.width, height: 44.0)
        self.tableView.tableHeaderView = self.searchController.searchBar
    }
    @IBAction func segmentedControlValueChanged(sender: AnyObject) {
        let selectedIndex = self.segmentedControl.selectedSegmentIndex
        if selectedIndex == 0 {
            self.view.bringSubviewToFront(self.tableView)
        } else {
            self.view.bringSubviewToFront(self.groupView)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchButtonOnClick(sender: AnyObject) {
        self.searchController.searchBar.becomeFirstResponder()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return nil
        } else {
            return "A"
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("ContactCell")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "ContactCell")
        }
        
        if indexPath.section == 0 {
            cell?.imageView?.image = UIImage(named: "close")
            cell?.textLabel?.text = "未注册联系人"
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60
        } else {
            return 44
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:UICollectionViewCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("GroupCollectionCell", forIndexPath: indexPath)
        let imageView:UIImageView = UIImageView(image: UIImage(named: "close"))
        imageView.frame = CGRect(x: 5, y: 5, width: 100, height: 100)
        cell.sizeToFit()
        let outerRect:CGRect = cell.contentView.frame
        let innerView:UIView = UIView(frame: CGRect(x: 7, y: 7, width: outerRect.width - 10, height: outerRect.width - 10))
        innerView.layer.borderWidth = 0.5
        innerView.layer.borderColor = UIColor.grayColor().CGColor
        innerView.addSubview(imageView)
        cell.contentView.addSubview(innerView)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.groupView.frame.width/2 - 5, height: self.groupView.frame.width/2 - 5)
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
    }
    
}
