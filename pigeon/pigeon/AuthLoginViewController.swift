//
//  AuthLoginViewController.swift
//  pigeon
//
//  Created by Liu, Naitian on 8/21/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import UIKit
import Alamofire

class AuthLoginViewController: UIViewController, WeiboSDKDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func weixinLoginOnClick(sender: AnyObject) {
        let req:SendAuthReq = SendAuthReq()
        req.scope = "snsapi_userinfo"
        req.state = "123"
        WXApi.sendReq(req)
    }
    
    @IBAction func weiboLoginOnClick(sender: AnyObject) {
        let request:WBAuthorizeRequest = WBAuthorizeRequest()
        request.redirectURI = "https://api.weibo.com/oauth2/default.html"
        request.scope = "all"
        WeiboSDK.sendRequest(request)
    }
    
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
            VendorLoginAPICall(view: self.view, vendorType: "wb", vendorId: userID, accessToken: accessToken).run()
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
