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
import TTTAttributedLabel

class ReminderCellViewHelper: NSObject {
    
    var rootViewController:MyEventsViewController!
    var cell:UITableViewCell!
    var viewRect:CGRect!
    var innerView:VENSeparatorView!
    var innerViewFrame:CGRect!
    
    var actionButton:UIButton = UIButton(type: .InfoLight)
    
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
    
    var delegate:TTTAttributedLabelDelegate?
    
    init(rootViewController:MyEventsViewController, delegate:TTTAttributedLabelDelegate, eventInfo:[String:AnyObject]) {
        super.init()
        
        self.rootViewController = rootViewController
        self.delegate = delegate
        
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
        let height:CGFloat = self.headerViewHeight + self.contentLabelHeight + self.latestActionViewHeight + 50
        return height
    }
    
    private func initHeaderView() -> UIView {
        let view:UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.rootViewController.view.frame.width - 20, height: self.headerViewHeight))
        // rminder icon image view
        let reminderIconImageView:UIImageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 40, height: 40))
        reminderIconImageView.image = UIImage(named: "reminder-icon")
        // label - reminder
        let label1:UILabel = UILabel(frame: CGRect(x: 50, y: 15, width: 200, height: 20))
        label1.text = "提醒"
        // reminder action button
        self.actionButton.frame = CGRect(x: self.rootViewController.view.frame.width - 60, y: 15, width: 20, height: 20)
        // add subview
        view.addSubview(reminderIconImageView)
        view.addSubview(label1)
        view.addSubview(self.actionButton)
        return view
    }
    
    private func initContentLabel() -> UILabel {
        let creatorNickname = self.creatorInfo["nickname"]!
        let content:NSString = "\(creatorNickname): \(self.reminderContent)"
        let contentSize:CGSize = content.boundingRectWithSize(CGSize(width: self.rootViewController.view.frame.width - 40, height: CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(15)], context: nil).size
        let lineNum:Int = Int(contentSize.height / 17)
        self.contentLabelHeight = contentSize.height + CGFloat(3*lineNum) + 10
        print(self.contentLabelHeight)
        let style:NSMutableParagraphStyle = NSMutableParagraphStyle()
        style.lineSpacing = 3
        let attributedText:NSAttributedString = NSAttributedString(string: content as String, attributes: [
                NSParagraphStyleAttributeName: style,
                NSFontAttributeName: UIFont.systemFontOfSize(15),
                NSForegroundColorAttributeName: UIColor.grayColor()
            ])
        /*
        let messageLabel:UILabel = UILabel(frame: CGRect(x: 10, y: 55, width: contentSize.width, height: self.contentLabelHeight))
        messageLabel.numberOfLines = lineNum
        messageLabel.font = UIFont.systemFontOfSize(15)
        messageLabel.textColor = UIColor.blackColor()
        messageLabel.attributedText = attributedText
        */
        let messageLabel:TTTAttributedLabel = TTTAttributedLabel(frame: CGRect(x: 10, y: 55, width: contentSize.width, height: self.contentLabelHeight))
        messageLabel.delegate = self.delegate
        let linkAttributes = [
            NSForegroundColorAttributeName: UIColor.magentaColor(),
            NSUnderlineStyleAttributeName: NSNumber(bool:false),
            NSFontAttributeName: UIFont.boldSystemFontOfSize(16),
        ]
        messageLabel.enabledTextCheckingTypes = NSTextCheckingType.Link.rawValue
        messageLabel.numberOfLines = 0
        let messageText:NSString = "\(creatorNickname): \(self.reminderContent)"
        messageLabel.setText(attributedText)
        messageLabel.linkAttributes = linkAttributes
        let range:NSRange = messageText.rangeOfString(creatorNickname)
        messageLabel.addLinkToURL(NSURL(string: creatorNickname), withRange: range)
        return messageLabel
    }
    
    private func initLatestActionView() -> UIView {
        if self.comments.count > 0 {
            let latestCommentInfo = self.getLatestComment(self.comments)
            var commentContent:String!
            if latestCommentInfo["content"] != nil {
                commentContent = latestCommentInfo["content"] as! String
            } else {
                commentContent = ""
            }
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
            let actionLabel:UILabel = UILabel(frame: CGRect(x: 5, y: 5, width: self.rootViewController.view.frame.width - 50, height: 15))
            actionLabel.text = "\(editorNickname): \(actionStr)"
            actionLabel.font = UIFont.systemFontOfSize(14)
            
            let content:NSString = "\(editorNickname): \(commentContent)"
            let contentSize:CGSize = content.boundingRectWithSize(CGSize(width: self.rootViewController.view.frame.width - 50, height: CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(14)], context: nil).size
            let lineNum:Int = Int(contentSize.height / 14)
            let commentLabelHeight = contentSize.height + CGFloat(2*lineNum)
            let style:NSMutableParagraphStyle = NSMutableParagraphStyle()
            style.lineSpacing = 2
            let attributedText:NSAttributedString = NSAttributedString(string: content as String, attributes: [NSParagraphStyleAttributeName: style])
            let messageLabel:UILabel = UILabel(frame: CGRect(x: 5, y: 20, width: contentSize.width, height: commentLabelHeight))
            messageLabel.numberOfLines = lineNum
            messageLabel.font = UIFont.systemFontOfSize(14)
            messageLabel.textColor = UIColor.lightGrayColor()
            messageLabel.attributedText = attributedText
            messageLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
            self.latestActionViewHeight = 30 + commentLabelHeight
            let view:UIView = UIView(frame: CGRect(x: 10, y: self.headerViewHeight + self.contentLabelHeight + 20, width: self.rootViewController.view.frame.width - 40 , height: self.latestActionViewHeight))
            view.backgroundColor = UIColor.lightTextColor()
            view.addSubview(actionLabel)
            view.addSubview(messageLabel)
            return view
        } else {
            self.latestActionViewHeight = 10
            let view:UIView = UIView(frame: CGRect(x: 10, y: self.headerViewHeight + self.contentLabelHeight + 20, width: self.rootViewController.view.frame.width - 40 , height: self.latestActionViewHeight))
            return view
        }
        
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