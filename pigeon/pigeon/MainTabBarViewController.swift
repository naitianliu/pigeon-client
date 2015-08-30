//
//  MainTabBarViewController.swift
//  pigeon
//
//  Created by Liu, Naitian on 8/29/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController, BROptionButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var brOptions:BROptionsButton = BROptionsButton(tabBar: self.tabBar, forItemIndex: 2, delegate: self)
        brOptions.setImage(UIImage(named: "Apple"), forBROptionsButtonState: BROptionsButtonStateNormal)
        brOptions.setImage(UIImage(named: "close"), forBROptionsButtonState: BROptionsButtonStateOpened)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func brOptionsButtonNumberOfItems(brOptionsButton: BROptionsButton!) -> Int {
        return 4
    }
    
    func brOptionsButton(brOptionsButton: BROptionsButton!, didSelectItem item: BROptionItem!) {
        
    }
    
    func brOptionsButton(brOptionsButton: BROptionsButton!, titleForItemAtIndex index: Int) -> String! {
        var title:String!
        switch (index) {
        case 0:
            title = "任务"
        case 1:
            title = "提醒"
        case 2:
            title = "话题"
        case 3:
            title = "活动"
        default:
            title = "unknown"
        }
        return title
    }
    
    
    /*
    func brOptionsButton(brOptionsButton: BROptionsButton!, imageForItemAtIndex index: Int) -> UIImage! {
        return UIImage(named: "Apple")
    }
    */
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
