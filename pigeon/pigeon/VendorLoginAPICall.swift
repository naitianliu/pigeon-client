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
    
    let url = "http://192.168.102.44:9000/user/vendor_login/"
    
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
        print(token)
        NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject(token), forKey: "token")
        MBProgressHUD.hideHUDForView(self.view, animated: true)
    }
}