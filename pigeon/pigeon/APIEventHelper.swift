//
//  APICreateEvent.swift
//  pigeon
//
//  Created by Liu, Naitian on 9/17/15.
//  Copyright © 2015 naitianliu. All rights reserved.
//

import Foundation
import Alamofire

protocol APIEventHelperDelegate {
    func beforeSendRequest()
    func afterReceiveResponse(responseData:AnyObject, index:String?)
}

class APIEventHelper: NSObject {
    
    let token:String = NSKeyedUnarchiver.unarchiveObjectWithData(NSUserDefaults.standardUserDefaults().objectForKey("token") as! NSData) as! String
    var headers:[String: String] = ["Content-Type": "application/json"]
    
    var delegate:APIEventHelperDelegate?
    
    var data:[String:AnyObject]?
    
    var url:String!
    
    init(url:String!, data:[String:AnyObject]?, delegate:APIEventHelperDelegate) {
        super.init()
        
        self.delegate = delegate
        self.url = url
        self.data = data
        self.headers["Authorization"] = "Token \(self.token)"
        
    }
    
    func POST(index:String?) {
        self.delegate?.beforeSendRequest()
        request(.POST, self.url, parameters: self.data, encoding: .JSON, headers: self.headers).responseJSON(options: NSJSONReadingOptions.AllowFragments) { (request, response, result) -> Void in
            switch result {
            case .Success(let JSON):
                print(JSON)
                self.delegate?.afterReceiveResponse(JSON, index:index)
            case .Failure(let data, let error):
                print(data)
                print(error)
            }
        }
    }
    
    func GET(index:String?) {
        self.delegate?.beforeSendRequest()
        request(.GET, self.url, parameters: self.data, headers: self.headers).responseJSON(options: NSJSONReadingOptions.AllowFragments) { (request, response, result) -> Void in
            switch result {
            case .Success(let JSON):
                print(JSON)
                self.delegate?.afterReceiveResponse(JSON, index:index)
            case .Failure(let data, let error):
                print(data)
                print(error)
            }
        }
    }
}