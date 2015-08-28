//
//  AuthLoginViewController.swift
//  pigeon
//
//  Created by Liu, Naitian on 8/21/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import UIKit
import Alamofire

class AuthLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func weixinLoginOnClick(sender: AnyObject) {
        var req:SendAuthReq = SendAuthReq()
        req.scope = "snsapi_userinfo"
        req.state = "123"
        WXApi.sendReq(req)
    }
    
    @IBAction func weiboLoginOnClick(sender: AnyObject) {
        var request:WBAuthorizeRequest = WBAuthorizeRequest()
        request.redirectURI = "https://api.weibo.com/oauth2/default.html"
        request.scope = "all"
        WeiboSDK.sendRequest(request)
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
