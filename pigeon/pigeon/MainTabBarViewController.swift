//
//  MainTabBarViewController.swift
//  pigeon
//
//  Created by Liu, Naitian on 8/29/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController, BROptionButtonDelegate {
    
    let eventStoryboard:UIStoryboard = UIStoryboard(name: "Event", bundle: nil)
    let contactStoryboard:UIStoryboard = UIStoryboard(name: "Contact", bundle: nil)
    let historyStoryboard:UIStoryboard = UIStoryboard(name: "History", bundle: nil)
    let meStoryboard:UIStoryboard = UIStoryboard(name: "Me", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let eventNavigationController:UINavigationController = eventStoryboard.instantiateViewControllerWithIdentifier("EventNavigationController") as! UINavigationController
        eventNavigationController.tabBarItem.title = "我的事件"
        // eventNavigationController.tabBarItem.image = UIImage(named: "Apple")
        let contactNavigationController:UINavigationController = contactStoryboard.instantiateViewControllerWithIdentifier("ContactNavigationController") as! UINavigationController
        contactNavigationController.tabBarItem.title = "联系人"
        // contactNavigationController.tabBarItem.image = UIImage(named: "Apple")
        let historyNavigationController:UINavigationController = historyStoryboard.instantiateViewControllerWithIdentifier("HistoryNavigationController") as! UINavigationController
        historyNavigationController.tabBarItem.title = "历史"
        // historyNavigationController.tabBarItem.image = UIImage(named: "Apple")
        let meNavigationController:UINavigationController = meStoryboard.instantiateViewControllerWithIdentifier("MeNavigationController") as! UINavigationController
        meNavigationController.tabBarItem.title = "我"
        // meNavigationController.tabBarItem.image = UIImage(named: "Apple")
        
        let middleViewController:UIViewController = UIViewController()
        
        self.setViewControllers([eventNavigationController, contactNavigationController, middleViewController, historyNavigationController, meNavigationController], animated: false)
        
        let brOptions:BROptionsButton = BROptionsButton(tabBar: self.tabBar, forItemIndex: 2, delegate: self)
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
        let eventStoryboard:UIStoryboard = UIStoryboard(name: "Event", bundle: nil)
        let index = item.index
        switch (index) {
        case 0:
            let createTaskViewController:UIViewController = eventStoryboard.instantiateViewControllerWithIdentifier("CreateTaskViewController")
            createTaskViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
            self.presentViewController(createTaskViewController, animated: true, completion: { () -> Void in
                
            })
        case 1:
            let createReminderViewController:UIViewController = eventStoryboard.instantiateViewControllerWithIdentifier("CreateReminderViewController")
            createReminderViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
            self.presentViewController(createReminderViewController, animated: true, completion: nil)
        default:
            break;
        }
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
        return UIImage(named: "icon-weixin")
    }*/
    
    func brOptionsButton(optionsButton: BROptionsButton!, willDisplayButtonItem button: BROptionItem!) {

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
