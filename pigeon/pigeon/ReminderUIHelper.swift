//
//  ReminderUIHelper.swift
//  pigeon
//
//  Created by Liu, Naitian on 10/11/15.
//  Copyright © 2015 naitianliu. All rights reserved.
//

import Foundation
import SDWebImage

class ReminderUIHelper: NSObject {
    
    var rootView:UIView!
    
    var descriptionViewHeight:CGFloat = 46
    
    init(view:UIView) {
        super.init()
        
        self.rootView = view
    }
    
    func setupDescriptionView(description:String, nickname:String, imgUrl:String) -> UIView {
        
        let profileImageView:UIImageView = UIImageView(frame: CGRect(x: 20, y: 10, width: 30, height: 30))
        profileImageView.sd_setImageWithURL(NSURL(string: imgUrl), placeholderImage: UIImage(named: "Apple"))
        
        let nicknameLabel:UILabel = UILabel(frame: CGRect(x: profileImageView.frame.origin.x + profileImageView.frame.width + 10, y: profileImageView.frame.origin.y, width: 200, height: profileImageView.frame.height))
        nicknameLabel.text = nickname
        
        let content:NSString = "\(description)"
        let contentSize:CGSize = content.boundingRectWithSize(CGSize(width: self.rootView.frame.width - 60, height: CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(17)], context: nil).size
        let lineNum:Int = Int(contentSize.height / 17)
        let descriptionLabelHeight = contentSize.height + CGFloat(3*lineNum) + 30
        let style:NSMutableParagraphStyle = NSMutableParagraphStyle()
        style.lineSpacing = 3
        let attributedText:NSAttributedString = NSAttributedString(string: content as String, attributes: [
            NSParagraphStyleAttributeName: style,
            NSForegroundColorAttributeName: UIColor.blackColor()
            ])
        
        let descriptionLabel:UILabel = UILabel(frame: CGRect(x: 30, y: 50, width: contentSize.width, height: contentSize.height + 20))
        descriptionLabel.attributedText = attributedText
        descriptionLabel.numberOfLines = 0
        
        var bubbleImg:UIImage! = UIImage(named: "bubble")
        bubbleImg = bubbleImg.stretchableImageWithLeftCapWidth(40, topCapHeight: 40)
        let bubbleImageView:UIImageView = UIImageView(image: bubbleImg)
        bubbleImageView.autoresizesSubviews = false
        bubbleImageView.frame = CGRect(x: 20, y: 40, width: contentSize.width + 20, height: descriptionLabelHeight)
        
        self.descriptionViewHeight = bubbleImageView.frame.height + 70
        let view:UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.rootView.frame.width, height: self.descriptionViewHeight))
        view.addSubview(profileImageView)
        view.addSubview(nicknameLabel)
        view.addSubview(bubbleImageView)
        view.addSubview(descriptionLabel)
        return view
    }
}