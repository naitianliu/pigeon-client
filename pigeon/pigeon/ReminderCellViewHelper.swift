//
//  ReminderCellViewHelper.swift
//  pigeon
//
//  Created by Liu, Naitian on 10/6/15.
//  Copyright © 2015 naitianliu. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import VENSeparatorView

class ReminderCellViewHelper: NSObject {
    
    var rootViewController:UIViewController!
    var cell:UITableViewCell!
    var viewRect:CGRect!
    var innerView:VENSeparatorView!
    var innerViewFrame:CGRect!
    
    let bgColor:UIColor = UIColor(red: 0.937255, green: 0.937255, blue: 0.956863, alpha: 1.0)
    let paddingLeft:CGFloat = 10
    let paddingTop:CGFloat = 5
    let paddingGap:CGFloat = 5
    
    let headerViewHeight:CGFloat = 50
    var headerView:UIView!
    var contentLabelHeight:CGFloat!
    var contentLabel:UILabel!
    var latestActionViewHeight:CGFloat!
    var latestActionView:UIView!
    
    var creatorInfo:[String:String]!
    var reminderContent:String!
    var comments:[AnyObject]!
    
    init(rootViewController:UIViewController, eventInfo:[String:AnyObject]) {
        super.init()
        
        self.rootViewController = rootViewController
        let infoDict = eventInfo["info"] as! [String:AnyObject]
        self.creatorInfo = infoDict["creator_info"]! as! [String : String]
        self.reminderContent = infoDict["reminder_content"] as! String
        self.comments = eventInfo["comments"] as! [AnyObject]
        
        self.headerView = self.initHeaderView()
        self.contentLabel = self.initContentLabel()
        self.latestActionView = self.initLatestActionView()
        
    }
    
    func setupCell(cell:UITableViewCell) {
        self.cell = cell
        self.cell.contentView.frame = CGRect(x: 0, y: 0, width: self.rootViewController.view.frame.width, height: self.getCellHeight())
        self.viewRect = self.cell.contentView.frame
        self.cell.contentView.backgroundColor = bgColor
        self.cell.selectionStyle = UITableViewCellSelectionStyle.Gray
        self.cell.separatorInset = UIEdgeInsetsZero
        self.cell.layoutMargins = UIEdgeInsetsZero
        self.cell.preservesSuperviewLayoutMargins = false
        self.cell.backgroundColor = UIColor.clearColor()
        self.cell.backgroundView?.backgroundColor = UIColor.clearColor()
        self.innerViewFrame = CGRect(x: self.viewRect.origin.x + paddingLeft, y: self.viewRect.origin.y + paddingTop, width: self.viewRect.width - 2 * paddingLeft, height: self.viewRect.height - 2 * paddingTop)
        self.innerView = VENSeparatorView(frame: innerViewFrame, topLineSeparatorType: VENSeparatorType.None, bottomLineSeparatorType: VENSeparatorType.Jagged)
        self.innerView.fillColor = bgColor
        self.innerView.bottomStrokeColor = UIColor.lightGrayColor()
        self.innerView.backgroundColor = UIColor.whiteColor()
        self.cell.contentView.addSubview(self.innerView)
        self.innerView.addSubview(self.headerView)
        self.innerView.addSubview(self.contentLabel)
        self.innerView.addSubview(self.latestActionView)
    }
    
    func getCellHeight() -> CGFloat {
        let height:CGFloat = self.headerViewHeight + self.contentLabelHeight + self.latestActionViewHeight
        return height
    }
    
    private func initHeaderView() -> UIView {
        let view:UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.rootViewController.view.frame.width - 20, height: self.headerViewHeight))
        let reminderIconImageView:UIImageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 40, height: 40))
        reminderIconImageView.image = UIImage(named: "reminder-icon")
        let label1:UILabel = UILabel(frame: CGRect(x: 50, y: 15, width: 200, height: 20))
        label1.text = "提醒"
        view.addSubview(reminderIconImageView)
        view.addSubview(label1)
        return view
    }
    
    private func initContentLabel() -> UILabel {
        let creatorNickname = self.creatorInfo["user_id"]!
        let content:NSString = "\(creatorNickname): \(self.reminderContent)"
        let contentSize:CGSize = content.boundingRectWithSize(CGSize(width: self.rootViewController.view.frame.width - 40, height: CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(15)], context: nil).size
        let lineNum:Int = Int(contentSize.height / 15)
        self.contentLabelHeight = contentSize.height + CGFloat(5 * lineNum)
        let style:NSMutableParagraphStyle = NSMutableParagraphStyle()
        style.lineSpacing = 5
        let attributedText:NSAttributedString = NSAttributedString(string: content as String, attributes: [NSParagraphStyleAttributeName: style])
        let messageLabel:UILabel = UILabel(frame: CGRect(x: 10, y: 55, width: contentSize.width, height: self.contentLabelHeight))
        messageLabel.numberOfLines = lineNum
        messageLabel.font = UIFont(name: "Heiti SC", size: 15)
        messageLabel.textColor = UIColor.blackColor()
        messageLabel.attributedText = attributedText
        
        return messageLabel
    }
    
    private func initLatestActionView() -> UIView {
        let latestCommentInfo = self.getLatestComment(self.comments)
        let commentContent:String = latestCommentInfo["content"] as! String
        let action:Int = latestCommentInfo["action"] as! Int
        var actionStr = ""
        switch action {
        case 2:
            actionStr = "推迟"
            break
        default:
            break
        }
        let time:Int = latestCommentInfo["time"] as! Int
        let editorInfo:[String:String] = latestCommentInfo["editor_info"] as! [String:String]
        let editorNickname:String = editorInfo["nickname"]!
        let actionLabel:UILabel = UILabel(frame: CGRect(x: 5, y: 5, width: self.rootViewController.view.frame.width - 40, height: 15))
        actionLabel.text = "\(editorNickname): \(actionStr)"
        
        let content:NSString = "\(editorNickname): \(commentContent)"
        let contentSize:CGSize = content.boundingRectWithSize(CGSize(width: self.rootViewController.view.frame.width - 40, height: CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(15)], context: nil).size
        let lineNum:Int = Int(contentSize.height / 15)
        let contentLabelHeight = contentSize.height + CGFloat(5 * lineNum)
        let style:NSMutableParagraphStyle = NSMutableParagraphStyle()
        style.lineSpacing = 5
        let attributedText:NSAttributedString = NSAttributedString(string: content as String, attributes: [NSParagraphStyleAttributeName: style])
        let messageLabel:UILabel = UILabel(frame: CGRect(x: 10, y: 20, width: contentSize.width, height: contentLabelHeight))
        messageLabel.numberOfLines = lineNum
        messageLabel.font = UIFont(name: "Heiti SC", size: 15)
        messageLabel.textColor = UIColor.blackColor()
        messageLabel.attributedText = attributedText
        
        self.latestActionViewHeight = 20 + contentLabelHeight
        let view:UIView = UIView(frame: CGRect(x: 10, y: self.headerViewHeight + self.contentLabelHeight + 10, width: self.rootViewController.view.frame.width - 40 , height: latestActionViewHeight))
        view.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(actionLabel)
        view.addSubview(messageLabel)
        return view
    }
    
    private func getLatestComment(comments:[AnyObject]) -> [String:AnyObject] {
        var latestCommentInfo:[String:AnyObject] = [:]
        var tempTime:Int = 0
        for comment in comments {
            let commentInfo = comment as! [String:AnyObject]
            let time:Int = commentInfo["time"] as! Int
            if time > tempTime {
                tempTime = time
                latestCommentInfo = commentInfo
            }
        }
        return latestCommentInfo
    }
    

}