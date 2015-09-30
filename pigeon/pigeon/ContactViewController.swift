//
//  ContactViewController.swift
//  pigeon
//
//  Created by Liu, Naitian on 9/1/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    var searchController:UISearchController!
    
    var pageMenu:CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let personContactVC:PersonContactViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PersonContactViewController") as! PersonContactViewController
        personContactVC.title = "Contacts"
        let groupContactVC:GroupContactViewController = self.storyboard?.instantiateViewControllerWithIdentifier("GroupContactViewController") as! GroupContactViewController
        groupContactVC.title = "Group"
        let controllerArray:[UIViewController] = [personContactVC, groupContactVC]
        let parameters: [CAPSPageMenuOption] = [
            .ScrollMenuBackgroundColor(UIColor.whiteColor()),
            .ViewBackgroundColor(UIColor.whiteColor()),
            .SelectionIndicatorColor(UIColor.orangeColor()),
            .AddBottomMenuHairline(false),
            .MenuItemSeparatorWidth(4.3),
            .UseMenuLikeSegmentedControl(true),
            .MenuItemSeparatorPercentageHeight(0.1),
            .MenuHeight(50.0),
            .MenuItemWidthBasedOnTitleTextWidth(true),
            .SelectedMenuItemLabelColor(UIColor.orangeColor()),
            .UnselectedMenuItemLabelColor(UIColor.lightGrayColor())
        ]
        let barHeight = (self.navigationController?.navigationBar.frame.height)!
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 64, self.view.frame.width, self.view.frame.height - barHeight), pageMenuOptions: parameters)
        self.view.addSubview(pageMenu!.view)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        let searchResultsController:UINavigationController = self.storyboard?.instantiateViewControllerWithIdentifier("SearchContactNavigationController") as! UINavigationController
        self.searchController = UISearchController(searchResultsController: searchResultsController)
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.frame = CGRect(x: self.searchController.searchBar.frame.origin.x, y: self.searchController.searchBar.frame.origin.y, width: self.searchController.searchBar.frame.size.width, height: 44.0)
        self.searchController.searchBar.sizeToFit()
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true
        // self.searchController.dimsBackgroundDuringPresentation = true
        self.navigationItem.titleView = self.searchController.searchBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchButtonOnClick(sender: AnyObject) {
        self.searchController.searchBar.becomeFirstResponder()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
    }
    
}
