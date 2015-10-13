//
//  SelectContactsTableUIHelper.swift
//  pigeon
//
//  Created by Liu, Naitian on 10/12/15.
//  Copyright © 2015 naitianliu. All rights reserved.
//

import Foundation
import SDWebImage

class SelectContactsTableUIHelper: NSObject {
    
    var rootView:UIView!
    
    let cellHeight:CGFloat = 60
    
    init(view:UIView) {
        super.init()
        
        self.rootView = view
        
    }
    
    func setupCell(cell:UITableViewCell, contactInfo:[String:AnyObject]) {
        let nickname:String = contactInfo["nickname"] as! String
        let imgURL:String = contactInfo["img_url"] as! String
        let selected:Bool = contactInfo["selected"] as! Bool
        // set selectImageView
        let selectImageView:UIImageView = UIImageView(frame: CGRect(x: 30, y: 15, width: 30, height: 30))
        if selected {
            selectImageView.image = UIImage(named: "checked")
        } else {
            selectImageView.image = UIImage(named: "unchecked")
        }
        cell.contentView.addSubview(selectImageView)
        // set profileImageView
        let profileImageView:UIImageView = UIImageView(frame: CGRect(x: selectImageView.frame.origin.x + selectImageView.frame.width + 20, y: 10, width: 40, height: 40))
        profileImageView.sd_setImageWithURL(NSURL(string: imgURL), placeholderImage: UIImage(named: "Apple"))
        cell.contentView.addSubview(profileImageView)
        // set nicknameLabel
        let nicknameLabel:UILabel = UILabel(frame: CGRect(x: profileImageView.frame.origin.x + profileImageView.frame.width + 20, y: 10, width: 200, height: 40))
        nicknameLabel.font = UIFont.systemFontOfSize(20)
        nicknameLabel.text = nickname
        cell.contentView.addSubview(nicknameLabel)
    }
}