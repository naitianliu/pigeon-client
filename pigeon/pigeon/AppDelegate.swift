//
//  AppDelegate.swift
//  pigeon
//
//  Created by Liu, Naitian on 8/21/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WeiboSDKDelegate {

    var window: UIWindow?
    
    let authStoryBoard:UIStoryboard = UIStoryboard(name: "Auth", bundle: nil)
    let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    var authLoginViewController:UIViewController!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // WXApi.registerApp("wx6002977c97c410d4")
        WeiboSDK.enableDebugMode(true)
        WeiboSDK.registerApp("3675401007")
        
        var token:String? = nil
        
        if NSUserDefaults.standardUserDefaults().objectForKey("token") != nil {
            token = NSKeyedUnarchiver.unarchiveObjectWithData(NSUserDefaults.standardUserDefaults().objectForKey("token") as! NSData) as? String
            print(token)
        }
        
        if token == nil {
            authLoginViewController = authStoryBoard.instantiateViewControllerWithIdentifier("AuthLogin") 
            self.window?.rootViewController = authLoginViewController
        } else {
            let mainTabBarViewController:UITabBarController = mainStoryBoard.instantiateViewControllerWithIdentifier("MainTabBarController") as! UITabBarController
            
            self.window?.rootViewController = mainTabBarViewController
            
        }
        
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: const_CognitoRegionType, identityPoolId: const_CognitoIdentityPoolId)
        let configuration = AWSServiceConfiguration(region: const_DefaultServiceRegionType, credentialsProvider: credentialsProvider)
        AWSServiceManager.defaultServiceManager().defaultServiceConfiguration = configuration
        
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Badge, .Alert, .Sound], categories: nil))
        UIApplication.sharedApplication().registerForRemoteNotifications()
        
        if !NSUserDefaults.standardUserDefaults().boolForKey("HasLaunchedOnce") {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "HasLaunchedOnce")
            NSUserDefaults.standardUserDefaults().synchronize()
            // functions which need to run at the first time app launch
            ContactAPIHelper().syncContactList()
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        // return WXApi.handleOpenURL(url, delegate: self)
        return WeiboSDK.handleOpenURL(url, delegate: self)
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        // return WXApi.handleOpenURL(url, delegate: self)
        return WeiboSDK.handleOpenURL(url, delegate: self)
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let tokenStr = dataToHex(deviceToken)
        print(tokenStr)
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print(error)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print(userInfo)
    }
    
    func dataToHex(data: NSData) -> String
    {
        var str: String = String()
        let p = UnsafePointer<UInt8>(data.bytes)
        let len = data.length
        
        for var i=0; i<len; ++i {
            str += String(format: "%02.2X", p[i])
        }
        return str
    }
    
    /*
    
    func onReq(req: BaseReq!) {
        
    }
    
    func onResp(resp: BaseResp!) {
        
    }

    */
    
    func didReceiveWeiboRequest(request: WBBaseRequest!) {
        
    }
    
    func didReceiveWeiboResponse(response: WBBaseResponse!) {
        if response.isKindOfClass(WBSendMessageToWeiboResponse) {
            print(1)
            let sendMessageToWeiboResponse:WBSendMessageToWeiboResponse = response as! WBSendMessageToWeiboResponse
            let accessToken = sendMessageToWeiboResponse.authResponse.accessToken
            print("accessToken:\(accessToken)")
            let userID = sendMessageToWeiboResponse.authResponse.userID
            print("userID:\(userID)")
        } else if response.isKindOfClass(WBAuthorizeResponse) {
            let authResponse = response as! WBAuthorizeResponse
            let accessToken = authResponse.accessToken
            let userID = authResponse.userID
            VendorLoginAPICall(view: authLoginViewController.view, vendorType: "wb", vendorId: userID, accessToken: accessToken).run()
        }
        
    }

}

