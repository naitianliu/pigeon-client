//
//  VendorLoginAPICall.swift
//  pigeon
//
//  Created by Liu, Naitian on 8/29/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import Foundation
import MBProgressHUD

class VendorLoginAPICall:NSObject, BaseAPIHelperDelegate {
    
    let url = "\(const_APIEndpoint)/user/vendor_login/"
    
    var view:UIView!
    var vendorType:String!
    var vendorId:String!
    var accessToken:String!
    
    init(view:UIView, vendorType:String, vendorId:String, accessToken:String) {
        super.init()
        
        self.view = view
        
        self.vendorType = vendorType
        self.vendorId = vendorId
        self.accessToken = accessToken
    }
    
    func run() {
        let reqData:[String:String] = [
            "vendor_id": self.vendorId,
            "vendor_type": self.vendorType,
            "access_token": self.accessToken
        ]
        print(reqData)
        BaseAPIHelper(token:nil, delegate:self).GET(self.url, requestData: reqData)
    }
    
    func beforeSendRequest() {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
    }
    
    func afterReceiveResponse(responseData: AnyObject) {
        var data = responseData as! [String:String]
        let token = data["token"]!
        let userId = data["user_id"]!
        let nickname = data["nickname"]!
        let imgURL = data["img_url"]!
        print(token)
        NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject(token), forKey: "token")
        NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject(userId), forKey: "user_id")
        NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject(nickname), forKey: "nickname")
        NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject(imgURL), forKey: "img_url")
        MBProgressHUD.hideHUDForView(self.view, animated: true)
        
        let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarViewController:UITabBarController = mainStoryBoard.instantiateViewControllerWithIdentifier("MainTabBarController") as! UITabBarController
        self.view.window?.rootViewController = mainTabBarViewController
    }
}