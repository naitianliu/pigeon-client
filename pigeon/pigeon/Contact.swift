//
//  Contact.swift
//  pigeon
//
//  Created by Liu, Naitian on 10/11/15.
//  Copyright © 2015 naitianliu. All rights reserved.
//

import RealmSwift

class Contact: Object {
    
    dynamic var userId = ""
    dynamic var imgURL = ""
    dynamic var nickname = ""
    dynamic var gender = ""

    override static func primaryKey() -> String? {
        return "userId"
    }
}

class ContactModelHelper {
    
    init() {
        
    }
    
    func addNewContact(userId:String, imgURL:String?, nickname:String, gender:String?) {
        let contactObj = Contact()
        // set property
        contactObj.userId = userId
        if imgURL == nil {
            contactObj.imgURL = ""
        } else {
            contactObj.imgURL = imgURL!
        }
        contactObj.nickname = nickname
        if gender == nil {
            contactObj.gender = ""
        } else {
            contactObj.gender = gender!
        }
        // check if userId exits, update or insert
        do {
            let realm = try Realm()
            let contacts = realm.objects(Contact).filter("userId = '\(userId)'")
            if contacts.count == 0 {
                try realm.write { () -> Void in
                    realm.add(contactObj)
                }
            } else {
                for contact in contacts {
                    try realm.write({ () -> Void in
                        contact.imgURL = contactObj.imgURL
                        contact.nickname = contactObj.nickname
                        contact.gender = contactObj.gender
                        
                    })
                }
            }
            
        } catch {
            print(error)
        }
        
    }
    
    func getContactList() -> [AnyObject] {
        var contactList:[AnyObject] = []
        do {
            let realm = try Realm()
            let contacts = realm.objects(Contact)
            for contact in contacts {
                var contactDict:[String:String] = [:]
                contactDict["user_id"] = contact.userId
                contactDict["img_url"] = contact.imgURL
                contactDict["nickname"] = contact.nickname
                contactDict["gender"] = contact.gender
                contactList.append(contactDict)
            }
        } catch {
            print(error)
        }
        return contactList
    }
    
    func getContactInfoListByUserIdArray(userIdArray:[String]) -> [AnyObject] {
        var contactList:[AnyObject] = []
        do {
            let realm = try Realm()
            let contacts = realm.objects(Contact)
            for contact in contacts {
                if userIdArray.contains(contact.userId) {
                    var contactDict:[String:String] = [:]
                    contactDict["user_id"] = contact.userId
                    contactDict["img_url"] = contact.imgURL
                    contactDict["nickname"] = contact.nickname
                    contactDict["gender"] = contact.gender
                    contactList.append(contactDict)
                }
            }
        } catch {
            print(error)
        }
        return contactList
    }
}
