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

class RenderEventCellHelper:NSObject {
    
    var cell:UITableViewCell!
    var viewRect:CGRect!
    var innerView:VENSeparatorView!
    
    let paddingLeft:CGFloat = 10
    let paddingTop:CGFloat = 5
    
    let topViewHeight:CGFloat = 60
    
    let bgColor:UIColor = UIColor(red: 0.937255, green: 0.937255, blue: 0.956863, alpha: 1.0)

    
    init(cell:UITableViewCell) {
        super.init()
        
        self.cell = cell
        self.viewRect = self.cell.contentView.frame
        self.cell.contentView.backgroundColor = bgColor
        self.cell.selectionStyle = UITableViewCellSelectionStyle.None
        self.cell.separatorInset = UIEdgeInsetsZero
        self.cell.layoutMargins = UIEdgeInsetsZero
        self.cell.preservesSuperviewLayoutMargins = false
        self.cell.backgroundColor = UIColor.clearColor()
        self.cell.backgroundView?.backgroundColor = UIColor.clearColor()
        var innerViewFrame:CGRect = CGRect(x: self.viewRect.origin.x + paddingLeft, y: self.viewRect.origin.y + paddingTop, width: self.viewRect.width - 2 * paddingLeft, height: self.viewRect.height - 2 * paddingTop)
        self.innerView = VENSeparatorView(frame: innerViewFrame, topLineSeparatorType: VENSeparatorType.None, bottomLineSeparatorType: VENSeparatorType.Jagged)
        self.innerView.fillColor = bgColor
        self.innerView.bottomStrokeColor = UIColor.lightGrayColor()
        self.innerView.backgroundColor = UIColor.whiteColor()
        // self.innerView.layer.shadowOffset = CGSize(width: 2, height: 2)
        // self.innerView.layer.shadowOpacity = 0.2
        // self.innerView.layer.shadowRadius = 2
        self.cell.contentView.addSubview(self.innerView)
    }
    
    private func initSeparatorLine() {
        var view:UIView = UIView(frame: CGRect(x: 5, y: 61, width: self.viewRect.width - 20, height: 1))
        view.backgroundColor = UIColor.lightGrayColor()
        self.innerView.addSubview(view)
    }
    
    private func addDashedBorder() -> CAShapeLayer {
        var shapeLayer:CAShapeLayer = CAShapeLayer()
        var shapeRect:CGRect = CGRect(x: 0, y: topViewHeight, width: self.innerView.frame.width, height: 0.5)
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: self.innerView.frame.width/2, y: topViewHeight)
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = UIColor.grayColor().CGColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineDashPattern = [10, 5]
        var path:UIBezierPath = UIBezierPath(roundedRect: shapeRect, cornerRadius: 0)
        shapeLayer.path = path.CGPath
        return shapeLayer
    }
    
    func setLatestMessage(editorName:String, editorImgUrl:String, message:String, time:String) {
        var parentView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.innerView.frame.width, height: topViewHeight))
        
        var imageView:UIImageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 50, height: 50))
        imageView.sd_setImageWithURL(NSURL(string: editorImgUrl), placeholderImage: UIImage(named: "Apple"))
        parentView.addSubview(imageView)
        
        var nameLabel:UILabel = UILabel(frame: CGRect(x: 65, y: 7, width: self.viewRect.width - 160, height: 20))
        nameLabel.font = UIFont(name: "Heiti SC", size: 14)
        nameLabel.text = editorName
        parentView.addSubview(nameLabel)
        
        var messageLabel:UILabel = UILabel(frame: CGRect(x: 65, y: 30, width: self.viewRect.width - 100, height: 20))
        messageLabel.font = UIFont(name: "Heiti SC", size: 12)
        messageLabel.textColor = UIColor.grayColor()
        messageLabel.text = message
        self.innerView.addSubview(messageLabel)
        
        var timeLabel:UILabel = UILabel(frame: CGRect(x: self.viewRect.width - 90, y: 7, width: 60, height: 20))
        timeLabel.textAlignment = NSTextAlignment.Right
        timeLabel.textColor = UIColor.grayColor()
        timeLabel.font = UIFont(name: "Arial", size: 12)
        timeLabel.text = time
        self.innerView.addSubview(timeLabel)
        
        self.innerView.addSubview(parentView)
    }
    
    func setEventInfo(description:String, location:String?, time:String?, ) {
        
    }
}