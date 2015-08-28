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


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // WXApi.registerApp("wx6002977c97c410d4")
        println(1)
        WeiboSDK.enableDebugMode(true)
        println(2)
        WeiboSDK.registerApp("3675401007")
        println(3)
        
        
        let authLoginViewController:UIViewController = authStoryBoard.instantiateViewControllerWithIdentifier("AuthLogin") as! UIViewController
        
        self.window?.rootViewController = authLoginViewController
        
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

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        // return WXApi.handleOpenURL(url, delegate: self)
        return WeiboSDK.handleOpenURL(url, delegate: self)
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
            println(1)
            var sendMessageToWeiboResponse:WBSendMessageToWeiboResponse = response as! WBSendMessageToWeiboResponse
            var accessToken = sendMessageToWeiboResponse.authResponse.accessToken
            println("accessToken:\(accessToken)")
            var userID = sendMessageToWeiboResponse.authResponse.userID
            println("userID:\(userID)")
        } else if response.isKindOfClass(WBAuthorizeResponse) {
            println(2)
            var authResponse = response as! WBAuthorizeResponse
            var accessToken = authResponse.accessToken
            println("accessToken:\(accessToken)")
            var userID = authResponse.userID
            println("userID:\(userID)")
            println(authResponse.userInfo)

        }
        
    }

}

