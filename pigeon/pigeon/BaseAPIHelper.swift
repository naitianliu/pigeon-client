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
        
        // Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = headers
    }
    
    func GET(url:String, requestData:[String: String]) {
        basePIHelperDelegate?.beforeSendRequest()
        
        request(.GET, url, parameters: requestData, headers: self.headers).responseJSON(options: NSJSONReadingOptions.AllowFragments) { (request, response, result) -> Void in
            switch result {
            case .Success(let JSON):
                print(JSON)
                self.basePIHelperDelegate?.afterReceiveResponse(JSON)
            case .Failure(let data, let error):
                print(data)
                print(error)
            }
        }

    }
    
    func POST(url:String, requestData:[String: AnyObject]) {
        basePIHelperDelegate?.beforeSendRequest()
        
        request(.POST, url, parameters: requestData, encoding: .JSON, headers: self.headers).responseJSON(options: NSJSONReadingOptions.AllowFragments) { (request, response, result) -> Void in
            switch result {
            case .Success(let JSON):
                print(JSON)
                self.basePIHelperDelegate?.afterReceiveResponse(JSON)
            case .Failure(let data, let error):
                print(data)
                print(error)
            }
        }
    }
}