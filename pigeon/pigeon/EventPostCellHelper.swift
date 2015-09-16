//
//  EventPostsCellHelper.swift
//  pigeon
//
//  Created by Liu, Naitian on 9/6/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import Foundation

class EventPostCellHelper: NSObject {
    
    var view:UIView!
    var cell:UITableViewCell!
    var viewRect:CGRect!
    var innerView:UIView!
    
    let paddingLeft:CGFloat = 10
    let paddingTop:CGFloat = 5
    let paddingGap:CGFloat = 5
    let profileViewHeight:CGFloat = 50
    
    var messageViewHeight:CGFloat!
    var pictureViewHeight:CGFloat!
    
    let bgColor:UIColor = UIColor(red: 0.937255, green: 0.937255, blue: 0.956863, alpha: 1.0)
    
    var eventPost:[String:AnyObject]!
    
    var editorName:String!
    var editorImgUrl:String!
    var message:String!
    var time:String!
    var pictureUrls:[String]!
    
    var pictureView:UIView!
    var pictureButtonArray:[UIButton]!
    
    init(view:UIView, eventPost:[String:AnyObject]) {
        super.init()
        
        self.view = view
        self.eventPost = eventPost
        self.editorName = self.eventPost["editorName"] as! String
        self.editorImgUrl = self.eventPost["editorImgUrl"] as! String
        self.message = self.eventPost["message"] as! String
        self.time = self.eventPost["time"] as! String
        self.pictureUrls = self.eventPost["pictureUrls"] as! [String]
    }
    
    func setupCell(cell:UITableViewCell) {
        self.cell = cell
        self.cell.contentView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.getCellHeight())
        self.viewRect = self.cell.contentView.frame
        self.cell.contentView.backgroundColor = bgColor
        self.cell.selectionStyle = UITableViewCellSelectionStyle.Gray
        self.cell.separatorInset = UIEdgeInsetsZero
        self.cell.layoutMargins = UIEdgeInsetsZero
        self.cell.preservesSuperviewLayoutMargins = false
        self.cell.backgroundColor = UIColor.clearColor()
        self.cell.backgroundView?.backgroundColor = UIColor.clearColor()
        let innerViewFrame:CGRect = CGRect(x: self.viewRect.origin.x + paddingLeft, y: self.viewRect.origin.y + paddingTop, width: self.viewRect.width - 2 * paddingLeft, height: self.viewRect.height - 2 * paddingTop)
        self.innerView = UIView(frame: innerViewFrame)
        self.innerView.backgroundColor = UIColor.whiteColor()
        self.cell.contentView.addSubview(self.innerView)
        
        self.setLatestMessage()
    }
    
    func getCellHeight() -> CGFloat {
        self.pictureViewHeight = 0
        if self.pictureUrls.count != 0 {
            self.pictureViewHeight = (self.view.frame.width - 40 - 4) / 3
        }
        let messageLabel = self.initMessageLabel()
        let height:CGFloat! = profileViewHeight + messageLabel.frame.height + self.pictureViewHeight + 50
        return height
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


}