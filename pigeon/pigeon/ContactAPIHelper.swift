//
//  ContactAPIHelper.swift
//  pigeon
//
//  Created by Liu, Naitian on 10/11/15.
//  Copyright © 2015 naitianliu. All rights reserved.
//

import Foundation

class ContactAPIHelper: APIEventHelperDelegate {
    init() {
        
    }
    
    func syncContactList() {
        let url = "\(const_APIEndpoint)/contacts/person/get_friend_list/"
        APIEventHelper(url: url, data: nil, delegate: self).GET(nil)
    }
    
    func beforeSendRequest() {
        
    }
    
    func afterReceiveResponse(responseData: AnyObject, index: String?) {
        let contactModelHelper = ContactModelHelper()
        let contactList = responseData as! [AnyObject]
        for item in contactList {
            let contactDict = item as! [String:String]
            contactModelHelper.addNewContact(contactDict["user_id"]!, imgURL: contactDict["img_url"], nickname: contactDict["nickname"]!, gender: contactDict["gender"])
        }
    }
}