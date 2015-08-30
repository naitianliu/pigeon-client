//
//  BaseAPIHelper.swift
//  pigeon
//
//  Created by Liu, Naitian on 8/29/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import Foundation
import Alamofire

protocol BaseAPIHelperDelegate {
    func beforeSendRequest()
    func afterReceiveResponse(responseData:AnyObject)
}

class BaseAPIHelper: NSObject {
    
    var basePIHelperDelegate:BaseAPIHelperDelegate?
    var headers:[String: String] = ["Content-Type": "application/json"]
    
    init(token:String?, delegate:BaseAPIHelperDelegate) {
        super.init()
        
        self.basePIHelperDelegate = delegate
        
        if token != nil {
            self.headers["Authorization"] = "Token \(token)"
        }
        
        Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = headers
    }
    
    func GET(url:String, requestData:[String: String]) {
        basePIHelperDelegate?.beforeSendRequest()
        Alamofire.request(.GET, url, parameters: requestData).responseJSON(options: NSJSONReadingOptions.AllowFragments) { (request, response, data, error) -> Void in
            println(data)
            self.basePIHelperDelegate?.afterReceiveResponse(data!)
        }
    }
    
    func POST(url:String, requestData:[String: AnyObject]) {
        basePIHelperDelegate?.beforeSendRequest()
        Alamofire.request(.POST, url, parameters: requestData, encoding: .JSON).responseJSON { (request, response, data, error) -> Void in
            self.basePIHelperDelegate?.afterReceiveResponse(data!)
        }
    }
}