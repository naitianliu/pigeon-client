//
//  Constant.swift
//  pigeon
//
//  Created by Liu, Naitian on 9/6/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import Foundation

let const_MyUserId = NSKeyedUnarchiver.unarchiveObjectWithData(NSUserDefaults.standardUserDefaults().objectForKey("user_id") as! NSData) as! String
let const_MyNickname = NSKeyedUnarchiver.unarchiveObjectWithData(NSUserDefaults.standardUserDefaults().objectForKey("nickname") as! NSData) as! String
let const_MyImgURL = NSKeyedUnarchiver.unarchiveObjectWithData(NSUserDefaults.standardUserDefaults().objectForKey("img_url") as! NSData) as! String

let const_APIEndpoint = "http://localhost:9000"

let const_EventTypeArray = [
    ["img": "icon-weixin", "name": "查看任务"],
    ["img": "icon-qq", "name": "查看活动"],
    ["img": "icon-weibo", "name": "查看话题"],
    ["img": "icon-weixin", "name": "查看提醒"],
]

let const_CognitoRegionType = AWSRegionType.USEast1
let const_DefaultServiceRegionType = AWSRegionType.USWest1
let const_CognitoIdentityPoolId = "us-east-1:71d07ad0-24bb-4995-93ff-2719b2d0190b"
let const_S3BucketName = "banyansocial"
let const_S3URL = "https://s3-us-west-1.amazonaws.com/banyansocial/"

