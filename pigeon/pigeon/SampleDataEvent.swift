//
//  SampleDataEvent.swift
//  pigeon
//
//  Created by Liu, Naitian on 9/3/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import Foundation

class SampleDataEvent: NSObject {
    let myProfileURL1:String = "http://tp3.sinaimg.cn/2525851962/180/40000907046/1"
    
    let eventList = [
        [
            "creator_name": "Naitian Liu",
            "creator_img_url": "",
            "location": [],
            "description": "",
            "date": "",
            "members": []
        ]
    ]
    
    let newPosts = [
        [
            "editorName": "刘乃天",
            "editorImgUrl": "http://tp3.sinaimg.cn/2525851962/180/40000907046/1",
            "message": "《人工智能和机器学习领域有哪些有趣的开源项目？》本文简要介绍了10款Quora上网友推荐的人工智能和机器学习领域方面的开源项目",
            "time": "昨天上午 9:30",
            "pictureUrls": [
                "http://ww3.sinaimg.cn/bmiddle/976b8e2cjw1evsmj1bl82j20dc08wjrw.jpg",
                "https://s3-us-west-1.amazonaws.com/banyansocial/064E906C-7136-4AF4-A033-1536E6A2E8F8-67000-00029EDC7E24F4C0.png",
                "http://n.sinaimg.cn/transform/20150906/k8aV-fxhqhui4859382.jpg"
            ],
            "description": "机器学习相关资料分享",
            "eventType": "话题",
        ],
        [
            "editorName": "周鸿祎",
            "editorImgUrl": "http://tp2.sinaimg.cn/1708942053/180/5704028689/1",
            "message": "欢迎大家写下使用感受，褒奖或批评都能让我们继续优化体验//@360奇酷手机:#360奇酷手机# 绝对是性价比超高的一款千元机！",
            "time": "昨天上午 10:54",
            "pictureUrls": [
                "http://tp4.sinaimg.cn/1998321847/180/5734749366/0"
            ],
            "description": "360奇酷手机, 观阅兵式心情很是澎湃。没有老一辈的浴血奋战，就没有和平安定的今天。吾辈定当珍惜、奋斗。再一次向老兵们致以最高的敬意。",
            "eventType": "话题",
        ],

    ]
    
    let eventInfo = [
        "memberImgUrls": [
            "http://tp3.sinaimg.cn/2525851962/180/40000907046/1",
            "http://tp2.sinaimg.cn/1708942053/180/5704028689/1",
        ]
    ]
    
    let eventPosts = [
        [
            "editorName": "刘乃天",
            "editorImgUrl": "http://tp3.sinaimg.cn/2525851962/180/40000907046/1",
            "message": "《人工智能和机器学习领域有哪些有趣的开源项目？》本文简要介绍了10款Quora上网友推荐的人工智能和机器学习领域方面的开源项目",
            "time": "昨天上午 9:30",
            "pictureUrls": [
                "http://ww3.sinaimg.cn/bmiddle/976b8e2cjw1evsmj1bl82j20dc08wjrw.jpg",
                "http://ww4.sinaimg.cn/bmiddle/6a8c1e07gw1evrw31vpprj20rs0kuaf2.jpg",
                "http://n.sinaimg.cn/transform/20150906/k8aV-fxhqhui4859382.jpg"
            ],
        ],
        [
            "editorName": "周鸿祎",
            "editorImgUrl": "http://tp2.sinaimg.cn/1708942053/180/5704028689/1",
            "message": "欢迎大家写下使用感受，褒奖或批评都能让我们继续优化体验//@360奇酷手机:#360奇酷手机# 绝对是性价比超高的一款千元机！",
            "time": "昨天上午 10:54",
            "pictureUrls": [
                "http://tp4.sinaimg.cn/1998321847/180/5734749366/0"
            ]
        ],
    ]
    
    let commentList = [
        [
            "editorName": "Naitian Liu",
            "time": "1:23PM, today",
            "message": "Any updates on this? This is blocking our release",
            "imgUrls": []
        ],
        [
            "editorName": "Bill Gates",
            "time": "2:18PM, today",
            "message": "Forced a reboot/reset on host. Was able to RDP after reset completed. Checked host to insure updates were completed.",
            "imgUrls": []
        ],
        [
            "editorName": "Devin Wenig",
            "time": "4:43PM, today",
            "message": "Job completed. RDP working. Examining host for details. Symantec was in a bad state. Fixed. System reported incomplete updates (Microsoft) but after a time these completed. Suspect it was an issue with installing updates from Microsoft and the reboot/reset fixed it. Resolving ticket.",
            "imgUrls": []
        ]
    ]

}


