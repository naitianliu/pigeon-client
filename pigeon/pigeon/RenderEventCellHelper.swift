//
//  RenderEventCellHelper.swift
//  pigeon
//
//  Created by Liu, Naitian on 9/3/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import Foundation
import SDWebImage
import VENSeparatorView
import STTweetLabel

class RenderEventCellHelper:NSObject {
    
    var view:UIView!
    var cell:UITableViewCell!
    var viewRect:CGRect!
    var innerView:VENSeparatorView!
    
    let paddingLeft:CGFloat = 10
    let paddingTop:CGFloat = 5
    let paddingGap:CGFloat = 5
    let profileViewHeight:CGFloat = 50
    
    var messageViewHeight:CGFloat!
    var eventViewHeight:CGFloat!
    var pictureViewHeight:CGFloat!
    
    let bgColor:UIColor = UIColor(red: 0.937255, green: 0.937255, blue: 0.956863, alpha: 1.0)
    let eventBgColor:UIColor = UIColor(red: 245/256, green: 245, blue: 256, alpha: 245/256)
    
    var postInfo:[String:AnyObject]!
    
    var editorName:String!
    var editorImgUrl:String!
    var message:String!
    var time:String!
    var pictureUrls:[String]!
    var eventType:String!
    var eventDescription:String!
    
    var eventButton:UIButton!
    var pictureView:UIView!
    var pictureButtonArray:[UIButton]!
    
    init(view:UIView, postInfo:[String:AnyObject]) {
        super.init()
        
        self.view = view
        self.postInfo = postInfo
        self.editorName = self.postInfo["editorName"] as! String
        self.editorImgUrl = self.postInfo["editorImgUrl"] as! String
        self.message = self.postInfo["message"] as! String
        self.time = self.postInfo["time"] as! String
        self.pictureUrls = self.postInfo["pictureUrls"] as! [String]
        self.eventType = self.postInfo["eventType"] as! String
        self.eventDescription = self.postInfo["description"] as! String
    }
    
    func setCell(cell:UITableViewCell, view:UIView) {
        self.cell = cell
        self.cell.contentView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: self.getCellHeight())
        self.viewRect = self.cell.contentView.frame
        self.cell.contentView.backgroundColor = bgColor
        self.cell.selectionStyle = UITableViewCellSelectionStyle.Gray
        self.cell.separatorInset = UIEdgeInsetsZero
        self.cell.layoutMargins = UIEdgeInsetsZero
        self.cell.preservesSuperviewLayoutMargins = false
        self.cell.backgroundColor = UIColor.clearColor()
        self.cell.backgroundView?.backgroundColor = UIColor.clearColor()
        let innerViewFrame:CGRect = CGRect(x: self.viewRect.origin.x + paddingLeft, y: self.viewRect.origin.y + paddingTop, width: self.viewRect.width - 2 * paddingLeft, height: self.viewRect.height - 2 * paddingTop)
        self.innerView = VENSeparatorView(frame: innerViewFrame, topLineSeparatorType: VENSeparatorType.None, bottomLineSeparatorType: VENSeparatorType.Jagged)
        self.innerView.fillColor = bgColor
        self.innerView.bottomStrokeColor = UIColor.lightGrayColor()
        self.innerView.backgroundColor = UIColor.whiteColor()
        self.cell.contentView.addSubview(self.innerView)
        
        self.setLatestMessage()
        self.setEventInfo()
    }
    
    func getCellHeight() -> CGFloat {
        self.pictureViewHeight = 0
        if self.pictureUrls.count != 0 {
            self.pictureViewHeight = (self.view.frame.width - 40 - 4) / 3
        }
        let messageLabel = self.initMessageLabel()
        let descriptionView = self.initEventDescriptionView()
        let height:CGFloat! = profileViewHeight + messageLabel.frame.height + self.pictureViewHeight + descriptionView.frame.height + 50
        return height
    }
    
    private func addDashedBorder() -> CAShapeLayer {
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let shapeRect:CGRect = CGRect(x: 0, y: profileViewHeight, width: self.innerView.frame.width, height: 0.5)
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: self.innerView.frame.width/2, y: profileViewHeight)
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = UIColor.grayColor().CGColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineDashPattern = [10, 5]
        let path:UIBezierPath = UIBezierPath(roundedRect: shapeRect, cornerRadius: 0)
        shapeLayer.path = path.CGPath
        return shapeLayer
    }
    
    func setLatestMessage() {
        let imageView:UIImageView = UIImageView(frame: CGRect(x: 10, y: 5, width: 40, height: 40))
        imageView.sd_setImageWithURL(NSURL(string: self.editorImgUrl), placeholderImage: UIImage(named: "Apple"))
        imageView.layer.borderColor = UIColor.whiteColor().CGColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        self.innerView.addSubview(imageView)
        
        let nameLabel:UILabel = UILabel(frame: CGRect(x: 60, y: 8, width: self.viewRect.width - 160, height: 17))
        nameLabel.font = UIFont(name: "Heiti SC", size: 15)
        nameLabel.text = self.editorName
        self.innerView.addSubview(nameLabel)
        
        let timeLabel:UILabel = UILabel(frame: CGRect(x: 60, y: 25, width: 100, height: 20))
        timeLabel.textAlignment = NSTextAlignment.Left
        timeLabel.textColor = UIColor.grayColor()
        timeLabel.font = UIFont(name: "Arial", size: 10)
        timeLabel.text = self.time
        self.innerView.addSubview(timeLabel)
        
        let messageLabel:UILabel = self.initMessageLabel()
        self.innerView.addSubview(messageLabel)
        
        let pictureView:UIView = self.initPicturesView()
        self.innerView.addSubview(pictureView)
    }
    
    private func initMessageLabel() -> UILabel {
        let content:NSString = self.message
        let contentSize:CGSize = content.boundingRectWithSize(CGSize(width: self.view.frame.width - 40, height: CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(15)], context: nil).size
        let lineNum:Int = Int(contentSize.height / 15)
        self.messageViewHeight = contentSize.height + CGFloat(5 * lineNum)
        let style:NSMutableParagraphStyle = NSMutableParagraphStyle()
        style.lineSpacing = 5
        let attributedText:NSAttributedString = NSAttributedString(string: self.message, attributes: [NSParagraphStyleAttributeName: style])
        let messageLabel:UILabel = UILabel(frame: CGRect(x: 10, y: 55, width: contentSize.width, height: self.messageViewHeight))
        messageLabel.numberOfLines = lineNum
        messageLabel.font = UIFont(name: "Heiti SC", size: 15)
        messageLabel.textColor = UIColor.blackColor()
        messageLabel.attributedText = attributedText
        
        return messageLabel
    }
    
    private func initPicturesView() -> UIView {
        let pictureViewHeight:CGFloat = (self.innerView.frame.width - 20 - 4) / 3
        self.pictureViewHeight = pictureViewHeight
        let view:UIView = UIView(frame: CGRect(x: 10, y: self.profileViewHeight + self.messageViewHeight + 10, width: self.innerView.frame.width - 20, height: self.pictureViewHeight))
        if self.pictureUrls.count == 0 {
            view.hidden = true
            self.pictureViewHeight = 0
        } else if self.pictureUrls.count == 1 {
            let btnView1:UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: pictureViewHeight, height: pictureViewHeight))
            btnView1.sd_setImageWithURL(NSURL(string: self.pictureUrls[0]), forState: UIControlState.Normal, placeholderImage: UIImage(named: "Apple"))
            btnView1.imageView!.contentMode = UIViewContentMode.ScaleAspectFill
            btnView1.imageView!.layer.masksToBounds = true
            view.addSubview(btnView1)
            self.pictureButtonArray = [btnView1]
        } else if self.pictureUrls.count == 2 {
            let btnView1:UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: pictureViewHeight, height: pictureViewHeight))
            let btnView2:UIButton = UIButton(frame: CGRect(x: pictureViewHeight + 2, y: 0, width: pictureViewHeight, height: pictureViewHeight))
            btnView1.sd_setImageWithURL(NSURL(string: self.pictureUrls[0]), forState: UIControlState.Normal, placeholderImage: UIImage(named: "Apple"))
            btnView2.sd_setImageWithURL(NSURL(string: self.pictureUrls[1]), forState: UIControlState.Normal, placeholderImage: UIImage(named: "Apple"))
            btnView1.imageView!.contentMode = UIViewContentMode.ScaleAspectFill
            btnView2.imageView!.contentMode = UIViewContentMode.ScaleAspectFill
            btnView1.imageView!.layer.masksToBounds = true
            btnView2.imageView!.layer.masksToBounds = true
            view.addSubview(btnView1)
            view.addSubview(btnView2)
            self.pictureButtonArray = [btnView1, btnView2]
        } else {
            let btnView1:UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: pictureViewHeight, height: pictureViewHeight))
            let btnView2:UIButton = UIButton(frame: CGRect(x: pictureViewHeight + 2, y: 0, width: pictureViewHeight, height: pictureViewHeight))
            let btnView3:UIButton = UIButton(frame: CGRect(x: pictureViewHeight * 2 + 4, y: 0, width: pictureViewHeight, height: pictureViewHeight))
            btnView1.sd_setImageWithURL(NSURL(string: self.pictureUrls[0]), forState: UIControlState.Normal, placeholderImage: UIImage(named: "Apple"))
            btnView2.sd_setImageWithURL(NSURL(string: self.pictureUrls[1]), forState: UIControlState.Normal, placeholderImage: UIImage(named: "Apple"))
            btnView3.sd_setImageWithURL(NSURL(string: self.pictureUrls[2]), forState: UIControlState.Normal, placeholderImage: UIImage(named: "Apple"))
            btnView1.imageView!.contentMode = UIViewContentMode.ScaleAspectFill
            btnView2.imageView!.contentMode = UIViewContentMode.ScaleAspectFill
            btnView3.imageView!.contentMode = UIViewContentMode.ScaleAspectFill
            btnView1.imageView!.layer.masksToBounds = true
            btnView2.imageView!.layer.masksToBounds = true
            btnView3.imageView!.layer.masksToBounds = true
            view.addSubview(btnView1)
            view.addSubview(btnView2)
            view.addSubview(btnView3)
            self.pictureButtonArray = [btnView1, btnView2, btnView3]
        }
        return view
    }
    
    func setEventInfo() {
        let eventView:UIView = self.initEventDescriptionView()
        eventButton = UIButton(type: UIButtonType.System)
        eventButton.frame = eventView.frame
        self.innerView.addSubview(eventView)
        self.innerView.addSubview(eventButton)
    }
    
    private func initEventDescriptionView() -> UIView {
        let fontSize:CGFloat = 13
        let viewWidth:CGFloat = self.view.frame.width - 60
        let content:NSString = "\(self.eventType): \(self.eventDescription)"
        let contentSize:CGSize = content.boundingRectWithSize(CGSize(width: viewWidth, height: CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(fontSize)], context: nil).size
        let lineNum:Int = Int(contentSize.height / fontSize)
        self.eventViewHeight = contentSize.height + CGFloat(3 * lineNum) + 10
        let eventView:UIView = UIView(frame: CGRect(x: 20, y: 10 + self.profileViewHeight + self.messageViewHeight + self.pictureViewHeight + 10, width: viewWidth, height: self.eventViewHeight))
        eventView.backgroundColor = bgColor
        let style:NSMutableParagraphStyle = NSMutableParagraphStyle()
        style.lineSpacing = 3
        let attributedText:NSAttributedString = NSAttributedString(string: content as String, attributes: [NSParagraphStyleAttributeName: style])
        let descriptionLabel:UILabel = UILabel(frame: CGRect(x: 5, y: 5, width: eventView.frame.width - 10, height: self.eventViewHeight - 10))
        descriptionLabel.attributedText = attributedText
        descriptionLabel.textColor = UIColor.grayColor()
        descriptionLabel.numberOfLines = lineNum
        descriptionLabel.font = UIFont(name: "Heiti SC", size: fontSize)
        eventView.addSubview(descriptionLabel)
        return eventView
    }
    
    
}


